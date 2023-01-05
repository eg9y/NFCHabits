//
//  universalLinkListener.swift
//  NFCHabits
//
//  Created by Egan Bisma on 1/5/23.
//
import UIKit

class FSAppDelegate: NSObject, UIApplicationDelegate {

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
    sceneConfig.delegateClass = FSSceneDelegate.self // 👈🏻
    return sceneConfig
  }
}

class FSSceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
  @Published var url: String = ""
    
    
  func sceneWillEnterForeground(_ scene: UIScene) {
    // ...
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // ...
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // ...
  }

  // ...
    
    func scene(_ scene: UIScene, willConnectTo
               session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
     
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        
        // Get URL components from the incoming user activity.
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
            return
        }
        
        if let incomingURL = userActivity.webpageURL {
            print("scene delegate called", incomingURL.absoluteString)
            url = incomingURL.absoluteString
        }
        
    }
}
