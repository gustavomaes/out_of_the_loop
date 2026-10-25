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
