//
//  FieldTitle.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 27/12/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct FieldTitle: View {
    
    // MARK: - Properties
    
    var title: String
    
    // MARK: - Methods
    
    init(title: String) {
        self.title = title
    }
    
    // MARK: - View
    
    var body: some View {
        Text(self.title.uppercased())
            .font(Font.system(size: 14))
            .fontWeight(Font.Weight.medium)
            .foregroundColor(Color.customDarkText)
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 0))
    }
}

struct FieldTitle_Previews: PreviewProvider {
    static var previews: some View {
        FieldTitle(title: "Field Title")
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
