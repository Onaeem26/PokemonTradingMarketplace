//
//  PostBidView.swift
//  PokemonMarketplaceApp
//
//  Created by Muhammad Osama Naeem on 2/24/22.
//

import SwiftUI

struct PostBidView: View {
    @State var bidPrice: String = ""
    @FocusState private var fieldFocus: Bool
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(spacing: 0) {
                        Text(Locale.current.currencySymbol ?? "")
                            .font(.largeTitle)
                        TextField("5", text: $bidPrice)
                            .font(.largeTitle)
                            .focused($fieldFocus)
                            .keyboardType(.numberPad)
                        
                    }.padding()
                    
                Spacer()
                    
                    Button {
                        print("Post Bid")
                    } label: {
                        Text("Post Bid")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            
                    }.disabled(bidPrice.isEmpty)

                }.padding(.top)
            }.onAppear {
                print("Hello")
                self.fieldFocus = true
            }.navigationTitle("Enter your Bid")
                .toolbar {
                    Button {
                        print("Dismiss View")
                    } label: {
                        Text("Cancel")
                    }
                }
        }
    }
}

struct PostBidView_Previews: PreviewProvider {
    static var previews: some View {
        PostBidView()
    }
}
