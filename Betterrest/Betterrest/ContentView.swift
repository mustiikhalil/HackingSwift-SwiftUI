//
//  ContentView.swift
//  Betterrest
//
//  Created by Mustafa Khalil on 12/13/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import SwiftUI

class BetterRestViewModel: ObservableObject {
    
    static var defaultWakeupTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    @Published var wakeupTime = defaultWakeupTime
    @Published var sleepHours = 8.0
    @Published var coffeeIntake = 1
    
    var calculateBedTime: String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeupTime)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let output = try model.prediction(input: SleepCalculatorInput(wake: Double(hour + minute), estimatedSleep: sleepHours, coffee: Double(coffeeIntake)))
            
            let sleepTime = wakeupTime - output.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return "Is required: \(formatter.string(from: sleepTime))"
        } catch {
            return "Some error happened oops"
        }
    }
}

struct BetterRestView: View {
    
    @EnvironmentObject var viewModel: BetterRestViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Headline(text: "Need to sleep by: \(viewModel.calculateBedTime)")
                    }
                    Section {
                        Headline(text: "When do you want to wake up?")
                        DatePicker("Please enter time", selection: $viewModel.wakeupTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    Section {
                        Headline(text: "Desired Amount of sleep")
                        Stepper(value: $viewModel.sleepHours, in: 4...12, step: 0.25) {
                            Text("\(viewModel.sleepHours, specifier: "%g") hours")
                        }
                        
                        Headline(text: "Coffee amount")
                        Picker("\(viewModel.coffeeIntake) cups", selection: $viewModel.coffeeIntake) {
                            ForEach(1...20) { Text("\($0)") }
                        }
                    }
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
}

extension Int: Identifiable {
    public var id: Int {
        return self
    }
}

struct Headline: View {
    var text: String
    var body: some View {
        Text(text).font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BetterRestView()
    }
}
