//
//  SubscriptionLogoTitleField.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 19/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionLogoTitleField: View {
    
    // MARK: - Properties
    
    var title: String
    var category: String
    var backgroundColor: Color
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0) {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 45, height: 45, alignment: .center)
                    .scaledToFit()
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .foregroundColor(Color.white)
                Text(title)
                    .font(Font.system(size: 30))
                    .fontWeight(Font.Weight.bold)
                    .foregroundColor(Color.white)
                Text(category.capitalized)
                    .font(Font.system(size: 18))
                    .fontWeight(Font.Weight.light)
                    .foregroundColor(Color.white)
            }
            Spacer()
        }
        .background(backgroundColor)
    }
}

struct SubscriptionLogoTitleField_Previews: PreviewProvider {
    
    static var previews: some View {
        SubscriptionLogoTitleField(title: "HBO", category: "Video", backgroundColor: Color.red)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
