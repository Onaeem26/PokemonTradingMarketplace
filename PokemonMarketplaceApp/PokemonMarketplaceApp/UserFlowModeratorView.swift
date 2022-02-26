//
//  UserFlowModeratorView.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 1/25/22.
//

import SwiftUI
import Firebase

struct UserFlowModeratorView: View {
    @AppStorage("loginState") var loginStatus = false
    var body: some View {
        if loginStatus {
            HomeView()
//            VStack {
//            Text("Login Successfull")
//            Text(Auth.auth().currentUser?.email ?? "")
//            }
//            Button {
//                do {
//                    try Auth.auth().signOut()
//                    loginStatus = false
//                } catch let signOutError as NSError {
//                  print("Error signing out: %@", signOutError)
//                }
//            } label: {
//                Text("Sign out!")
//            }

        }else {
            ContentView()
        }
    }
}

struct UserFlowModeratorView_Previews: PreviewProvider {
    static var previews: some View {
        UserFlowModeratorView()
    }
}
