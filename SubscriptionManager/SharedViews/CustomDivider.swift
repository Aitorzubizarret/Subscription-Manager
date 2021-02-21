//
//  CustomDivider.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 18/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct CustomDivider: View {
    
    // MARK: - Properties
    
    let lightColor: Color = Color.customLightGrey
    let darkColor: Color = Color.customDarkGrey
    let rectangleWidth: CGFloat = 14
    let strokeWidth: CGFloat = 1
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(lightColor)
                .frame(height: rectangleWidth)
                .overlay(Rectangle().stroke(darkColor, lineWidth: strokeWidth))
        }
    }
}

struct CustomDivider_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomDivider()
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
