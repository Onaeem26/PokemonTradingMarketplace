//
//  BidValidation.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 3/28/22.
//

import Foundation
class BidValidation {
    func validateBid(currentBid: Float, bidValue: Float) throws -> String {
        if (bidValue >= currentBid && bidValue >= 5) {
            return "Correct"
        }
        throw BidValidationError.incorrectBid
    }
}

enum BidValidationError: LocalizedError {
    case incorrectBid
    
    var errorDescription: String? {
        switch self {
        case .incorrectBid:
            return "Incorrect Bid"
       
        }
    }
}
