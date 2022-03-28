//
//  CardView.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/22/22.
//

import SwiftUI

struct CardView: View {
    var cardItem: PokemonCardVModel
    @StateObject var currentBid = CurrentBidViewModel()
    var body: some View {
      //  GeometryReader { geo in
        ZStack {
            Color(UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.8))
            VStack {
                HStack(alignment: .top, spacing: 8) {
                    
                AsyncImage(
                    url: URL(string: cardItem.pokemonCardDetail.images?.small ?? ""),
                       content: { image in
                           image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 200)
                           // .frame(width: geo.size.width, height: geo.size.height)
                       },
                       placeholder: {
                           ProgressView()
                       }
                ).padding(.leading, 16)
                        .shadow(color: .gray, radius: 5, x: 0, y: 0)
                    
                    
                    
                VStack(alignment: .leading) {
                    Text(cardItem.pokemonCardDetail.name ?? "")
                        .lineLimit(2)
                        .font(.title3)
                        .foregroundColor(.black)
                    Text(cardItem.price ?? 0, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .font(.title3)
                        .padding(.top)
                        .foregroundColor(.black)
                    
                    
                    HStack {
                        
                        NavigationLink(destination: DetailCardView(card: cardItem.pokemonCardDetail, bidViewModel: self.currentBid)) {
                            Text("View More")
                        }.padding(10)
                        .background(.blue)
                        .cornerRadius(5)
                        .foregroundColor(.white)
                        
                    }.padding(.top, 4)
                
                }.padding(16)
                    
                    Spacer()
                    
                }

//                
//                Rectangle()
//                    .frame(maxWidth: .infinity, maxHeight: 1)
//                    .foregroundColor(.green)
            }
        }
        .cornerRadius(20)
        .padding(.horizontal)
        
        //
        
        //frame(width: 250, height: 400)
       
       // .background(Color.red)
        
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView().previewLayout(PreviewLayout.sizeThatFits)
//    }
//}
