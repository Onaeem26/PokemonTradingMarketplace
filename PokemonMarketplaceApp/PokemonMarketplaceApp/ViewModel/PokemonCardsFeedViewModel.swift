//
//  PokemonCardsFeedViewModel.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/22/22.
//

import Foundation
import Combine

class PokemonCardsFeedViewModel: ObservableObject {
    @Published var pokemonCards = [PokemonCardVModel]()
    
    func fetchCards() {
        PokemonCardsFeedNetworkManager().fetchPokemonCardsVForFeed{ [weak self] cards in
            print(cards.count)
            DispatchQueue.main.async {
                let sortedCards = cards.sorted(by: { $0.price ?? 0 > $1.price ?? 0 })
                self?.pokemonCards = sortedCards
            }
        }
    }
}
