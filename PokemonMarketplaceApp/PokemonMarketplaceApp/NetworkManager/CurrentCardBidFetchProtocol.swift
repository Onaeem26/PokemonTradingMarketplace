//
//  CurrentCardBidFetchProtocol.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 3/19/22.
//

import Foundation
protocol CurrentCardBidProtocol {
    func fetchCurrentHighestBid(cardID: String, completion: @escaping ([UserBidModel]) -> ())
    func checkIfFirstBidOnCard(cardID: String, completion: @escaping (Bool) -> ())
    func updateCurrentBidStatusModel(cardID: String, completion: @escaping ([CurrentBidModel]) -> ())
    func createCurrentBidViewModel(cardID: String, completion: @escaping (MainBidVModel) -> ())
    func fetchCurrentBid(cardID: String, completion: @escaping (CurrentBidModel) -> ())
}
