//
//  PokemonCardsFeedNetworkProtocol.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/22/22.
//

import Foundation
protocol PokemonCardsFeedNetworkProtocol {
    func fetchPokemonCardsForFeed(completion: @escaping ([PokemonCardModel]) -> ())
    func fetchPokemonCardsVForFeed(completion: @escaping ([PokemonCardVModel]) -> ())
}

