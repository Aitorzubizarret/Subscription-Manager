//
//  CycleField.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 27/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct CycleField: View {
    
    // MARK: - Properties
    
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
    private var everyText: String = ""
    private var dayText: String = ""
    private var weekText: String = ""
    private var monthText: String = ""
    private var yearText: String = ""
    private var daysText: String = ""
    private var weeksText: String = ""
    private var monthsText: String = ""
    private var yearsText: String = ""
    
    // MARK: - Methods
    
    init(title: String, value: Binding<String>) {
        self.title = title
        self._textfieldValue = value
        
        self.localizeText()
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
                let cycleText: String = self.everyText + " \(str)"
                self._cycleText = State(wrappedValue: String(format: cycleText))
            } else {
                var cycleText: String = self.everyText + "\(self.value) "
                switch str {
                case self.dayText:
                    cycleText = self.cycleText + "\(self.daysText)"
                case self.weekText:
                    cycleText = self.cycleText + "\(self.weeksText)"
                case self.monthText:
                    cycleText = self.cycleText + "\(self.monthsText)"
                case self.yearText:
                    cycleText = self.cycleText + "\(self.yearsText)"
                default:
                    cycleText = self.cycleText + "¿?"
                }
                self._cycleText = State(wrappedValue: String(format: cycleText))
            }
        }
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get strings from localizable.
        self.everyText = NSLocalizedString("cycleFieldEvery", comment: "")
        self.dayText = NSLocalizedString("cycleFieldDay", comment: "")
        self.weekText = NSLocalizedString("cycleFieldWeek", comment: "")
        self.monthText = NSLocalizedString("cycleFieldMonth", comment: "")
        self.yearText = NSLocalizedString("cycleFieldYear", comment: "")
        self.daysText = NSLocalizedString("cycleFieldDays", comment: "")
        self.weeksText = NSLocalizedString("cycleFieldWeeks", comment: "")
        self.monthsText = NSLocalizedString("cycleFieldMonths", comment: "")
        self.yearsText = NSLocalizedString("cycleFieldYears", comment: "")
    }
    
    ///
    /// Calculates the text of the cycle.
    ///
    private func calculateCycleText() {
        let str: String = checkUnit()
        
        if self.value == "1" {
            self.cycleText = self.everyText + " \(str)"
        } else {
            self.cycleText = self.everyText + "\(self.value) "
            switch str.lowercased() {
            case self.dayText:
                self.cycleText = self.cycleText + "\(self.daysText)"
            case self.weekText:
                self.cycleText = self.cycleText + "\(self.weeksText)"
            case self.monthText:
                self.cycleText = self.cycleText + "\(self.monthsText)"
            case self.yearText:
                self.cycleText = self.cycleText + "\(self.yearsText)"
            default:
                self.cycleText = self.cycleText + "¿?"
            }
        }
        
        self.textfieldValue = "\(self.value)-\(self.unit)"
    }
    
    ///
    /// Compares the unit and sends back a Localized string.
    /// - Returns : Returns the unit as a string. Ex. d = day, w = week. m = month, ...
    ///
    private func checkUnit() -> String {
        var str: String = ""
        
        switch self.unit {
        case "d":
            str = self.dayText
        case "w":
            str = self.weekText
        case "m":
            str = self.monthText
        case "y":
            str = self.yearText
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
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            FieldTitle(title: self.title)
            HStack(spacing: 0) {
                Button(action: {
                    self.decreaseValue()
                }) {
                    Image(systemName: "minus")
                        .font(Font.system(size: 18))
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
                    Image(systemName: "plus")
                        .font(Font.system(size: 18))
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
                        Text(self.dayText.capitalized)
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
                        Text(self.dayText.capitalized)
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
                        Text(self.weekText.capitalized)
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
                        Text(self.weekText.capitalized)
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
                        Text(self.monthText.capitalized)
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
                        Text(self.monthText.capitalized)
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
                        Text(self.yearText.capitalized)
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
                        Text(self.yearText.capitalized)
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
