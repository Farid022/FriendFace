//
//  DetailView.swift
//  FriendFace
//
//  Created by Muhammad Farid Ullah on 04/01/2023.
//

import SwiftUI

struct DetailView: View {
    
    let user: CachedUser
    
    var body: some View {
        List {
            Section {
                Text("Registered: \(user.wrappedFormattedDate)")
                Text("Age: \(user.age)")
                Text("Email: \(user.wrappedEmail)")
                Text("Address: \(user.wrappedAddress)")
                Text("Works for: \(user.wrappedCompany)")
            } header: {
                Text("Basic Info")
            }
            
            Section {
                Text(user.wrappedAbout)
            } header: {
                Text("About")
            }
            
            Section {
                ForEach(user.friendsArray) { friend in
                    Text(friend.wrappedName)
                }
            } header: {
                Text("Friends")
            }
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
