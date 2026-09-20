import UIKit
import Flutter
import GoogleMaps
import Vision

@main
@objc class AppDelegate: FlutterAppDelegate {
  // Blur overlay hiding NDIS PII from the iOS app-switcher snapshot
  // (iOS has no FLAG_SECURE equivalent — this is the platform answer).
  private var privacyBlurView: UIVisualEffectView?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if let apiKey = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsAPIKey") as? String {
        GMSServices.provideAPIKey(apiKey)
    }
    
    guard let systemUIRegistrar = registrar(forPlugin: "SystemUIChannelPlugin") else {
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    let systemUIChannel = FlutterMethodChannel(
      name: "com.bishal.invoice/system_ui",
      binaryMessenger: systemUIRegistrar.messenger()
    )
    
    systemUIChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
      case "hideSystemUI":
        self.hideSystemUI()
        result(nil)
      case "showSystemUI":
        self.showSystemUI()
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    if let visionRegistrar = registrar(forPlugin: "VisionPlugin") {
      let visionChannel = FlutterMethodChannel(
        name: "com.bishal.invoice/vision",
        binaryMessenger: visionRegistrar.messenger()
      )
      visionChannel.setMethodCallHandler({ [weak self] (call, result) in
        guard call.method == "recognizeText" else {
          result(FlutterMethodNotImplemented)
          return
        }
        guard
          let args = call.arguments as? [String: Any],
          let path = args["path"] as? String
        else {
          result(FlutterError(code: "invalid_args", message: "Missing image path", details: nil))
          return
        }
        self?.recognizeText(path: path, result: result)
      })
    }
    
    GeneratedPluginRegistrant.register(with: self)
    self.registerDeviceSecurityChannel()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // MARK: - App-switcher privacy (PII snapshot protection)

  override func applicationWillResignActive(_ application: UIApplication) {
    super.applicationWillResignActive(application)
    guard privacyBlurView == nil, let window = self.window else { return }
    let blur = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    blur.frame = window.bounds
    blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    window.addSubview(blur)
    privacyBlurView = blur
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    super.applicationDidBecomeActive(application)
    privacyBlurView?.removeFromSuperview()
    privacyBlurView = nil
  }

  // MARK: - Device security posture (jailbreak detection, best-effort)

  /// Called from Dart via the device_security channel registrar below.
  private func registerDeviceSecurityChannel() {
    guard let registrar = self.registrar(forPlugin: "DeviceSecurityPlugin") else { return }
    let channel = FlutterMethodChannel(
      name: "com.bishal.invoice/device_security",
      binaryMessenger: registrar.messenger()
    )
    channel.setMethodCallHandler({ (call, result) in
      guard call.method == "getSecurityPosture" else {
        result(FlutterMethodNotImplemented)
        return
      }
      result(self.securityPosture())
    })
  }

  private func securityPosture() -> [String: Any] {
    var reasons: [String] = []

    // Classic jailbreak artifacts
    let suspectPaths = [
      "/Applications/Cydia.app",
      "/Applications/Sileo.app",
      "/Library/MobileSubstrate/MobileSubstrate.dylib",
      "/bin/bash",
      "/usr/sbin/sshd",
      "/etc/apt",
      "/private/var/lib/apt",
      "/private/var/tmp/cydia.log",
      "/.installed_unc0ver",
      "/.bootstrapped_electra",
    ]
    if suspectPaths.contains(where: { FileManager.default.fileExists(atPath: $0) }) {
      reasons.append("jailbreak_artifacts")
    }

    // Sandbox escape probe: App Store apps cannot write outside their container
    let probePath = "/private/" + UUID().uuidString
    if (try? "x".write(toFile: probePath, atomically: true, encoding: .utf8)) != nil {
      reasons.append("sandbox_escape")
      try? FileManager.default.removeItem(atPath: probePath)
    }

    // Dynamic injection (set by jailbreak tooling, absent on stock iOS)
    if getenv("DYLD_INSERT_LIBRARIES") != nil {
      reasons.append("dyld_injection")
    }

    #if targetEnvironment(simulator)
    let simulator = true
    #else
    let simulator = false
    #endif

    return [
      "compromised": !reasons.isEmpty,
      "reasons": reasons,
      "emulator": simulator,
      "debuggable": false,
    ]
  }
  
  private func hideSystemUI() {
    print("SystemUI: Hiding system UI on iOS")
    DispatchQueue.main.async {
      UIApplication.shared.isStatusBarHidden = true
    }
  }
  
  private func showSystemUI() {
    print("SystemUI: Showing system UI on iOS")
    DispatchQueue.main.async {
      UIApplication.shared.isStatusBarHidden = false
    }
  }
  
  private func recognizeText(path: String, result: @escaping FlutterResult) {
    let url = URL(fileURLWithPath: path)
    let request = VNRecognizeTextRequest { request, error in
      if let error = error {
        DispatchQueue.main.async {
          result(FlutterError(code: "vision_error", message: error.localizedDescription, details: nil))
        }
        return
      }
      let observations = request.results as? [VNRecognizedTextObservation] ?? []
      let text = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
      DispatchQueue.main.async {
        result(text)
      }
    }
    request.recognitionLevel = .accurate
    request.usesLanguageCorrection = true
    if #available(iOS 16.0, *) {
      request.revision = VNRecognizeTextRequestRevision3
    }
    
    let handler = VNImageRequestHandler(url: url, options: [:])
    DispatchQueue.global(qos: .userInitiated).async {
      do {
        try handler.perform([request])
      } catch {
        DispatchQueue.main.async {
          result(FlutterError(code: "vision_error", message: error.localizedDescription, details: nil))
        }
      }
    }
  }
}
