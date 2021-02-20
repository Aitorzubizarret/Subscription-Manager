//
//  EmptySubscriptionList.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 10/02/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct EmptySubscriptionList: View {
    
    // MARK: - Properties
    
    var message_title: String = ""
    var message_description: String = ""
    
    // MARK: - Methods
    
    init() {
        self.localizeText()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get strings from localizable.
        self.message_title = NSLocalizedString("emptySubscriptionListTitle", comment: "").uppercased()
        self.message_description = NSLocalizedString("emptySubscriptionListMessage", comment: "")
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(systemName: "exclamationmark.bubble.fill")
                .font(Font.system(size: 40, weight: Font.Weight.light, design: Font.Design.default))
                .foregroundColor(Color.customRowMango)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            Text(self.message_title)
                .font(Font.system(size: 22))
                .fontWeight(Font.Weight.bold)
                .foregroundColor(Color.customRowMango)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            Text(self.message_description)
                .font(Font.system(size: 18))
                .fontWeight(Font.Weight.light)
                .foregroundColor(Color.gray)
                .padding(EdgeInsets(top: 8, leading: 20, bottom: 0, trailing: 20))
        }
    }
}

struct EmptySubscriptionList_Previews: PreviewProvider {
    static var previews: some View {
        EmptySubscriptionList()
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
