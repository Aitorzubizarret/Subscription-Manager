//
//  SubscriptionLogoTitleField.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 19/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionLogoTitleField: View {
    
    //MARK: - Properties
    
    var title: String
    
    //MARK: - View
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.customLightGrey)
                    .frame(width: 60, height: 60)
                    .overlay(Rectangle().stroke(Color.customDarkGrey, lineWidth: 1))
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 20))
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 45, height: 45, alignment: .center)
                    .scaledToFit()
                    .padding(EdgeInsets(top: 20, leading: 46, bottom: 20, trailing: 25))
                    .foregroundColor(Color.black)
            }
            Text(title)
                .fontWeight(Font.Weight.bold)
                .frame(alignment: .leading)
            Spacer()
        }
    }
}

struct SubscriptionLogoTitleField_Previews: PreviewProvider {
    
    static var previews: some View {
        SubscriptionLogoTitleField(title: "HBO")
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
