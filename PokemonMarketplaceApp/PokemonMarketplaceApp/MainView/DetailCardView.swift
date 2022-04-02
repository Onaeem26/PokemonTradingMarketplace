//
//  DetailCardView.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/23/22.
//

import SwiftUI

struct DetailCardView: View {
    var card: PokemonCardModel
    @State var presentBidPostView: Bool = false
    @ObservedObject var bidViewModel: CurrentBidViewModel
    @State var timeRemainingString: String = ""
    
    var body: some View {
        ZStack {
        
            ScrollView {
                VStack {
                
                    AsyncImage(
                        url: URL(string: card.images?.large ?? ""),
                           content: { image in
                               image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 300)
                           },
                           placeholder: {
                               ProgressView()
                           }
                    )
                    
                    Text(card.name ?? "")
                        .bold()
                        .font(.title)
                    
                    Text("Artist: \(card.artst ?? "")")
                    
                    Divider()
                    
                    VStack {
//                        HStack {
//                            Text("Bidding Status:")
//                                .bold()
//                                .padding(.horizontal, 16)
//                            //Spacer()
//                        }
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(bidViewModel.currentBid.price ?? 0, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                               // Text(String(bidViewModel.currentBid.price ?? 0))
                                    .font(.title)
                                Text((bidViewModel.currentBid.status ?? true) ? "Current Bid" : "Winning Bid")
                                    .font(.caption)
                            }.frame(maxWidth: .infinity)
                            
                            Divider()
                            
                            VStack(alignment: .leading) {
                                Text(bidViewModel.currentBid.currentBidderName ?? "No Bidder")
                                    .font(.title2)
                                Text((bidViewModel.currentBid.status ?? true) ? "Current Bidder" : "Winner")
                                    .font(.caption)
                            }.frame(maxWidth: .infinity)
                        
                            
                        }.padding(.horizontal, 16)
                        
                     

                    }
                    
                    Divider()
                    
                    VStack {
                        Button {
                            self.presentBidPostView = true
                        } label: {
                            Text((bidViewModel.currentBid.status ?? true) ? "Bid Now" : "Closed")
                                .padding()
                                .foregroundColor(.white)
                                .background((bidViewModel.currentBid.status ?? true) ? Color.green : .red)
                                .cornerRadius(5)
                                .padding(.top, 12)
                                .padding(.bottom,8)
                                
                        }.disabled(!(bidViewModel.currentBid.status ?? true))
                  
                        Text("Floor Bid is ").font(.footnote) + Text("$5").bold().font(.footnote)
                            
                    }
                    Divider()
                    
                    VStack(spacing: 0) {
                        HStack {
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor((bidViewModel.currentBid.status ?? true) ? .green : .red)
                            Text("Time Remaining")
                                .bold()
                            Spacer()
                           // Text(bidViewModel.currentBid.timeStarted)
                            if (bidViewModel.currentBid.status == nil) {
                                Text("Bid Inactive")
                            }else {
                                Text((bidViewModel.currentBid.status!) ? timeRemainingString : "Bid Closed")
                            }
                            //
                        }.padding(.horizontal)
                        
                        
                        HStack {
                            Text("👨‍💼")
                            Text("Seller")
                                .bold()
                            Spacer()
                            Text("PokemonTradingInc")
                        }.padding(.horizontal)
                        .padding(.top, 12)
                    }
                    .padding(.bottom)
                    Spacer()
                }.padding(.top)
            }
            .sheet(isPresented: $presentBidPostView, onDismiss: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    bidViewModel.fetchCurrentBid(cardID: self.card.cardID!)
                })
            }) {
                PostBidView(card: card)
                }
        }.navigationTitle(card.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            bidViewModel.fetchCurrentBid(cardID: self.card.cardID!)
    
            
           //
        }.onChange(of: self.bidViewModel.currentBid.timeStarted) { b in
           // print(self.timeRemainingCalculations(bidStartDate: self.bidViewModel.currentBid.timeStarted))
            timeRemainingString = self.timeRemainingCalculations(bidStartDate: self.bidViewModel.currentBid.timeStarted)
        }
        
    }
    
    func timeRemainingCalculations(bidStartDate: Date?) -> String {
        let bidDuration = 24 //24 hours)
        let calendar = NSCalendar.current
        let bidEndDate = calendar.date(byAdding: .hour, value: bidDuration, to: bidStartDate ?? Date())
        
        
        guard let bidEndDateStrong = bidEndDate else {
            return ""
        }
        guard let bidStartDateStrong = bidStartDate else {
            return ""
        }
        
        print("Bid End Date:", bidEndDateStrong)
        let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: Date(), to: bidEndDateStrong)
        let hours = diffComponents.hour
        let minutes = diffComponents.minute
       
        guard let hours = hours else { return ""}
        guard let minutes = minutes else { return ""}
        if (hours < 0 || minutes < 0) {
            CurrentCardBidFetchManager().updateBidStatus(cardID: card.cardID!)
            CurrentCardBidFetchManager().updateWinnings(cardID: card.cardID!)
            return "Bid Closed"
        }
        
         return "\(hours) hrs : \(minutes) mins"
    }
}

//struct DetailCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCardView()
//    }
//}
