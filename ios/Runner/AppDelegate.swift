import UIKit
import Flutter
import GoogleMaps
import Vision

@main
@objc class AppDelegate: FlutterAppDelegate {
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
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
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
