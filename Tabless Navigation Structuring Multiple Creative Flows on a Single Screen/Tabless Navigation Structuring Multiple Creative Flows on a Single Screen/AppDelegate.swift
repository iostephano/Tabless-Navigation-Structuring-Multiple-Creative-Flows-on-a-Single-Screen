//
//  AppDelegate.swift
//  Tabless Navigation Structuring Multiple Creative Flows on a Single Screen
//
//  Created by Stephano Portella on 03/05/25.
//
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - UISceneSession Lifecycle (iOS 13+)

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Called when the app has finished launching.
        // Use this point to configure global services, analytics, etc.
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        // Called when the user discards a scene session.
        // Release any resources that were specific to the discarded scenes here.
    }
}
