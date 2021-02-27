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
    
    var texts: [String]
    
    // MARK: - Methods
    
    init(texts: [String]) {
        self.texts = texts
    }
    
    // MARK: - View
    
    var body: some View {
        ForEach(self.texts, id:\.self) { text in
            Text(text)
                .font(Font.system(size: 18))
                .fontWeight(Font.Weight.light)
                .foregroundColor(Color.customDarkText)
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 18))
        }
    }
}

struct SectionDescription_Previews: PreviewProvider {
    static var previews: some View {
        SectionDescription(texts: ["First text", "Second text", "Third text"])
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
