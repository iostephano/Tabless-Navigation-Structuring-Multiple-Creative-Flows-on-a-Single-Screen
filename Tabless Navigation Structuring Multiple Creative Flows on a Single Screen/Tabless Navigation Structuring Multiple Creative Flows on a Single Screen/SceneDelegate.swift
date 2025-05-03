//
//  SceneDelegate.swift
//  Tabless Navigation Structuring Multiple Creative Flows on a Single Screen
//
//  Created by Stephano Portella on 03/05/25.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Create main window and force Dark Mode
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .dark

        let projectsVC = ProjectsViewController()
        let navigation = UINavigationController(rootViewController: projectsVC)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // La escena se liberó, libera recursos específicos de esta escena.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // La escena pasó a primer plano.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // La escena pasará a estado inactivo.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // La escena entrará al primer plano.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // La escena entró en segundo plano.
        // Guarda datos si es necesario.
    }
}
