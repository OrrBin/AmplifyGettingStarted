//
//  ContactView.swift
//  GettingStarted
//
//  Created by Benyamini, Orr on 02/06/2024.
//

import SwiftUI

struct ContactView: View {
    @State var contact: Contact

    var body: some View {
        HStack(alignment: .center, spacing: 5.0) {
            VStack(alignment: .leading, spacing: 5.0) {
                Text(contact.name).bold()
                Text(contact.notificationPeriod.rawValue)
            }

            if let image = contact.image {
                Spacer()
                RemoteImage(name: image)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            }
        }
    }
}

