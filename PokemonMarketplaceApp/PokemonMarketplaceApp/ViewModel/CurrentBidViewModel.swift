//
//  CurrentBidViewModel.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 3/19/22.
//

import Foundation

import Combine

class CurrentBidViewModel: ObservableObject {
    @Published var currentBid = MainBidVModel()
//    
    func fetchCurrentBid(cardID: String) {
        CurrentCardBidFetchManager().createCurrentBidViewModel(cardID: cardID) { bid in
            DispatchQueue.main.async {
                self.currentBid = bid
            }
        }
            
    }
}

