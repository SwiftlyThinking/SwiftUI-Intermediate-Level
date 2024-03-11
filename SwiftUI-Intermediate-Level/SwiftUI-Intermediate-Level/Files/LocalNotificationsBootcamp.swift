//
//  LocalNotificationsBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 02.03.2024.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAutorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success autorization")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "This was soooo easy!"
        content.sound = .default
        content.badge = 1
        
        // Time
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        
        // Calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 25
        
//        let calendarTriger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Location
        let coordinates = CLLocationCoordinate2D(
            latitude: 40.0,
            longitude: 50.0)
        
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: "Region")
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
//        let LocationTrigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        
//        let request = UNNotificationRequest(
//            identifier: "Notification",
//            content: content,
//            trigger: timeTrigger)
    }
    
    func cancelAutorization() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}

struct LocalNotificationsBootcamp: View {
    var body: some View {
        VStack {
            Button("Request permission") {
                NotificationManager.instance.requestAutorization()
            }
            
            Divider()
            
            Button("Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            
            Divider()
            
            Button("Cancel notifications") {
                NotificationManager.instance.cancelAutorization()
            }
        }
    }
}

#Preview {
    LocalNotificationsBootcamp()
}
