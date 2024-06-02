//
//  ContactsService.swift
//  GettingStarted
//
//  Created by Benyamini, Orr on 02/06/2024.
//

import Amplify
import SwiftUI

@MainActor
class ContactsService: ObservableObject {
    @Published var contacts: [Contact] = []

    func fetchContacts() async {
        do {
            let result = try await Amplify.API.query(request: .list(Contact.self))
            switch result {
            case .success(let contactsList):
                print("Fetched \(contacts.count) contacts")
                contacts = contactsList.elements
            case .failure(let error):
                print("Fetch Contacts failed with error: \(error)")
            }
        } catch {
            print("Fetch Contacts failed with error: \(error)")
        }
    }

    func save(_ contact: Contact) async {
        do {
            let result = try await Amplify.API.mutate(request: .create(contact))
            switch result {
            case .success(let contact):
                print("Save contact completed")
                contacts.append(contact)
            case .failure(let error):
                print("Save Contact failed with error: \(error)")
            }
        } catch {
            print("Save Contact failed with error: \(error)")
        }
    }

    func delete(_ contact: Contact) async {
        do {
            let result = try await Amplify.API.mutate(request: .delete(contact))
            switch result {
            case .success(let contact):
                print("Delete contact completed")
                contacts.removeAll(where: { $0.id == contact.id })
            case .failure(let error):
                print("Delete Contact failed with error: \(error)")
            }
        } catch {
            print("Delete Contact failed with error: \(error)")
        }
    }
}

