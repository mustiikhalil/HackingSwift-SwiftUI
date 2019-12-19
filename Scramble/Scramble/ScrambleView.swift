//
//  ContentView.swift
//  Scramble
//
//  Created by Mustafa Khalil on 12/18/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import SwiftUI

struct ScrambleView: View {
    
    @EnvironmentObject var viewModel: ScrambleViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    TextField("Enter world", text: $viewModel.input, onCommit: viewModel.addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                }.padding()
                List {
                    Section {
                        ForEach(viewModel.words, id: \.self) {
                            Cell(name: $0, count: $0.count)
                        }
                    }
                }
            }
            .navigationBarTitle("Scramble")
            .alert(isPresented: $viewModel.errorShowed) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        .onAppear(perform: viewModel.startGame)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScrambleView()
    }
}
