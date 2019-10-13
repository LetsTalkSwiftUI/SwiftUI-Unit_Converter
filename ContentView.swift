import SwiftUI

struct ContentView: View {
    
    var conversionOptions = ["Temperature", "Length", "Volume"]
    
    var tempOptions = ["Celsius", "Fahrenheit", "Kelvin"]
    var lengthOptions = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    var volumeOptions = ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
    
    @State private var unit1: String = ""
    
    @State private var selectedConversionType: Int = 0
    @State private var inputTempUnit: Int = 0
    @State private var outputTempUnit: Int = 1
    @State private var inputLengthUnit: Int = 0
    @State private var outputLengthUnit: Int = 1
    @State private var inputVolumeUnit: Int = 0
    @State private var outputVolumeUnit: Int = 1
    
    var convertedUnit: String {
        
        let unitConvertedToDouble = Double(unit1) ?? 0.0
        var output: String
        
        if selectedConversionType == 0 {
            
            var inputTempType: UnitTemperature
            var outputTempType: UnitTemperature
            
            if inputTempUnit == 0 {
                inputTempType = .celsius
            } else if inputTempUnit == 1 {
                inputTempType = .fahrenheit
            } else {
                inputTempType = .kelvin
            }
            
            let inputTemp = Measurement(value: unitConvertedToDouble, unit: inputTempType)
            
            if outputTempUnit == 0 {
                outputTempType = .celsius
            } else if outputTempUnit == 1 {
                outputTempType = .fahrenheit
            } else {
                outputTempType = .kelvin
            }
            
            output = inputTemp.converted(to: outputTempType).description
            
        } else if selectedConversionType == 1 {
            
            var inputLengthType: UnitLength
            var outputLengthType: UnitLength
            
            if inputLengthUnit == 0 {
                inputLengthType = .meters
            } else if inputLengthUnit == 1 {
                inputLengthType = .kilometers
            } else if inputLengthUnit == 2 {
                inputLengthType = .feet
            } else if inputLengthUnit == 1 {
                inputLengthType = .yards
            } else {
                inputLengthType = .miles
            }
            
            let inputLength = Measurement(value: unitConvertedToDouble, unit: inputLengthType)
            
            if outputLengthUnit == 0 {
                outputLengthType = .meters
            } else if outputLengthUnit == 1 {
                outputLengthType = .kilometers
            } else if outputLengthUnit == 2 {
                outputLengthType = .feet
            } else if outputLengthUnit == 1 {
                outputLengthType = .yards
            } else {
                outputLengthType = .miles
            }
            
            output = inputLength.converted(to: outputLengthType).description
            
        } else {
            
            var inputVolumeType: UnitVolume
            var outputVolumeType: UnitVolume
            
            if inputVolumeUnit == 0 {
                inputVolumeType = .milliliters
            } else if inputVolumeUnit == 1 {
                inputVolumeType = .liters
            } else if inputVolumeUnit == 2 {
                inputVolumeType = .cups
            } else if inputVolumeUnit == 1 {
                inputVolumeType = .pints
            } else {
                inputVolumeType = .gallons
            }
            
            let inputVolume = Measurement(value: unitConvertedToDouble, unit: inputVolumeType)
            
            if outputVolumeUnit == 0 {
                outputVolumeType = .milliliters
            } else if outputVolumeUnit == 1 {
                outputVolumeType = .liters
            } else if outputVolumeUnit == 2 {
                outputVolumeType = .cups
            } else if outputVolumeUnit == 1 {
                outputVolumeType = .pints
            } else {
                outputVolumeType = .gallons
            }
            
            output = inputVolume.converted(to: outputVolumeType).description
            
        }
        
        return output
        
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                
                Section(header: Text("Conversion Type:")) {
                    MyCustomPicker(pickerData: conversionOptions, binding: $selectedConversionType)
                }
                
                Section(header: Text("From:")) {
                    TextField("", text: $unit1)
                        .keyboardType(.decimalPad)
                    
                    if selectedConversionType == 0 {
                        MyCustomPicker(pickerData: tempOptions, binding: $inputTempUnit)
                    } else if selectedConversionType == 1 {
                        MyCustomPicker(pickerData: lengthOptions, binding: $inputLengthUnit)
                    } else if selectedConversionType == 2 {
                        MyCustomPicker(pickerData: volumeOptions, binding: $inputVolumeUnit)
                    }
                    
                }
                
                Section(header: Text("To:")) {
                    if unit1 == "" {
                        Text("Please enter number above")
                    } else {
                        Text("\(convertedUnit)")
                    }
                    
                    if selectedConversionType == 0 {
                        MyCustomPicker(pickerData: tempOptions, binding: $outputTempUnit)
                    } else if selectedConversionType == 1 {
                        MyCustomPicker(pickerData: lengthOptions, binding: $outputLengthUnit)
                    } else if selectedConversionType == 2 {
                        MyCustomPicker(pickerData: volumeOptions, binding: $outputVolumeUnit)
                    }
                    
                }
                
            }
            .navigationBarTitle("Unit Converter")
        }
    }
}


struct MyCustomPicker: View {
    
    var pickerData: [String]
    @Binding var binding: Int
    
    var body: some View {
        
        Picker("Convert", selection: $binding) {
            ForEach(0 ..< pickerData.count, id: \.self) { i in
                Text(self.pickerData[i])
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
