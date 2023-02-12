//
//  DataController.swift
//  FriendFace
//
//  Created by Muhammad Farid Ullah on 04/01/2023.
//

import Foundation
import CoreData
import SwiftUI

class DataController: ObservableObject {
    //CoreData
    /*
     1. Saving retrieved data to the database using CoreData
     The only thing left to do is to fix our ContentView and our DetailView so that they load data from persistent storage, rather than from the internet every time.
     
     2. First, we need to get the managed object context from the environment and make a fetch request to have it ready for use when saving and retrieving data from the database.
     
     3. Next, add logic to the .task {} modifier for saving data and change the list to iterate over cachedUsers rather than just users fetched from the internet. Also, we need to change property names to wrapped property names to avoid optionals (that’s why we did all that work with the extensions before)
     */
    
    //1. Now we need to initialise the Data_Controller and initialise it like this. We use StateObject property wrapper to initialise the data controller and then put it in the environment so we can use it in views later.
    let container = NSPersistentContainer(name: "FriendFace")
    //2. To actually load the data model we need to call loadPersistentStores() on our container. This doesn’t load all the data into memory at the same time because that would be wasteful.
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading data \(error.localizedDescription)")
            }
        }
    }
    
    //Geting users from internet
    /*
     A few things to consider:
     1. getUsers() function is marked “async” because retrieving data might take some time and it is called in the .task {} modifier on the List itself
     2. the url is force unwrapped because the app would not work anyway if it isn’t 100% correct so we make sure it is since it’s hard-coded
     3. httpMethod is “GET” because we are retrieving data from the internet
     4. dateDecodingStrategy is set to .iso8601 because that is the format in the JSON and also Paul actually says to use it in the challenge tips.
     5. getUsers() function returns an optional because there is a possibility of an error while parsing the JSON or processing the request.
     */
    func getUsers() async -> [User]? {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try decoder.decode([User].self, from: data)
            return decodedData
        } catch {
            print(error)
        }
        return nil
    }
}
