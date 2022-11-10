//
//  AddDataView.swift
//  Life Tracker
//
//  Created by Kiki on 10/11/2022.
//

import SwiftUI
//import SwiftUIKit

let components: [String] = ["Argent", "Amour", "Amis", "Famille", "Études", "Emploi", "Équipements", "Logement", "Santé", "Sport", "Activité sexuelle", "Reconnaissance", "Bonheur"]
let icons: [String] = ["dollarsign.circle.fill", "heart.circle.fill", "person.3.fill", "figure.2.and.child.holdinghands", "studentdesk", "latch.2.case.fill", "macbook.and.iphone", "house.fill", "cross.fill", "dumbbell.fill", "18.circle.fill", "hands.clap.fill", "face.smiling"]

struct AddDataView: View {
    var body: some View {
        TabView {
            // Money view
            MoneyView(title: components[0], icon: icons[0])
            
            // Every other view
            ForEach((1...12), id: \.self) {
                ComponentView(title: components[$0], icon: icons[$0])
            }
        }
        .onAppear() {
            UIPageControl.appearance().currentPageIndicatorTintColor = .blue
            UIPageControl.appearance().pageIndicatorTintColor = .gray
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct AddDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddDataView()
    }
}

struct MoneyView: View {
    @State var title: String
    @State var icon: String
    
    @State private var value = 0.0
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icons[0])
                    .foregroundColor(.orange)
                    .imageScale(.large)
                Text(components[0])
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
            }
            //CurrencyTextField("Amount", value: self.$value)
        }
    }
}

struct ComponentView: View {
    @State var title: String
    @State var icon: String
    var body: some View {
        HStack {
            Image(systemName: self.icon)
                .foregroundColor(.orange)
                .imageScale(.large)
            Text(self.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(/*@START_MENU_TOKEN@*/.orange/*@END_MENU_TOKEN@*/)
        }
        
    }
}

