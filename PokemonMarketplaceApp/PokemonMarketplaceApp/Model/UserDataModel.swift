//
//  UserDataModel.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 1/23/22.
//

import Foundation
import FirebaseFirestoreSwift

public struct UserDataModel: Codable {
    var id: String?
    var fullName: String?
    var email: String?
    var phoneNumber: String?
    var wallet: [String]?
    
    enum CodingKeys: String, CodingKey {
            case id
            case fullName
            case email
            case phoneNumber
            case wallet
        }
  
}
