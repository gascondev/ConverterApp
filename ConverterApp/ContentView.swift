//
//  ContentView.swift
//  ConverterApp
//
//  Created by Álvaro Gascón on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var value1: Double = 0.0
    @State private var fromIndex = 0
    @State private var toIndex = 0

    let converter = ["Celsius (ºC)", "Fharenheit (ºF)", "Kelvin (ºK)"]
    
    var convertedValue: Double {
        let inputValue = value1
    
        switch (fromIndex, toIndex) {
        case (0, 0): // Celsius a Celsius
            return inputValue
        case (0, 1): // Celsius a Fahrenheit
            return (inputValue * 9/5) + 32
        case (0, 2): // Celsius a Kelvin
            return inputValue + 273.15
        case (1, 0): // Fahrenheit a Celsius
            return (inputValue - 32) * 5/9
        case (1, 1): // Fahrenheit a Fahrenheit
            return inputValue
        case (1, 2): // Fahrenheit a Kelvin
            return (inputValue + 459.67) * 5/9
        case (2, 0): // Kelvin a Celsius
            return inputValue - 273.15
        case (2, 1): // Kelvin a Fahrenheit
            return (inputValue * 9/5) - 459.67
        case (2, 2): // Kelvin a Kelvin
            return inputValue
        default:
            return 0.0
        }
    }
  
    
    var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("De:")) {
                        Picker(selection: $fromIndex, label: Text("")) {
                            ForEach(0..<converter.count, id: \.self) {
                                Text(self.converter[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("A:")) {
                        Picker(selection: $toIndex, label: Text("")) {
                            ForEach(0..<converter.count, id: \.self) {
                                Text(self.converter[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Grados \(converter[fromIndex])")) {
                        TextField("Grados", text: Binding(
                            get: { "\(self.value1)" },
                            set: {
                                if let newValue = NumberFormatter().number(from: $0) {
                                    self.value1 = newValue.doubleValue
                                }
                            })
                        )
                        
                    }
                    
                    Section(header: Text("Grados \(converter[toIndex])")) {
                        Text("\(String(format: "%.2f", convertedValue))")
                    }
                }
                .navigationTitle("Conversor")
            }
        }
    }

#Preview {
    ContentView()
}
