//
//  ColorsField.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 24/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct ColorsField: View {
    
    // MARK: - Properties
    
    @Binding var selectedColor: String
    var title: String
    private var spacing: CGFloat {
        return (UIScreen.main.bounds.size.width - (12 * 4) - (40 * 7)) / 6
    }
    
    // MARK: - Methods
    
    init(title: String, value: Binding<String>) {
        self.title = title
        self._selectedColor = value
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.title.uppercased())
                .font(Font.system(size: 14))
                .fontWeight(Font.Weight.medium)
                .foregroundColor(Color.customDarkText)
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 0))
            HStack(spacing: self.spacing) {
                ColorElement(color: .blue, selected: false)
                ColorElement(color: .blueDark, selected: false)
                ColorElement(color: .green, selected: false)
                ColorElement(color: .greenDark, selected: false)
                ColorElement(color: .mango, selected: false)
                ColorElement(color: .orange, selected: false)
                ColorElement(color: .orangeDark, selected: false)
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
            HStack(spacing: self.spacing) {
                ColorElement(color: .pistachio, selected: false)
                ColorElement(color: .red, selected: false)
                ColorElement(color: .yellow, selected: false)
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }
}

struct SelectColorField_Previews: PreviewProvider {
    static var previews: some View {
        ColorsField(title: "Color", value: .constant("blue"))
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
