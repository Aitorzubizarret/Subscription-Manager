//
//  SectionTitle.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 12/11/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SectionTitle: View {
    
    // MARK: - Properties
    
    var title: String
    
    // MARK: - Methods
    
    init(title: String) {
        self.title = title.uppercased()
    }
    
    // MARK: - View
    
    var body: some View {
        Text(self.title)
            .font(Font.system(size: 18))
            .fontWeight(Font.Weight.bold)
            .foregroundColor(Color.black)
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 6, trailing: 12))
    }
}

struct SectionTitle_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitle(title: "Section Title")
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
    }
}
