//
//  ContentView.swift
//  BMI Calculator
//
//  Created by Bhanuteja on 17/06/23.
//

import SwiftUI

struct BMICalculationView: View {

    @State var weightValue = ""
    @State var heightValue = ""
    @State var BMIValue: Double = 0
    @State var classification = ""
    @State var hasError = false

    var body: some View {
        VStack {
            Text("BMI Calculator:")
                .bold()
                .font(.largeTitle)
            
            TextField("Enter Weight (in kilograms)", text: $weightValue)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            
            TextField("Enter Height (in meteres)", text: $heightValue)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)

            Button {
                validateForm()
            } label: {
                Text("Calculate BMI")
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
            }
            .padding()
            
            Text("BMI: \(BMIValue, specifier: "%.2f")")
                .padding()
                .font(.title)
            
            Text(classification)
                .padding()
                .font(.title2)
            
            Spacer()
        }
        .alert("Enter all the details", isPresented: $hasError, actions: { }) {
            Text("All fields are mandatory")
        }
        .padding()
    }
    
    fileprivate func validateForm() {
        if !weightValue.isEmpty || !heightValue.isEmpty {
            generateBMIValue()
            generateClassification()
        } else {
            hasError = true
        }
    }
    
    
    fileprivate func generateBMIValue() {
        var weight: Double = 0
        var height: Double = 0
        
        if let weightInDouble = Double(weightValue) {
            weight = weightInDouble
        }
        
        if let heightInDouble = Double(heightValue) {
            height = heightInDouble
        }
        BMIValue = weight / (height * height)
    }
    
    fileprivate func generateClassification() {
        if BMIValue < 18.5 {
            classification = "You are under weight"
        } else if BMIValue < 25 {
            classification = "You are healthy weight"
        } else if BMIValue < 30 {
            classification = "You are over weight"
        } else {
            classification = "You are obese"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BMICalculationView()
    }
}
