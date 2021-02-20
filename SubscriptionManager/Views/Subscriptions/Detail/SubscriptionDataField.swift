//
//  SubscriptionDataField.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 18/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionDataField: View {
    
    // MARK: - Properties
    
    let title: String
    let value: String
    let backgroundColor: Color
    var composedTitle: String
    
    // MARK: - Methods
    
    init(title: String, value: String, backgroundColor: Color) {
        self.title = title
        self.value = value
        self.backgroundColor = backgroundColor
        
        self.composedTitle = "\(title.uppercased()) :"
    }
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Text(self.composedTitle)
                .fontWeight(Font.Weight.medium)
                .font(Font.system(size: 14))
                .foregroundColor(Color.white)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            Text(value)
                .fontWeight(Font.Weight.bold)
                .font(Font.system(size: 16))
                .foregroundColor(Color.white)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 0))
        .background(backgroundColor)
    }
}

struct SubscriptionDataField_Previews: PreviewProvider {
    
    static var previews: some View {
        SubscriptionDataField(title: "Price", value: "5 €", backgroundColor: Color.red)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
