//
//  NFCHabitsApp.swift
//  NFCHabits
//
//  Created by Egan Bisma on 12/28/22.
//

import SwiftUI

@main
struct NFCHabitsApp: App {
    @UIApplicationDelegateAdaptor(FSAppDelegate.self) var appDelegate
  
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
