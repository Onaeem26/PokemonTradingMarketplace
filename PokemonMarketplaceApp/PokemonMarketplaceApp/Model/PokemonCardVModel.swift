//
//  PokemonCardVModel.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 3/23/22.
//
import Foundation
import FirebaseFirestoreSwift

public struct PokemonCardVModel: Codable {
    var id = UUID()
    var pokemonCardDetail: PokemonCardModel
    var price: Float?
}

