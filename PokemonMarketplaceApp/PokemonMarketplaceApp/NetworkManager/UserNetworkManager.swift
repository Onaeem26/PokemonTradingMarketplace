//
//  UserNetworkManager.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/27/22.
//

import Foundation
import Firebase
class UserNetworkManager: UserNetworkProtocol {
    private let db = Firestore.firestore()
    func fetchUser(userid: String, completion: @escaping (UserDataModel) -> ()) {
        db.collection("Users").whereField("id", isEqualTo: userid).getDocuments { (query, error) in
            guard let documents = query?.documents else {
                        fatalError("error downloading documents")
                    }
            
            
            for document in documents{
                if let user = try? document.data(as: UserDataModel.self) {
                    completion(user)
                }
            }
            
        }
    }
}
