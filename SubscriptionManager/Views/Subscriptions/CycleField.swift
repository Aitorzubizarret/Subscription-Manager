//
//  CycleField.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 27/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct CycleField: View {
    
    //MARK: - Properties
    
    @Binding var textfieldValue: String
    @State private var cycleText: String = ""
    @State private var value: String = "" {
        didSet {
            self.calculateCycleText()
        }
    }
    @State private var unit: String = "" {
        didSet {
            self.calculateCycleText()
        }
    }
    var title: String
    private var textWidth: CGFloat {
        return (UIScreen.main.bounds.size.width - 12 - 88 - 24 - 4 - 12)
    }
    private var buttonWitdh: CGFloat {
        return (UIScreen.main.bounds.size.width / 4) - 14
    }
    
    //MARK: - Methods
    
    init(title: String, value: Binding<String>) {
        self.title = title
        self._textfieldValue = value
        
        self.configureUIElements()
    }
    
    ///
    /// Configures the UI elements.
    ///
    private mutating func configureUIElements() {
        let cycleComponents: [String] = self.textfieldValue.components(separatedBy: "-")
        
        if cycleComponents.count == 2 {
            self._value = State(wrappedValue: cycleComponents[0])
            self._unit = State(wrappedValue: cycleComponents[1])
            
            // CycleText.
            let str: String = checkUnit()
            if self.value == "1" {
                self._cycleText = State(wrappedValue: "Every \(str)")
            } else {
                self._cycleText = State(wrappedValue: "Every \(self.value) \(str)s")
            }
        }
    }
    
    ///
    /// Calculates the text of the cycle.
    ///
    private func calculateCycleText() {
        let str: String = checkUnit()
        
        if self.value == "1" {
            self.cycleText = "Every \(str)"
        } else {
            self.cycleText = "Every \(value) \(str)s"
        }
        
        self.textfieldValue = "\(self.value)-\(self.unit)"
    }
    
    ///
    /// Compares the unit and sends back a string.
    ///
    private func checkUnit() -> String {
        var str: String = ""
        
        switch self.unit {
        case "d":
            str = "day"
        case "w":
            str = "week"
        case "m":
            str = "month"
        case "y":
            str = "year"
        default:
            str = "¿?"
        }
        
        return str
    }
    
    ///
    /// Increases the value by 1.
    ///
    private func increaseValue() {
        let value: Int? = Int(self.value)
        if let intValue = value {
            if intValue < 10 {
                self.value = "\(intValue + 1)"
            }
        }
    }
    
    ///
    /// Decreases the value by 1.
    ///
    private func decreaseValue() {
        let value: Int? = Int(self.value)
        if let intValue = value {
            if intValue > 1 {
                self.value = "\(intValue - 1)"
            }
        }
    }
    
    //MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            FieldTitle(title: self.title)
            HStack(spacing: 0) {
                Button(action: {
                    self.decreaseValue()
                }) {
                    Text("-")
                        .font(Font.system(size: 22))
                        .fontWeight(Font.Weight.heavy)
                        .foregroundColor(Color.customDarkText)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .frame(width: 44, height: 44, alignment: .center)
                        .background(RoundedCorners(upperLeft: 10, upperRight: 0, lowerLeft: 10, lowerRigth: 0))
                        .foregroundColor(Color.customGrayButton)
                }
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 3))
                Text(self.cycleText)
                    .font(Font.system(size: 16))
                    .fontWeight(Font.Weight.medium)
                    .foregroundColor(Color.black)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .frame(width: self.textWidth, height: 44, alignment: .center)
                    .background(Color.customGrayButton)
                Button(action: {
                    self.increaseValue()
                }) {
                    Text("+")
                        .font(Font.system(size: 22))
                        .fontWeight(Font.Weight.heavy)
                        .foregroundColor(Color.customDarkText)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .frame(width: 44, height: 44, alignment: .center)
                        .background(RoundedCorners(upperLeft: 0, upperRight: 10, lowerLeft: 0, lowerRigth: 10))
                        .foregroundColor(Color.customGrayButton)
                        
                }
                .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 12))
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
            HStack(spacing: 0) {
                Button(action: {
                    self.unit = "d"
                }) {
                    if self.unit == "d" {
                        Text("Day")
                        .font(Font.system(size: 16))
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(Color.customDarkText)
                        .frame(width: self.buttonWitdh, height: 36, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customGrayBorderButton, lineWidth: 1)
                        )
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    } else {
                        Text("Day")
                        .font(Font.system(size: 16))
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(Color.customDarkText)
                        .frame(width: self.buttonWitdh, height: 44, alignment: .center)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                Button(action: {
                    self.unit = "w"
                }) {
                    if self.unit == "w" {
                        Text("Week")
                        .font(Font.system(size: 16))
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(Color.customDarkText)
                        .frame(width: self.buttonWitdh, height: 36, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customGrayBorderButton, lineWidth: 1)
                        )
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    } else {
                        Text("Week")
                        .font(Font.system(size: 16))
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(Color.customDarkText)
                        .frame(width: self.buttonWitdh, height: 44, alignment: .center)
                    }
                    
                }
                Button(action: {
                    self.unit = "m"
                }) {
                    if self.unit == "m" {
                        Text("Month")
                        .font(Font.system(size: 16))
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(Color.customDarkText)
                        .frame(width: self.buttonWitdh, height: 36, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customGrayBorderButton, lineWidth: 1)
                        )
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    } else {
                        Text("Month")
                        .font(Font.system(size: 16))
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(Color.customDarkText)
                        .frame(width: self.buttonWitdh, height: 44, alignment: .center)
                    }
                    
                }
                Button(action: {
                    self.unit = "y"
                }) {
                    if self.unit == "y" {
                        Text("Year")
                        .font(Font.system(size: 16))
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(Color.customDarkText)
                        .frame(width: self.buttonWitdh, height: 36, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customGrayBorderButton, lineWidth: 1)
                        )
                        .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    } else {
                        Text("Year")
                        .font(Font.system(size: 16))
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(Color.customDarkText)
                        .frame(width: self.buttonWitdh, height: 44, alignment: .center)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
            }
            .background(Color.customGrayButton)
            .cornerRadius(10)
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
        }
        .background(Color.white)
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }
}

struct CycleField_Previews: PreviewProvider {
    static var previews: some View {
        CycleField(title: "Cycle", value: .constant("2-w"))
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
