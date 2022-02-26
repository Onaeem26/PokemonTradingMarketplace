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
    var body: some View {
        NavigationView {
            Form {
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
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
