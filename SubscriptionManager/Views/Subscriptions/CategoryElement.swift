//
//  CategoryElement.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 02/01/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct CategoryElement: View {
    
    // MARK: - Properties
    
    var text: String
    
    // MARK: - Methods
    
    init(text: String) {
        self.text = text
    }
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 0) {
            Text(self.text)
            Spacer()
        }
        .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
    }
}

struct CategoryElement_Preview: PreviewProvider {
    
    static var previews: some View {
        CategoryElement(text: "Categoria 1")
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
