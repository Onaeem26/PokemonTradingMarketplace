//
//  PostBidView.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/24/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct PostBidView: View {
    @State var bidPrice: String = ""
    @FocusState private var fieldFocus: Bool
    @Environment(\.presentationMode) var presentationMode
    var card: PokemonCardModel

    
    var db = Firestore.firestore()
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(spacing: 0) {
                        Text(Locale.current.currencySymbol ?? "")
                            .font(.largeTitle)
                        TextField("5", text: $bidPrice)
                            .font(.largeTitle)
                            .focused($fieldFocus)
                            .keyboardType(.numberPad)
                        
                    }.padding()
                    
                Spacer()
                    
                    Button {
                        print("Post Bid")
                        //Do something here
                        self.checkHighestBid(cardID: card.cardID ?? "") { val in
                            if (Float(bidPrice) ?? 0 >= val && Float(bidPrice) ?? 0 >= 5) {
                                self.uploadBid()
                                self.presentationMode.wrappedValue.dismiss()
                            }else {
                                print("not noice")
                                print("Value should be higher")
                            }
                        }
                        
                    } label: {
                        Text("Post Bid")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            
                    }.disabled(bidPrice.isEmpty)

                }.padding(.top)
            }.onAppear {
                self.fieldFocus = true
            }.navigationTitle("Enter your Bid")
                .toolbar {
                    Button {
                        print("Dismiss View")
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
        }
    }
    func checkHighestBid(cardID: String, completion: @escaping (Float) -> ()) {
        CurrentCardBidFetchManager().fetchCurrentHighestBid(cardID: card.cardID!) { bid in
            if bid.count == 1 {
                let highestBid = bid[0]
                let highestPrice = highestBid.price
                completion(highestPrice ?? 5.0)
            }else {
                completion(0.0)
            }
        }
    }
    
    func uploadBid() {
        do {
            let userid = Auth.auth().currentUser?.uid
            let cardID = card.cardID
            let bidUUID = UUID().uuidString
            let bid = UserBidModel(bidUUID: bidUUID, cardID: cardID, price: Float(bidPrice), userID: userid, bidTime: Date())
            let _ = try db.collection("UserBids").document(bidUUID).setData(from: bid)
            
            CurrentCardBidFetchManager().updateCurrentBidStatusModel(cardID: cardID!) { CurrentBidModel in
                print("HALLO")
                print(CurrentBidModel[0].BidID)
            }
        }catch {
            print(error)
        }
        
        
    }
}

//struct PostBidView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostBidView()
//    }
//}
