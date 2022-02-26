//
//  ContentView.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 1/21/22.
//

import SwiftUI
import Firebase
struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                VStack {
                    HStack {
                        Spacer()
                    }
                    
                    Text("Pokemon Trading Marketplace")
                        .bold()
                        .padding()
                        .font(.largeTitle)
                        .padding()
                        .padding(.top, 30)
                        

                    Spacer()
                    NavigationLink("Register", destination: RegisterView())
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 40)
                        
                    NavigationLink("Log In", destination: LoginView())
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 40)
                        
                    
//                    Button {
//                        do {
//                            try Auth.auth().signOut()
//                        } catch let signOutError as NSError {
//                          print("Error signing out: %@", signOutError)
//                        }
//                    } label: {
//                        Text("Sign Out")
//                    }
                    Spacer()

                }.padding()
            }
            .ignoresSafeArea()
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
