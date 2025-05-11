//
//  NotificationManager.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

//  NotificationManager.swift
//  Push & in-app notifications scaffold
// ──────────────────────────────────────────────────────
import FirebaseMessaging
import UserNotifications

final class NotificationManager: NSObject, UNUserNotificationCenterDelegate, MessagingDelegate {
    static let shared = NotificationManager()
    private override init() { super.init() }

    func registerForRemoteNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
        UIApplication.shared.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // save token to Firestore under current user
    }
}
