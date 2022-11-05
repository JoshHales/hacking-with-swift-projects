//
//  ContentView.swift
//  BetterRest
//
//  Created by Joshua Hales on 02/11/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var idealSleepAmount = ""
    @State private var showingAlert = false
    
    
    
   static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 30
        return Calendar.current.date(from: components) ?? Date.now
    }
    
  
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    Form {
                        Section(header: Text("When do you want to wake up?")) {
                            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }.headerProminence(.increased)
                        
                        Section(header: Text("Desired amount of sleep")){
                            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        }.headerProminence(.increased)
                        
                        Section(header: Text("Daily coffee intake")) {
                            Picker("Please select", selection: $coffeeAmount) {
                                ForEach(1..<21) {
                                    Text(($0 == 1 ? "\($0) cup":"\($0) cups"))
                                } .onChange(of: coffeeAmount) { newValue in
                                    calculateBedTime()
                                }
                            }
                        }.headerProminence(.increased)
                    }
                    .background(Color.purple.opacity(0.3))
                    .onAppear { // ADD THESE
                      UITableView.appearance().backgroundColor = .clear
                    }
                    
                }
                
                Divider().frame(height: 2).background(Color.purple.opacity(0.3)).overlay(Color.black.opacity(0.6))

                VStack(spacing: 30) {
                    Spacer()
                    Text("Your ideal bedtime is...")
                        .font(.title.weight(.semibold))
                    Text(idealSleepAmount)
                        .font(.largeTitle.bold())
                    Spacer()
                }
                 .frame(height: 250)
                 .frame(maxWidth: .infinity)
                 .background(Color.purple.opacity(0.3))
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedTime(){
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is..."
            idealSleepAmount = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            idealSleepAmount = "Error calculating bedtimee"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
