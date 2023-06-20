//
//  ContentView.swift
//  BMI Calculator
//
//  Created by Bhanuteja on 17/06/23.
//

import SwiftUI

struct BMICalculationView: View {

    @State var BMIValue: Double = 0
    @State var classification = ""
    @State var height: Double = 0
    @State var weight: Double = 0

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
    }
}

extension BMICalculationView {
    var heightDetails: some View {
        VStack {
            HStack {
                Text("Height")
                Spacer()
                Text("\(height, specifier: "%.2f")")
            }
            .padding()
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            
            Slider(value: $height, in: 1.2...2.2)
                .accentColor(.blue)
                .padding()
                .onAppear {
                    if height < 1.2 { height = 1.75 }
                }
        }
    }
}

extension BMICalculationView {
    var weightDetails: some View {
        VStack {
            HStack {
                Text("Weight")
                Spacer()
                Text("\(weight, specifier: "%.2f")")
            }
            .padding()
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            
            Slider(value: $weight, in: 20...150)
                .accentColor(.blue)
                .padding()
                .onAppear {
                    if weight < 20 { weight = 60 }
                }
        }
    }
}

extension BMICalculationView {
    var calculateBMIButton: some View {
        Button {
            generateBMIValue()
        } label: {
            Text("Calculate BMI")
                .padding()
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .background(.blue)
        }
        .padding()
    }
}

extension BMICalculationView {
    fileprivate func generateBMIValue() {
        BMIValue = weight / (height * height)
        generateClassification()
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
