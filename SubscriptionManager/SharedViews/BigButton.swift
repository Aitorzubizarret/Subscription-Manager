//
//  BigButton.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 31/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct BigButton: View {
    
    // MARK: - Properties
    
    enum Style {
        case edit
        case delete
        case add
    }
    private var imageName: String
    private var title: String
    private var backColor: Color
    private var frontColor: Color
    private var strokeColor: Color
    
    // MARK: - Methods
    
    init(style: Style, title: String) {
        switch style {
        case Style.edit:
            self.imageName = "pencil"
            self.title = title
            self.backColor = Color.customBlueButton
            self.frontColor = Color.customBlueText
            self.strokeColor = Color.customBlueButton
        case Style.delete:
            self.imageName = "trash"
            self.title = title
            self.backColor = Color.customRedButton
            self.frontColor = Color.customRedText
            self.strokeColor = Color.customRedButton
        case Style.add:
            self.imageName = "plus"
            self.title = title
            self.backColor = Color.customGreenButton
            self.frontColor = Color.customGreenText
            self.strokeColor = Color.customGreenButton
        }
    }
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: self.imageName)
                .padding(EdgeInsets(top: -3, leading: 0, bottom: 0, trailing: 0))
            Text(self.title)
                .padding(EdgeInsets(top: 3, leading: 10, bottom: 0, trailing: 0))
            Spacer()
        }
        .padding()
        .background(self.backColor)
        .foregroundColor(self.frontColor)
        .font(.headline)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(self.strokeColor, lineWidth: 2)
        )
        .padding(EdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10))
    }
}

struct BigButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BigButton(style: BigButton.Style.edit, title: "Edit Big Button")
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Edit Style")
            
            BigButton(style: BigButton.Style.delete, title: "Delete Big Button")
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Delete Style")
            
            BigButton(style: BigButton.Style.add, title: "Add Big Button")
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Add Style")
        }
    }
}
