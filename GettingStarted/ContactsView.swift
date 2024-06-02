//
//  ContactsView.swift
//  GettingStarted
//
//  Created by Benyamini, Orr on 02/06/2024.
//

import UserNotifications
import SwiftUI

struct ContactsView: View {
    @EnvironmentObject private var authenticationService: AuthenticationService
    @EnvironmentObject private var notificationsService: NotificationsService
    @EnvironmentObject private var contactsService: ContactsService
    @EnvironmentObject private var storageService: StorageService
    @State private var isSavingContact = false

    var body: some View {
        NavigationStack{
            List {
                if contactsService.contacts.isEmpty {
                    Text("No contacts")
                }
                ForEach(contactsService.contacts, id: \.id) { contact in
                    ContactView(contact: contact)
                }
                .onDelete { indices in
                    for index in indices {
                        let contact = contactsService.contacts[index]
                        Task {
                            await contactsService.delete(contact)
                            if let image = contact.image {
                                await storageService.remove(withName: image)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                Button("Sign Out") {
                    Task {
                        await authenticationService.signOut()
                    }
                }
            }
            .toolbar {
                Button("New Notification") {
                    Task {
                        // Request permission to send notifications (do this early in your app lifecycle)
                        await notificationsService.checkAndRequestPermission()

                        // Schedule the notification
                        notificationsService.scheduleNotification()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("⨁ New Contact") {
                        isSavingContact = true
                    }
                    .bold()
                }
            }
            .sheet(isPresented: $isSavingContact) {
                SaveContactView()
            }
        }
        .task {
            await contactsService.fetchContacts()
        }
    }
}
