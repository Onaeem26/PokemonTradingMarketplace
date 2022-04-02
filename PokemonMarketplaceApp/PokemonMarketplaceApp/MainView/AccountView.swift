//
//  AccountView.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/17/22.
//

import SwiftUI
import Firebase

struct AccountView: View {
    @AppStorage("loginState") var loginStatus = false
    @ObservedObject var viewModel: FetchWinningsViewModel
    var body: some View {
        NavigationView {
            Form {
                Section {
                    if (viewModel.winningCards.count > 0) {
                        VStack(alignment: .leading) {
                                ForEach(viewModel.winningCards, id: \.id) { item in
                                    HStack {
                                        AsyncImage(
                                            url: URL(string: item.image ?? ""),
                                               content: { image in
                                                   image.resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 50, height: 75)
                                               },
                                               placeholder: {
                                                   ProgressView()
                                               }
                                        ).padding(.horizontal, 16)
                                        .shadow(color: .gray, radius: 5, x: 0, y: 0)
                                        
                                        Text(item.cardName ?? "")
                                            .font(.body)
                                            .frame(alignment: .leading)
                                            .padding(.leading, 16)
                                        
                                    }
                                    
                                }
                            
                        }
                    }else {
                        Text("No Winning Cards available")
                    }
                } header: {
                    Text("Winnings")
                }

                Button {
                    do {
                        try Auth.auth().signOut()
                        loginStatus = false
                    } catch let signOutError as NSError {
                      print("Error signing out: %@", signOutError)
                    }
                } label: {
                    Text("Sign Out")
                }
            }.navigationTitle("Account")
            .onAppear {
                guard let userID = Auth.auth().currentUser?.uid else { return }
                print("Account User ID:",userID)
                viewModel.fetchCards(userID: userID)
            }
        }
    }
}

