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
    
    @State var height: Double = 0
    @State var weight: Double = 0
    @State var isChanged = false
    @FocusState var isInputActive: Bool

    var body: some View {
        ZStack {
            Color.orange.opacity(0.8)
            
            VStack {
                Text("BMI Calculator")
                    .bold()
                    .font(.largeTitle)
                    .padding(.top, 60)
                
                heightDetails
                    .border(.white, width: 1)
                    .padding()

                weightDetails
                    .border(.white, width: 1)
                    .padding()

                calculateBMIButton
                    .padding()

                resultsDisplayView
                    .padding()

                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .alert("Enter all the details", isPresented: $hasError, actions: { }) {
            Text("All fields are mandatory")
        }
    }
}

extension BMICalculationView {
    var heightDetails: some View {
        VStack {
            Text("Height")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.title2)
                .padding(.top)
            
            TextField("Enter Height (in meteres)", text: $heightValue)
                .padding(.all)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .shadow(radius: 5)
                .focused($isInputActive)
                .onChange(of: heightValue, perform: { _ in
                    validateForm()
                })
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isInputActive = false
                        }
                    }
                }
            
            Slider(value: $height, in: 1.2...2.2, onEditingChanged: { _ in
                if isChanged == false { isChanged = true }
                heightValue = String(format: "%.2f", height)
            })
            .accentColor(.blue)
            .padding()
            .onTapGesture {
                isChanged = true
            }
            .onAppear {
                if height < 1.2 { height = 1.75 }
                heightValue = String(format: "%.2f", height)
            }
        }
    }
}

extension BMICalculationView {
    var weightDetails: some View {
        VStack {
            Text("Weight")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.title2)
                .padding(.top)
            
            TextField("Enter Weight in Kilograms", text: $weightValue)
                .padding(.all)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .shadow(radius: 5)
                .focused($isInputActive)
                .onChange(of: weightValue) { _ in
                    if let updatedWeight = Double(weightValue) {
                        weight = Double(updatedWeight)
                        validateForm()
                    }
                }

            Slider(value: $weight, in: 20...150, onEditingChanged: { _ in
                if isChanged == false { isChanged = true }
                weightValue = String(format: "%.2f", weight)
            })
            .accentColor(.blue)
            .padding()
            .onTapGesture {
                isChanged = true
            }
            .onAppear {
                if weight < 20 { weight = 60 }
                weightValue = String(format: "%.2f", weight)
            }
        }
    }
}

extension BMICalculationView {
    var calculateBMIButton: some View {
        Button {
            validateForm()
        } label: {
            Text("Calculate BMI")
                .padding()
                .foregroundColor(.white)
                .background(.blue)
        }
        .padding()
    }
}

extension BMICalculationView {
    fileprivate func validateForm() {
        if !weightValue.isEmpty && !heightValue.isEmpty {
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

extension BMICalculationView {
    var resultsDisplayView: some View {
        VStack {
            Text("BMI: \(BMIValue, specifier: "%.2f")")
                .padding()
                .font(.title)
            
            Text(classification)
                .padding()
                .font(.title2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BMICalculationView()
    }
}
