//
//  PokemonCardsFeedNetworkManager.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/22/22.
//

import Foundation
import Firebase
class PokemonCardsFeedNetworkManager: PokemonCardsFeedNetworkProtocol {
    private let db = Firestore.firestore()
    func fetchPokemonCardsForFeed(completion: @escaping ([PokemonCardModel]) -> ()) {
        db.collection("Cards").getDocuments { (query, error) in
            guard let documents = query?.documents else {
                        fatalError("error downloading documents")
                    }
            
            var fetchedCards = [PokemonCardModel]()
            
            for document in documents{
                if let cards = try? document.data(as: PokemonCardModel.self) {
                    fetchedCards.append(cards)
                }
            }
            completion(fetchedCards)
        }
    }
}
