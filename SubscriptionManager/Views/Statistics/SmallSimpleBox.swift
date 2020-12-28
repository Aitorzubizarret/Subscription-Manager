//
//  SmallSimpleBox.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 12/11/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SmallSimpleBox: View {
    
    // MARK: - Properties
    
    var value: Int
    var descriptionText: String
    private var boxSize: CGFloat {
        return ((UIScreen.main.bounds.size.width / 3) - 8 - 8 - 12 - 12)
    }
    
    // MARK: - Methods
    
    init(value: Int, descriptionText: String) {
        self.value = value
        self.descriptionText = descriptionText.uppercased()
    }
    
    // MARK: - View
    
    var body: some View {
        VStack {
            Text("\(self.value)")
                .font(Font.system(size: 50, weight: Font.Weight.medium, design: Font.Design.default))
                .foregroundColor(Color.white)
            Text(self.descriptionText)
                .font(Font.system(size: 12, weight: Font.Weight.light, design: Font.Design.monospaced))
                .foregroundColor(Color.white)
        }
        .frame(width: self.boxSize, height: self.boxSize, alignment: .center)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .background(Color.customRowMango)
        .cornerRadius(6)
    }
}

struct SmallSimpleBox_Previews: PreviewProvider {
    static var previews: some View {
        SmallSimpleBox(value: 3, descriptionText: "Subscriptions")
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
    }
}
