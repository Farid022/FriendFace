//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Muhammad Farid Ullah on 04/01/2023.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    //Now we need to initialise the Data Controller and initialise it like this. We use StateObject property wrapper to initialise the data controller and then put it in the environment so we can use it in views later.
    //@StateObj
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            //managedObjectContexts. They are effectively the “live” version of your data – when you load objects and change them, those changes only exist in memory until you specifically save them back to the persistent store.
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
