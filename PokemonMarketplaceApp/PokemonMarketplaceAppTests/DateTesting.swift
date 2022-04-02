//
//  DateTesting.swift
//  PokemonMarketplaceAppTests
//
//  Created by Muhammad Osama Naeem on 4/2/22.
//

@testable import PokemonMarketplaceApp
import Foundation
import XCTest

class DateTesting: XCTestCase {
    var dateService: DateValidationService!
    override func setUp() {
        super.setUp()
        dateService = DateValidationService()
        
    }
    
    override func tearDown() {
        super.tearDown()
        dateService = nil
    }
    
    func test_is_bid_inactive() throws {
        XCTAssertThrowsError(try dateService.validateBidDate(bidStart: nil))
    }
    
    func test_is_bid_active() throws {
        let calendar = Calendar(identifier: .gregorian)
        //change the bidstart date here
        let components = DateComponents(year: 2022, month: 04, day: 2, hour: 01, minute: 24, second: 30)
        let bidStart = calendar.date(from: components)!
        
        XCTAssertThrowsError(try dateService.validateBidDate(bidStart: bidStart))
    }
    
    func test_is_bid_completed() throws {
        let calendar = Calendar(identifier: .gregorian)
        //change the bidstart date here
        let components = DateComponents(year: 2022, month: 02, day: 2, hour: 01, minute: 24, second: 30)
        let bidStart = calendar.date(from: components)!
        
        XCTAssertThrowsError(try dateService.validateBidDate(bidStart: bidStart))
    }
    

}
