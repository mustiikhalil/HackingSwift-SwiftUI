//
//  ContentView.swift
//  Scramble
//
//  Created by Mustafa Khalil on 12/18/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import SwiftUI

class ScrambleViewModel: ObservableObject {
    
    @Published var input = ""
    @Published var words: [String] = []
    
    func addNewWord() {
        let answered = input.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answered.count > 0 else { return }
        words.append(answered)
        input = ""
    }
}

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
            }.navigationBarTitle("Scramble")
        }
    }
}

struct Cell: View {
    var name: String
    var count: Int
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(name)
        }
    }
    
    var imageName: String {
        return "\(count).circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScrambleView()
    }
}
