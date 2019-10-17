//
//  ContentView.swift
//  Flags
//
//  Created by Mustafa Khalil on 10/14/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var randomCountry = Int.random(in: 0...2)
    var body: some View {
        ZStack {
            Color(.systemPurple).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Flags").foregroundColor(.white)
                    Text(countries[randomCountry]).foregroundColor(.white)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        print("something selected")
                    }) {
                        Image(self.countries[number]).renderingMode(.original)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
