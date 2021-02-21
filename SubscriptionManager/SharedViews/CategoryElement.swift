//
//  CategoryElement.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 02/01/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct CategoryElement: View {
    
    // MARK: - Properties
    
    var text: String
    var selected: Bool
    private var textWitdh: CGFloat {
        return (UIScreen.main.bounds.size.width - 44) - 14 - 24
    }
    
    // MARK: - Methods
    
    init(text: String, selected: Bool) {
        self.text = "    " + text.capitalized
        self.selected = selected
    }
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 0) {
            if self.selected {
                Text(self.text)
                    .foregroundColor(Color.customDarkText)
                    .frame(width: textWitdh, height: 44, alignment: .leading)
                    .background(RoundedCorners(upperLeft: 10, upperRight: 0, lowerLeft: 10, lowerRigth: 0))
                    .foregroundColor(Color.customGrayButton)
                Image(systemName: "checkmark")
                    .font(Font.system(size: 18))
                    .foregroundColor(Color.customDarkText)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .frame(width: 44, height: 44, alignment: .center)
                    .background(RoundedCorners(upperLeft: 0, upperRight: 10, lowerLeft: 0, lowerRigth: 10))
                    .foregroundColor(Color.customGrayButton)
            } else {
                Text(self.text)
                    .foregroundColor(Color.customDarkText)
                    .frame(width: textWitdh + 44, height: 44, alignment: .leading)
                    .background(RoundedCorners(upperLeft: 10, upperRight: 10, lowerLeft: 10, lowerRigth: 10))
                    .foregroundColor(Color.customGrayButton)
            }
        }
        .padding(EdgeInsets(top: 12, leading: 24, bottom: 0, trailing: 24))
    }
}

struct CategoryElement_Preview: PreviewProvider {
    
    static var previews: some View {
        Group {
            CategoryElement(text: "Categoria 1", selected: false)
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("NOT Selected category")
            
            CategoryElement(text: "Categoria 1", selected: true)
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Selected category")
        }
    }
}
