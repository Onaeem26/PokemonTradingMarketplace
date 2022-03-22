//
//  CurrentCardBidFetchManager.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 3/19/22.
//

import Foundation
import Firebase
class CurrentCardBidFetchManager: CurrentCardBidProtocol {
    
    var db = Firestore.firestore()
    func fetchCurrentHighestBid(cardID: String, completion: @escaping ([UserBidModel]) -> ()) {
        var highestBid : [UserBidModel] = []
        db.collection("UserBids").whereField("cardID", isEqualTo: cardID).order(by: "price", descending: true).limit(to: 1)
            .getDocuments { query, err in
                if let err = err {
                    print("Error getting docs: \(err)")
                }else {
                    for docs in query!.documents {
                        if let bid = try? docs.data(as: UserBidModel.self) {
                            highestBid.append(bid)
                        }
                    }
                    completion(highestBid)
                }
            }
        
    }
    
    func checkIfFirstBidOnCard(cardID: String, completion: @escaping (Bool) -> ()) {
        db.collection("UserBids").whereField("cardID", isEqualTo: cardID)
            .getDocuments {  query, err in
                if let err = err {
                    print("Error getting docs: \(err)")
                }else {
                    if (query!.documents).count == 1 {
                        print(true)
                        completion(true)
                    }else if (query!.documents).count > 1 {
                        print(false)
                        completion(false)
                    }
                }
            }
    }
    
    func updateCurrentBidStatusModel(cardID: String, completion: @escaping ([CurrentBidModel]) -> ()) {
        checkIfFirstBidOnCard(cardID: cardID, completion: { result in
            if result {
                print("Result:", result)
                self.fetchCurrentHighestBid(cardID: cardID) { highestBid in
                    let highestBidID = highestBid[0].bidUUID
                    print("HighestBidID:", highestBidID)
                    let currentBidModel = CurrentBidModel(cardID: cardID, BidID: highestBidID, status: true, timeStarted: Date())
                    do {
                        let _ = try self.db.collection("CurrentBid").addDocument(from: currentBidModel)
                        completion([currentBidModel])
                    }catch {
                        print(error)
                    }
                }
               
            }else {
                self.fetchCurrentHighestBid(cardID: cardID) { highestBid in
                    let highestBidID = highestBid[0].bidUUID
                    print("HighestBidID 2:", highestBidID)
                    self.db.collection("CurrentBid").whereField("cardID", isEqualTo: cardID)
                            .getDocuments(completion: { query, err in
                                if let err = err {
                                    print("Error getting docs: \(err)")
                                }else {
                                    for doc in query!.documents {
                                        self.db.collection("CurrentBid").document(doc.documentID).updateData(["BidID" : highestBidID])
                                    }
                                    
                                }
                    })
                }
            }
        })
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
    
    func fetchUserObject(userID: String, completion: @escaping (UserDataModel) -> ()) {
        db.collection("Users").whereField("id", isEqualTo: userID)
            .getDocuments { query, err in
                if let error = err {
                    print(error)
                }else {
                    for doc in query!.documents {
                        if let user = try? doc.data(as: UserDataModel.self) {
                            completion(user)
                        }
                    }
                }
            }
    }
    
    func createCurrentBidViewModel(cardID: String, completion: @escaping (MainBidVModel) -> ()) {
        self.fetchCurrentBid(cardID: cardID) { currentBid in
            print("Current Bid:", currentBid.BidID)
            self.fetchBidObject(bidID: currentBid.BidID!) { bid in
                print("Bid :", bid.price)
                self.fetchUserObject(userID: bid.userID!) { user in
                    print("User :", user.fullName ?? "")
                    let mainBidVModel = MainBidVModel(price: bid.price, status: currentBid.status, timeStarted: currentBid.timeStarted, currentBidderName: user.fullName)
                    print(mainBidVModel)
                    completion(mainBidVModel)
                }
            }
        }
    }
    
}
