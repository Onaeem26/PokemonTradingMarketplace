//
//  FetchWinningsViewModel.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 4/1/22.
//

import Foundation
import Combine

class FetchWinningsViewModel: ObservableObject {
    @Published var winningCards = [CardWinningModel]()
    
    func fetchCards(userID: String) {
        CurrentCardBidFetchManager().fetchWinnings(userID: userID) { winnings in
            self.winningCards = winnings
        }
    }
}
