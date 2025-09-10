import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("REDACTED_GOOGLE_MAPS_API_KEY")
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let systemUIChannel = FlutterMethodChannel(name: "com.bishal.invoice/system_ui",
                                              binaryMessenger: controller.binaryMessenger)
    
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
}
