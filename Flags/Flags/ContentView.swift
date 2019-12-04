//
//  ContentView.swift
//  Flags
//
//  Created by Mustafa Khalil on 10/14/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var randomCountry = Int.random(in: 0...2)
    
    @State private var showScore = false
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.pink, Color(.systemPurple)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack(spacing: 10) {
                    Text("Flags").foregroundColor(.white)
                    Text(countries[randomCountry]).foregroundColor(.white).font(.largeTitle).fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.check(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original).clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 1)).shadow(color: .black, radius: 2)
                    }
                }
                Spacer()
            }
        }.alert(isPresented: $showScore) {
            Alert(title: Text("\(score)"),
                  message: Text("Do you wanna play more???"),
                  dismissButton: .default(Text("Ask"), action: {
                    self.askQuestion()
                  }))
        }
    }
    
    func check(_ flag: Int) {
        if flag == randomCountry {
            score += 1
        }
        showScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        randomCountry = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
