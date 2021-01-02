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
    
    private var title: String
    private var buttonWitdh: CGFloat {
        return (UIScreen.main.bounds.size.width - 44) - 14 - 24
    }
    
    // MARK: - Methods
    
    init(title: String) {
        self.title = title
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            FieldTitle(title: self.title)
            NavigationLink(destination: CategoriesView()) {
                HStack(spacing: 0) {
                    Text("    Select Category ...")
                        .foregroundColor(Color.customDarkText)
                        .frame(width: buttonWitdh, height: 44, alignment: .leading)
                        .background(RoundedCorners(upperLeft: 10, upperRight: 0, lowerLeft: 10, lowerRigth: 0))
                        .foregroundColor(Color.customGrayButton)
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
        CategoryField(title: "Category")
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
