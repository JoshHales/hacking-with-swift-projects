//
//  ContentView.swift
//  WeSplit
//
//  Created by Joshua Hales on 20/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = (0..<101)
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = Double(checkAmount / 100 * tipSelection)
        let grandTotal = Double(checkAmount + tipValue)
        let amountPerPerson = Double(grandTotal / peopleCount)
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = Double(checkAmount / 100 * tipSelection)
        let grandTotal = Double(checkAmount + tipValue)
        
        return grandTotal
        
    }
    
    var localCurrency: FloatingPointFormatStyle<Double>.Currency {
           let currencyCode = Locale.current.currencyCode ?? "USD"
           return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
       }

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: localCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
                header: {
                    Text("Amount per person")
            }
                
                Section {
                    Text(totalAmount, format: localCurrency)
                    .foregroundColor(tipPercentage == 0 ? .red : .black )
                }
                header: {
                    Text("Total amount")
                }
            }
            .navigationTitle("WeSplit")
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
 
