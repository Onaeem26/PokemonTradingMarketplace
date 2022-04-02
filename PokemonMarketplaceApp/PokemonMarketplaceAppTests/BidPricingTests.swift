//
//  BidPricingTests.swift
//  PokemonMarketplaceAppTests
//
//  Created by Muhammad Osama Naeem on 3/28/22.
//

@testable import PokemonMarketplaceApp
import XCTest

class BidPricingTests: XCTestCase {
    var bidService: BidValidation!
    override func setUp() {
        super.setUp()
        bidService = BidValidation()
        
    }
    
    override func tearDown() {
        super.tearDown()
        bidService = nil
    }
    
    //Checking if bid is above the floor bid of $5
    func test_is_bid_valid() throws {
        XCTAssertNoThrow(try bidService.validateBid(currentBid: 5, bidValue: 10))
    }
    
    //Checking bid is equal to current bid
    func test_bid_value_equal_to_current_bid() throws {
        XCTAssertNoThrow(try bidService.validateBid(currentBid: 25, bidValue: 25))
    }
    
    //Checking if bid is below the floor bid of $5
    func test_is_bid_below_floor_bid() throws {
        XCTAssertThrowsError(try bidService.validateBid(currentBid: 5, bidValue: 1))
    }
    
    //Checking if bid is $0
    func test_is_bid_zero() throws {
        XCTAssertThrowsError(try bidService.validateBid(currentBid: 5, bidValue: 0))
    }
}
