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
                                Text("$45")
                                    .font(.title)
                                Text("Current Bid")
                                    .font(.caption)
                            }.frame(maxWidth: .infinity)
                            
                            Divider()
                            
                            VStack(alignment: .leading) {
                                Text("Osama")
                                    .font(.title2)
                                Text("Current Bidder")
                                    .font(.caption)
                            }.frame(maxWidth: .infinity)
                        
                            
                        }.padding(.horizontal, 16)
                        
                     

                    }
                    
                    Divider()
                    
                    VStack {
                        Button {
                            self.presentBidPostView = true
                        } label: {
                            Text("Bid Now")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(5)
                                .padding(.top, 12)
                                .padding(.bottom,12)
                        }
                        Text("Floor Bid is ").font(.footnote) + Text("$5").bold().font(.footnote)
                            
                    }
                    Divider()
                    
                    VStack(spacing: 0) {
                        HStack {
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                            Text("Time Remaining ")
                                .bold()
                            Spacer()
                            Text("6").bold() + Text(" days ") + Text("14").bold() + Text(" hours")
                        }.padding(.horizontal)
                        
                        
                        HStack {
                            Text("👨‍💼")
                            Text("Seller")
                                .bold()
                            Spacer()
                            Text("PokemonTradingInc")
                        }.padding(.horizontal)
                            .padding(.top, 6)
                    }
                    .padding(.bottom)
                    Spacer()
                    
                    
                
                }.padding(.top)
            }
            .sheet(isPresented: $presentBidPostView) {
                    PostBidView()
                }
        }.navigationTitle(card.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

//struct DetailCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCardView()
//    }
//}
