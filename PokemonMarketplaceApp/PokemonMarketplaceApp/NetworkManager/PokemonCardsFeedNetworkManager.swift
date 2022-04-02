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
    
    func fetchPokemonCard(cardID: String, completion: @escaping (PokemonCardModel) -> ()) {
        db.collection("Cards").document(cardID).getDocument { (document, error) in
            if let document = document, document.exists {
                if let card = try? document.data(as: PokemonCardModel.self) {
                    print("CardID", card.cardID)
                    completion(card)
                }
            } else {
                    print("Document does not exist")
                }
        }
    }
    
    func fetchPokemonCardsVForFeed(completion: @escaping ([PokemonCardVModel]) -> ()) {
        db.collection("Cards").getDocuments { (query, error) in
            guard let documents = query?.documents else {
                        fatalError("error downloading documents")
                    }
            
            var fetchedCards = [PokemonCardVModel]()
            var bol = [Bool]()
            print("HELO")
            for document in documents{
                if let card = try? document.data(as: PokemonCardModel.self) {
                    self.biddingIsOn(cardID: card.cardID!) { p in
                        if p {
                            self.fetchCurrentBid(cardID: card.cardID!) { bid in
                                self.fetchBidObject(bidID: bid.BidID!) { bidObject in
                                    let bidModelIsOn = PokemonCardVModel(pokemonCardDetail: card, price: bidObject.price)
                                    fetchedCards.append(bidModelIsOn)
                                    if (fetchedCards.count == documents.count) {
                                        completion(fetchedCards)
                                    }
                                }
                             
                          }
                        }else {
                            let bidModelIsOff = PokemonCardVModel(pokemonCardDetail: card, price: 0)
                            fetchedCards.append(bidModelIsOff)
                            if (fetchedCards.count == documents.count) {
                                completion(fetchedCards)
                            }
                        }
                    }
//
                    //fetchedCards.append(cards)
                }
                
                if fetchedCards.count == documents.count {
                    completion(fetchedCards)
                }
            }
        }
    }
    
    func fetchBidObject(bidID: String, completion: @escaping (UserBidModel) -> ()) {
        db.collection("UserBids").whereField("bidUUID", isEqualTo: bidID)
            .getDocuments { query, err in
                if let error = err {
                    print(error)
                }else {
                    for doc in query!.documents {
                        if let bid = try? doc.data(as: UserBidModel.self) {
                            completion(bid)
                        }
                    }
                }
            }
    }
    
    func fetchCurrentBid(cardID: String, completion: @escaping (CurrentBidModel) -> ()) {
        db.collection("CurrentBid").whereField("cardID", isEqualTo: cardID)
            .getDocuments { query, err in
                if let err = err {
                    print(err)
                }else {
                    for doc in query!.documents {
                        if let bid = try? doc.data(as: CurrentBidModel.self) {
                            completion(bid)
                        }
                    }
                }
            }
    }
    
    func biddingIsOn(cardID: String, completion: @escaping (Bool) -> ()) {
        db.collection("CurrentBid").whereField("cardID", isEqualTo: cardID)
            .getDocuments { query, err in
                if let err = err {
                    print(err)
                }else {
                    if ((query?.documents.count ?? 0) > 0) {
                        completion(true)
                    }else {
                        completion(false)
                    }
                }
            }
    }
}
