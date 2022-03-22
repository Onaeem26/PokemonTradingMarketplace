//
//  CurrentBidModel.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 3/19/22.
//

import Foundation
import FirebaseFirestoreSwift

public struct CurrentBidModel: Codable {
    var id: String?
    var cardID: String?
    var BidID: String?
    var status: Bool?
    var timeStarted: Date?
    
    
    
    enum CodingKeys: String, CodingKey {
            case id
            case cardID
            case BidID
            case status
            case timeStarted
        }
  
}
