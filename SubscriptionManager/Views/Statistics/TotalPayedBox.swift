//
//  TotalPayedBox.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 24/02/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct TotalPayedBox: View {
    
    // MARK: - Properties
    
    private var boxWidth: CGFloat {
        return (((UIScreen.main.bounds.size.width / 3) * 2) - 8 - 8 - 12 - 12 - 8)
    }
    
    private var boxHeight: CGFloat {
        return ((UIScreen.main.bounds.size.width / 3) - 8 - 8 - 12 - 12)
    }
    var value: String
    
    // MARK: - Methods
    
    init(value: String) {
        self.value = value
    }
    
    // MARK: - View
    
    var body: some View {
        Text("Total payed : \(self.value)")
            .font(Font.system(size: 14, weight: Font.Weight.light, design: Font.Design.monospaced))
            .foregroundColor(Color.white)
            .frame(width: self.boxWidth, height: self.boxHeight, alignment: .center)
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .background(Color.customRowMango)
            .cornerRadius(6)
    }
}

struct TotalPayedBox_Previews: PreviewProvider {
    static var previews: some View {
        TotalPayedBox(value: "200 €")
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
