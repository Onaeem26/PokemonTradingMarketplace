//
//  UserNetworkProtocol.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/27/22.
//

import Foundation
protocol UserNetworkProtocol {
    func fetchUser(userid: String, completion: @escaping (UserDataModel) -> ())
}
