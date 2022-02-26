//
//  FeedView.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/17/22.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel: PokemonCardsFeedViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.pokemonCards, id: \.id) { item in
                        CardView(cardItem: item)
                }
            }.navigationTitle("Feed")
            .toolbar {
                Button {
                    print("Add Listing")
                } label: {
                    Image(systemName: "plus")
                }

            }
        }.onAppear {
            viewModel.fetchCards()
        }
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
