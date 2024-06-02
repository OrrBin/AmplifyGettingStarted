//
//  SaveContactView.swift
//  GettingStarted
//
//  Created by Benyamini, Orr on 02/06/2024.
//

import SwiftUI

struct SaveContactView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var contactsService: ContactsService
    @EnvironmentObject private var storageService: StorageService
    @State private var name = ""
    @State private var image: Data? = nil
    @State private var selectedPeriod: Period = .monthly

    var body: some View {
        Form {
            Section("Details") {
                TextField("Name", text: $name)
                Picker("Period of notifciations", selection: $selectedPeriod) {
                    Text("Monthly").tag(Period.monthly)
                    Text("Bi Weekly").tag(Period.biWeekly)
                    Text("Weekly").tag(Period.weekly)
                }
            }

            Section("Picture") {
                PicturePicker(selectedData: $image)
            }

            Button("Save Contact") {
                let imageName = image != nil ? UUID().uuidString : nil
                let contact = Contact(
                    name: name,
                    notificationPeriod: selectedPeriod,
                    image: imageName
                )

                Task {
                    if let image, let imageName {
                        await storageService.upload(image, name: imageName)
                    }
                    await contactsService.save(contact)

                    dismiss()
                }
            }
        }
    }
}
