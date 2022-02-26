//
//  HomeView.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/17/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var pokemonCardFeedViewModel = PokemonCardsFeedViewModel()
    var body: some View {
    
        TabView {
            FeedView(viewModel: pokemonCardFeedViewModel)
                .tabItem {
                    Label("Feed", systemImage: "list.dash")
                }

            AccountView()
                .tabItem {
                    Label("Account", systemImage: "square.and.pencil")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
