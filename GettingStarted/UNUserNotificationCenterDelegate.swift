//
//  UNUserNotificationCenterDelegate.swift
//  GettingStarted
//
//  Created by Benyamini, Orr on 02/06/2024.
//

import UIKit
import UserNotifications

class NotificationsDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var notificationsService: NotificationsService?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        requestNotificationPermission()
        return true
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    // Handle notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("1: notificationsService is null ? ", notificationsService == nil);
        // Recursivly schedule notification
        notificationsService?.scheduleNotification()
        
        completionHandler([.banner, .sound])
    }

    // Handle notification response
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("2: notificationsService is null ? ", notificationsService == nil);
        // Recursivly schedule notification
        notificationsService?.scheduleNotification()
        
        completionHandler()
    }
}

