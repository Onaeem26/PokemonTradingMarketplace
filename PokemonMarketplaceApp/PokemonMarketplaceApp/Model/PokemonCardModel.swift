//
//  PokemonCardModel.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/22/22.
//

import Foundation
import FirebaseFirestoreSwift

public struct PokemonCardModel: Codable {
    var id: String?
    var name: String?
    var hp: String?
    var images: Images?
    var artst: String?
    @DocumentID var cardID: String?
    
    enum CodingKeys: String, CodingKey {
            case id
            case name
            case hp
            case images
            case artst
            case cardID
        }
  
}

struct Images: Codable {
    var large: String?
    var small: String?
}
