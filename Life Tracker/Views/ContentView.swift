//
//  ContentView.swift
//  Life Tracker
//
//  Created by Kiki on 10/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var showMenu = false
    @State var showNew = false
    @State var showHistory = false
    @State var showTrends = false
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        return NavigationView {
            GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            MainView(showMenu: self.$showMenu, showNew: self.$showNew, showHistory: self.$showHistory, showTrends: self.$showTrends, width: geometry.size.width*0.75)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                                .disabled(self.showMenu ? true: false)
                            if self.showMenu {
                                MenuView()
                                    .frame(width: geometry.size.width/1.2)
                                    .transition(.move(edge: .leading))
                            }
                        }
                        .gesture(drag)
                    }
            .navigationBarTitle("Menu", displayMode: .inline)
            .navigationBarItems(leading:(
            Button(action: {
                withAnimation {
                    self.showMenu.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MainView: View {
    
    @Binding var showMenu: Bool
    @Binding var showNew: Bool
    @Binding var showHistory: Bool
    @Binding var showTrends: Bool
    
    @State var width: CGFloat
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    self.showHistory = true
                }
                                    }) {
                Text("Historique")
            }
            .buttonStyle(GrowingButton(width: self.width))
            .padding()
            Button(action: {
                withAnimation {
                    self.showTrends = true
                }
            }) {
                Text("Tendances")
            }
            .buttonStyle(GrowingButton(width: self.width))
            Button(action: {
                withAnimation {
                    self.showNew = true
                }
            }) {
                Text("Ajouter des données")
            }
            .buttonStyle(GrowingButton(width: self.width))
            .padding()
            
        }
    }
}

struct GrowingButton: ButtonStyle {
    
    @State var width: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: self.width, height: 70)
            .padding()
            .background(Color(hue: 0.472, saturation: 0.676, brightness: 0.574))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.3 : 1)
            .animation(.easeOut, value: configuration.isPressed)
            .font(.title)
    }
}
