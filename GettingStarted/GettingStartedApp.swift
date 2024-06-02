//
//  GettingStartedApp.swift
//  GettingStarted
//
//  Created by Benyamini, Orr on 28/05/2024.
//

import Amplify
import AWSAPIPlugin
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
import SwiftUI

@main
struct GettingStartedApp: App {
    // Integrate AppDelegate
    @UIApplicationDelegateAdaptor(NotificationsDelegate.self) var notificationsDelegate
    
    let notificationsService = NotificationsService()
    
    init() {
        notificationsDelegate.notificationsService = notificationsService
        
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            print("Could not initialize Amplify: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            LandingView()
                .environmentObject(NotesService())
                .environmentObject(ContactsService())
                .environmentObject(AuthenticationService())
                .environmentObject(notificationsService)
                .environmentObject(StorageService())
        }
    }
}
