//
//  Filtered_List.swift
//  FriendFace
//
//  Created by Muhammad Farid Ullah on 04/01/2023.
//

//import SwiftUI
//
//struct Filtered_List: View {
//    @Environment(\.managedObjectContext) var moc
//    @StateObject private var dataController = DataController()
//    @FetchRequest var cachedUsers: FetchedResults<CachedUser>
//    
//    init(filterSearch: String) {
//        _cachedUsers = FetchRequest(entity: CachedUser.entity(), sortDescriptors: [], predicate: NSPredicate(format: "wrappedName BEGINSWITH %@", filterSearch))
//    }
//    
//    
//    var body: some View {
//        NavigationView {
//            List(cachedUsers) { user in
//                NavigationLink {
//                    DetailView(user: user)
//                } label: {
//                    Text(user.wrappedName)
//                }
//            }
//            .navigationTitle("FriendFace")
//        }
//    }
//}

//struct Filtered_List_Previews: PreviewProvider {
//    static var previews: some View {
//        Filtered_List()
//    }
//}
