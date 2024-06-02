//
//  NotificationService.swift
//  GettingStarted
//
//  Created by Benyamini, Orr on 02/06/2024.
//

import UserNotifications
import SwiftUI

@MainActor
class NotificationsService: ObservableObject {
    func createNotificationContent() -> UNMutableNotificationContent {
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = "This notification is scheduled to appear 10 seconds from now."
            content.sound = UNNotificationSound.default
            return content
        }

        func createTimeIntervalTrigger() -> UNTimeIntervalNotificationTrigger {
            return UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        }

        func scheduleNotification() {
            let content = createNotificationContent()
            let trigger = createTimeIntervalTrigger()

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled in 2 seconds.")
                }
            }
        }
        
        func checkAndRequestPermission() async {
            let center = UNUserNotificationCenter.current()
            let settings = await center.notificationSettings()
            if settings.authorizationStatus == .notDetermined {
                let granted = await requestNotificationPermissionAsync()
                if !granted {
                    print("Notifications permission denied.")
                }
            } else if settings.authorizationStatus == .denied {
                print("Notifications are denied.")
            }
        }

        func requestNotificationPermissionAsync() async -> Bool {
            await withCheckedContinuation { continuation in
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if granted {
                        print("Notification permission granted.")
                        continuation.resume(returning: true)
                    } else {
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        }
                        continuation.resume(returning: false)
                    }
                }
            }
        }
}
