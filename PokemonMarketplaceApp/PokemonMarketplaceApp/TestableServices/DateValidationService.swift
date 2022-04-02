//
//  DateValidationService.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 4/2/22.
//

import Foundation
class DateValidationService {
    func validateBidDate(bidStart: Date?) throws -> String {
        let bidDuration = 24 //24 hours)
        let calendar = NSCalendar.current
        let bidEndDate = calendar.date(byAdding: .hour, value: bidDuration, to: bidStart ?? Date())
        
        if bidStart == nil {
            throw DateValidationStatus.inactive
        }
        
        if let bidEndDate = bidEndDate {
            if Date() < bidEndDate {
                throw DateValidationStatus.active
            }
            
            if Date() > bidEndDate {
                throw DateValidationStatus.completed
            }
        }
        
        
        return ""
    }
}

enum DateValidationStatus: LocalizedError {
    case completed
    case inactive
    case active
    
    var errorDescription: String? {
        switch self {
        case .completed:
            return "Incorrect"
        case .inactive:
            return "Inactive"
        case .active:
            return "Active"
       
        }
        
        
    }
}
