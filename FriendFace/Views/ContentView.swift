//
//  ContentView.swift
//  FriendFace
//
//  Created by Muhammad Farid Ullah on 04/01/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CachedUser.entity(), sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    @StateObject private var dataController = DataController()
    
    @State private var users = [User]()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List(cachedUsers) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    Text(user.wrappedName)
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if cachedUsers.isEmpty {
                    if let retrievedUsers = await dataController.getUsers() {
                        users = retrievedUsers
                    }
                    
                    await MainActor.run {
                        for user in users {
                            let newUser = CachedUser(context: moc)
                            newUser.name = user.name
                            newUser.id = user.id
                            newUser.isActive = user.isActive
                            newUser.age = Int16(user.age)
                            newUser.about = user.about
                            newUser.email = user.email
                            newUser.address = user.address
                            newUser.company = user.company
                            newUser.formattedDate = user.formattedDate
                            
                            for friend in user.friends {
                                let newFriend = CachedFriend(context: moc)
                                newFriend.id = friend.id
                                newFriend.name = friend.name
                                newFriend.user = newUser
                            }
                            
                            try? moc.save()
                        }
                    }
                }
            }
        }
    }
}
