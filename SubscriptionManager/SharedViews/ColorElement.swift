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
    private var backgroundColor: Color
    private var borderColor: Color
    private var selected: Bool
    
    // MARK: - Methods
    
    init(color: SubscriptionsViewModel.subscriptionRowColor, selected: Bool) {
        self.backgroundColor = color.convertFromStringToColor()
        self.selected = selected
        
        if self.selected {
            self.borderColor = Color.black.opacity(0.3)
        } else {
            self.borderColor = Color.clear
        }
    }
    
    // MARK: - View
    
    var body: some View {
        Text("")
            .frame(width: self.widthAndHeight, height: self.widthAndHeight, alignment: .center)
            .background(self.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(self.borderColor, lineWidth: 10)
            )
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
