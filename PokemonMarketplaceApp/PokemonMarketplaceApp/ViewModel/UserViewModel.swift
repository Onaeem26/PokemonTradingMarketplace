//
//  UserViewModel.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/27/22.
//

import Foundation
class UserViewModel: ObservableObject {
    @Published var user = UserDataModel()
    
    func fetchCards(id: String) {
        UserNetworkManager().fetchUser(userid: id) { user in
            self.user = user
        }
    }
}
