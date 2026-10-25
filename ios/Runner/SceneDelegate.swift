import Flutter
import UIKit

class SceneDelegate: FlutterSceneDelegate {
  private var privacyCover: UIView?
  var classicPrivacyEnabled = false

  override init() {
    super.init()
    // Native notifications cover the window before UIKit takes its app-switcher
    // snapshot, independently of when Flutter receives its lifecycle message.
    NotificationCenter.default.addObserver(
      self, selector: #selector(coverPreview(_:)),
      name: UIScene.willDeactivateNotification, object: nil)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  @objc private func coverPreview(_ notification: Notification) {
    guard let window = window,
          let scene = notification.object as? UIScene,
          scene === window.windowScene,
          classicPrivacyEnabled, privacyCover == nil else { return }
    let cover = UIView(frame: window.bounds)
    cover.backgroundColor = UIColor(red: 1, green: 0.977, blue: 0.953, alpha: 1)
    cover.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    cover.accessibilityIdentifier = "classic-privacy-cover"
    window.addSubview(cover)
    privacyCover = cover
  }

  func removePrivacyCover() {
    guard window?.windowScene?.activationState == .foregroundActive else { return }
    privacyCover?.removeFromSuperview()
    privacyCover = nil
  }
}
