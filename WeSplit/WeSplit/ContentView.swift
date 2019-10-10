//
//  ContentView.swift
//  WeSplit
//
//  Created by Mustafa Khalil on 10/10/19.
//  Copyright © 2019 space. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount: String = ""
    @State private var numberOfPeople: Int = 0
    @State private var tip = 0
    
    private var tipsArray = [5, 10, 15, 20, 25]
    
    private var totalAmount: Double {
        let _tip = Double(tipsArray[tip])
        let _checkAmount: Double = Double(checkAmount) ?? 0
        let tipValue = _checkAmount / Double(100) * _tip
        return _checkAmount + tipValue
    }
    
    private var actualNumberOfPeople: Int { return numberOfPeople + 2 }
    
    private var amountPerPerson: Double {
        let numOfPeople = Double(actualNumberOfPeople)
        return  totalAmount / numOfPeople
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Number of people: \(actualNumberOfPeople)")
                    Text("Amount: \(checkAmount)")
                    Text("Total Per person: \(amountPerPerson, specifier: "%.2f")")
                    Text("Total: $\(totalAmount, specifier: "%.2f")")
                }
                Section {
                    TextField("Check amount", text: $checkAmount).keyboardType(.decimalPad)
                }
                Section(header: Text("Selection: ")) {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<10) {
                            Text("Number of people: \($0)")
                        }
                    }
                    Picker("Tip Amount", selection: $tip) {
                        ForEach(0..<tipsArray.count) {
                            Text("\(self.tipsArray[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            
        }
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
