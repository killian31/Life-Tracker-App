//
//  MenuView.swift
//  Life Tracker
//
//  Created by Kiki on 10/11/2022.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                print("Show profile view")
            }) {
                HStack {
                    Image(systemName: "person")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                    
                    Text("Profil")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .padding(.top, 100)
            }
            Button(action: {
                print("Show settings view")
            }) {
                HStack {
                    Image(systemName: "gear")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                  
                    Text("Settings")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .padding(.top, 15)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
