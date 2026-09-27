import UIKit
import Flutter

class SceneDelegate: FlutterSceneDelegate {
  private var privacyBlurView: UIVisualEffectView?

  override func sceneWillResignActive(_ scene: UIScene) {
    super.sceneWillResignActive(scene)
    guard privacyBlurView == nil, let window else { return }
    let blur = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    blur.frame = window.bounds
    blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    window.addSubview(blur)
    privacyBlurView = blur
  }

  override func sceneDidBecomeActive(_ scene: UIScene) {
    super.sceneDidBecomeActive(scene)
    privacyBlurView?.removeFromSuperview()
    privacyBlurView = nil
  }
}
