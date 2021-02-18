//
//  SectionDescription.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 18/02/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SectionDescription: View {
    
    // MARK: - Properties
    
    var text: String
    
    // MARK: - Methods
    
    init(text: String) {
        self.text = text
    }
    
    // MARK: - View
    
    var body: some View {
        Text(self.text)
            .font(Font.system(size: 18))
            .fontWeight(Font.Weight.light)
            .foregroundColor(Color.customDarkText)
            .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 18))
    }
}

struct SectionDescription_Previews: PreviewProvider {
    static var previews: some View {
        SectionDescription(text: "A long text with loads of words just to say, Hi Planet!")
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
