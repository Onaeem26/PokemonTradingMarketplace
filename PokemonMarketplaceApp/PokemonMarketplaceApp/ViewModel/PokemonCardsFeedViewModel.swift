//
//  PokemonCardsFeedViewModel.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/22/22.
//

import Foundation
import Combine

class PokemonCardsFeedViewModel: ObservableObject {
    @Published var pokemonCards = [PokemonCardModel]()
    
    func fetchCards() {
        PokemonCardsFeedNetworkManager().fetchPokemonCardsForFeed { [weak self] cards in
            DispatchQueue.main.async {
                self?.pokemonCards = cards
            }
        }
    }
}
