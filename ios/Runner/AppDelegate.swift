import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "ClassicPrivacy")!
    let share = FlutterMethodChannel(name: "classic/share", binaryMessenger: registrar.messenger())
    share.setMethodCallHandler { call, result in
      guard call.method == "share" else { result(FlutterMethodNotImplemented); return }
      guard let raw = call.arguments as? String, let url = URL(string: raw),
            url.scheme == "https", url.host == "apps.apple.com",
            let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
            var presenter = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
        result(FlutterError(code: "unavailable", message: nil, details: nil)); return
      }
      while let presented = presenter.presentedViewController { presenter = presented }
      let activity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
      if let popover = activity.popoverPresentationController {
        popover.sourceView = presenter.view
        popover.sourceRect = CGRect(x: presenter.view.bounds.midX, y: presenter.view.bounds.midY, width: 1, height: 1)
        popover.permittedArrowDirections = []
      }
      activity.completionWithItemsHandler = { _, completed, _, error in
        if error != nil { result(FlutterError(code: "share_failed", message: nil, details: nil)) }
        else { result(completed ? "completed" : "cancelled") }
      }
      presenter.present(activity, animated: true)
    }
    let channel = FlutterMethodChannel(name: "classic/privacy", binaryMessenger: registrar.messenger())
    channel.setMethodCallHandler { call, result in
      for scene in UIApplication.shared.connectedScenes {
        guard let delegate = scene.delegate as? SceneDelegate else { continue }
        switch call.method {
        case "protect":
          delegate.classicPrivacyEnabled = call.arguments as? Bool ?? false
          if !delegate.classicPrivacyEnabled { delegate.removePrivacyCover() }
        case "ready":
          delegate.removePrivacyCover()
        default:
          result(FlutterMethodNotImplemented)
          return
        }
      }
      result(nil)
    }
  }
}
