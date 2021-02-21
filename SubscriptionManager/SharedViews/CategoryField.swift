//
//  CategoryField.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 31/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct CategoryField: View {
    
    // MARK: - Properties
    
    @Binding var selectedCategory: SubscriptionsViewModel.subscriptionCategory
    private var title: String
    private var buttonWitdh: CGFloat {
        return (UIScreen.main.bounds.size.width - 44) - 14 - 24
    }
    private var placeholderText: String = ""
    
    // MARK: - Methods
    
    init(title: String, value: Binding<SubscriptionsViewModel.subscriptionCategory>) {
        self.title = title
        self._selectedCategory = value
        self.localizeText()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get strings from localizable.
        self.placeholderText = "    " + NSLocalizedString("SelectACategory", comment: "") + " ..."
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            FieldTitle(title: self.title)
            NavigationLink(destination: CategoriesView(value: self.$selectedCategory)) {
                HStack(spacing: 0) {
                    if self.selectedCategory.rawValue == "none" {
                        Text(self.placeholderText)
                            .foregroundColor(Color.customDarkText)
                            .frame(width: buttonWitdh, height: 44, alignment: .leading)
                            .background(RoundedCorners(upperLeft: 10, upperRight: 0, lowerLeft: 10, lowerRigth: 0))
                            .foregroundColor(Color.customGrayButton)
                    } else {
                        Text("    \(self.selectedCategory.rawValue.capitalized)")
                            .foregroundColor(Color.customDarkText)
                            .frame(width: buttonWitdh, height: 44, alignment: .leading)
                            .background(RoundedCorners(upperLeft: 10, upperRight: 0, lowerLeft: 10, lowerRigth: 0))
                            .foregroundColor(Color.customGrayButton)
                    }
                    Image(systemName: "chevron.right")
                        .font(Font.system(size: 22))
                        .foregroundColor(Color.customDarkText)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .frame(width: 44, height: 44, alignment: .center)
                        .background(RoundedCorners(upperLeft: 0, upperRight: 10, lowerLeft: 0, lowerRigth: 10))
                        .foregroundColor(Color.customGrayButton)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }
}

struct CategoryField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryField(title: "Category", value: .constant(SubscriptionsViewModel.subscriptionCategory.none))
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Category Not Selected")
            
            CategoryField(title: "Category", value: .constant(SubscriptionsViewModel.subscriptionCategory.video))
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Category Selected")
        }
    }
}
