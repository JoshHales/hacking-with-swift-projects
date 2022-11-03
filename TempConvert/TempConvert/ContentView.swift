//
//  ContentView.swift
//  TempConvert
//
//  Created by Joshua Hales on 21/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var inputTempUnit = ""
    @State private var outputTempUnit = ""
    @State private var inputTempValue = 0.0
    @FocusState private var amountIsFocused: Bool
    
    
    let units = ["Celsius","Fahrenheit", "Kelvin"]
    
    var convertedTemperature: Double {
        
        let tempValue = Double(inputTempValue)
        var celsiusValue = Double(0)
        var convertedValue = Double(0)
        
        switch inputTempUnit {
        case "Fahrenheit":
            celsiusValue = (tempValue - 32) / 1.8
        case "Kelvin":
            celsiusValue = tempValue - 273.15
        default:
            celsiusValue = tempValue
        }
        
        switch outputTempUnit {
        case "Fahrenheit":
            convertedValue = (celsiusValue * 1.8) + 32
        case "Kelvin":
            convertedValue = celsiusValue + 273.15
        default:
            convertedValue = celsiusValue
        }
        return convertedValue
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("What unit would you like to convert from?", selection: $inputTempUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("What unit would you like to convert from?")
                }
                Section {
                    Picker("What unit would you like to convert to?", selection: $outputTempUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("What unit would you like to convert to?")
                }
                Section {
                    TextField("Temperature", value: $inputTempValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                } header: {
                    Text("Input temperature - \(inputTempUnit)")
                }
                Section {
                    Text(convertedTemperature, format: .number)
                } header: {
                    Text("Converted Temperature - \(outputTempUnit)")
                }
                
            }
            .navigationTitle("Temp Convert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
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
