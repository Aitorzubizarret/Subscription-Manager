//
//  ColorElement.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 24/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct ColorElement: View {
    
    // MARK: - Properties
    
    private var widthAndHeight: CGFloat = 40
    private var rowColor: SubscriptionsViewModel.subscriptionRowColor
    private var selectedColor: Color
    private var selected: Bool
    
    // MARK: - Methods
    
    init(color: SubscriptionsViewModel.subscriptionRowColor, selected: Bool) {
        self.rowColor = color
        self.selected = selected
        
        switch self.rowColor {
        case .blue:
            self.selectedColor = Color.customRowBlue
        case .blueDark:
            self.selectedColor = Color.customRowBlueDark
        case .green:
            self.selectedColor = Color.customRowGreen
        case .greenDark:
            self.selectedColor = Color.customRowGreenDark
        case .mango:
            self.selectedColor = Color.customRowMango
        case.orange:
            self.selectedColor = Color.customRowOrange
        case .orangeDark:
            self.selectedColor = Color.customRowOrangeDark
        case .pistachio:
            self.selectedColor = Color.customRowPistachio
        case .red:
            self.selectedColor = Color.customRowRed
        case .yellow:
            self.selectedColor = Color.customRowYellow
        }
    }
    
    // MARK: - View
    
    var body: some View {
        Text("")
            .frame(width: self.widthAndHeight, height: self.widthAndHeight, alignment: .center)
            .background(self.selectedColor)
            .cornerRadius(20)
    }
}

struct ColorElement_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorElement(color: .blue, selected: false)
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Not Selected")
            
            ColorElement(color: .blue, selected: true)
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Selected")
        }
        
    }
}
