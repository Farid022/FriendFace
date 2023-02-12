//
//  UserModel.swift
//  FriendFace
//
//  Created by Muhammad Farid Ullah on 04/01/2023.
//

import Foundation
//Steps includes in this are following:
/*
 Part 1 for fetching data from internet.
 1. Create the model carefully.
 2. Create observable class which contains getUsers() to fecth the user from internet and store in an array of User[].
 3. Create view and display them.
 Explaination:
 /*
  A few things to consider:
  1. getUsers() function is marked “async” because retrieving data might take some time and it is called in the .task {} modifier on the List itself
  2. the url is force unwrapped because the app would not work anyway if it isn’t 100% correct so we make sure it is since it’s hard-coded
  3. httpMethod is “GET” because we are retrieving data from the internet.
  4. dateDecodingStrategy is set to .iso8601 because that is the format in the JSON and also Paul actually says to use it in the challenge tips
  5. getUsers() function returns an optional because there is a possibility of an error while parsing the JSON or processing the request.
  */
 
 Part 2 for storing the fetched data to CoreData.
 1. Create CoreData Model with specified Entities, attributes and relationships between them.
 2. Select both entities and sideBar -Codegen -> Manuel, Editor-> Create NSManagedObject Subclass... and next->next-> save in a specific group of the project.
 3. Get rid of optionals by making computed properties like-> var wrappedName: String { name ?? "Unknown" }
 4. var friendsArray which takes the NSSet, does type casting to Set<CachedFriend>. Then it sorts it and returns it so you have a public property “friendsArray” you can use in ForEach in SwiftUI.
 public var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
 
 5. dataController - NSPersistentContainer and loadPersistentStores in init().
 6. Environment and managedObjectContext in CoreDataApp()-> main().
 7. @Environment(\.managedObjectContext) var moc. to store our objects. -> main()
 8. FetchRequest variable and FetchedResults<CashedUser> in contentView(), First, we need to get the managed object context from the environment and make a fetch request to have it ready for use when saving and retrieving data from the database.
 
 /*
  1. Saving retrieved data to the database using CoreData
  The only thing left to do is to fix our ContentView and our DetailView so that they load data from persistent storage, rather than from the internet every time.
  
  2. First, we need to get the managed object context from the environment and make a fetch request to have it ready for use when saving and retrieving data from the database.
  
  3. Next, add logic to the .task {} modifier for saving data and change the list to iterate over cachedUsers rather than just users fetched from the internet. Also, we need to change property names to wrapped property names to avoid optionals (that’s why we did all that work with the extensions before)
  */
 */
struct User: Codable, Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    var formattedDate: String {
        registered.formatted(date: .abbreviated, time: .omitted)
    }
}
struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}
