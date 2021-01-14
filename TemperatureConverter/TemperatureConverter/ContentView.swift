//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Lee Burrows on 14/01/2021.
//

import SwiftUI

enum Units: String {
    case Celcius = "Celcius"
    case Farenheit = "Farenheit"
    case Kelvin = "Kelvin"
    
    var unitType: UnitTemperature {
        switch self {
        case .Celcius:
            return .celsius
        case .Farenheit:
            return .fahrenheit
        case .Kelvin:
            return .kelvin
        }
    }
}

struct ContentView: View {
    
    @State private var fromOption = 0
    @State private var toOption = 0
    @State private var inputValue: String = ""
    var options: [Units] = [.Celcius, .Farenheit, .Kelvin]
    
    var conversion: Double {
        let userValue = Double(inputValue) ?? 0
        let fromTypeUnit = options[fromOption].unitType
        let toTypeUnit = options[toOption].unitType
        
        let fromMeasurement = Measurement(value: userValue, unit: fromTypeUnit)
        return fromMeasurement.converted(to: toTypeUnit).value

    }
    
    var body: some View {
        Form {
            Section(header: Text("Convert Value")) {
                TextField("Input", text: $inputValue)
            }
            Section(header: Text("From")) {
                Picker("Units", selection: $fromOption) {
                    ForEach(0 ..< options.count) {
                        Text(options[$0].rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("To")) {
                Picker("Units", selection: $toOption) {
                    ForEach(0 ..< options.count) {
                        Text(options[$0].rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Result")) {
                Text("\(conversion, specifier: "%.2f")")
            }
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
