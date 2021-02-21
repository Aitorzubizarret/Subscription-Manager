//
//  CalendarDayElement.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 05/11/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct CalendarDayElement: View {
    
    // MARK: - Properties
    
    enum NumberOrText {
        case letter
        case number
    }
    private var value: String
    private var selected: Bool
    private var backgroundColor: Color
    private var foregroundColor: Color
    private var widthAndHeight: CGFloat = 40
    
    // MARK: - Methods
    
    init(type: NumberOrText, value: String, selected: Bool) {
        
        self.value = value.uppercased()
        self.selected = selected
        
        // Color.
        switch type {
        case NumberOrText.letter:
            self.backgroundColor = Color.clear
            self.foregroundColor = Color.black
        case NumberOrText.number:
            if self.value != "" {
                if selected {
                    self.backgroundColor = Color.customRowBlue
                    self.foregroundColor = Color.white
                } else {
                    self.backgroundColor = Color.customGrayButton
                    self.foregroundColor = Color.customDarkText
                }
            } else {
                self.backgroundColor = Color.clear
                self.foregroundColor = Color.clear
                self.value = ""
            }
        }
    }
    
    // MARK: - View
    
    var body: some View {
        Text(self.value)
            .frame(width: self.widthAndHeight, height: self.widthAndHeight, alignment: .center)
            .font(Font.system(size: 14, weight: Font.Weight.medium, design: Font.Design.monospaced))
            .foregroundColor(self.foregroundColor)
            .background(self.backgroundColor)
            .cornerRadius(self.widthAndHeight / 2)
    }
}

struct CalendarDayElement_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarDayElement(type: .letter, value: "Mon", selected: false)
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Day name")
            
            CalendarDayElement(type: .number, value: "1", selected: false)
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Day")
            
            CalendarDayElement(type: .number, value: "3", selected: true)
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Selected day")
        }
        
    }
}
