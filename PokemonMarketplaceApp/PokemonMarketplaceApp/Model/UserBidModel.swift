//
//  UserBidModel.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 3/19/22.
//

import Foundation
import FirebaseFirestoreSwift
public struct UserBidModel: Codable {
    @DocumentID var id: String?
    var bidUUID: String?
    var cardID: String?
    var price: Float?
    var userID: String?
    var bidTime: Date?
   
    
    enum CodingKeys: String, CodingKey {
            case bidUUID
            case id
            case cardID
            case price
            case userID
            case bidTime
        }
  
}


