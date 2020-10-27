//
//  EditableField.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 27/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct EditableField: View {
    
    //MARK: - Properties
    
    @Binding var textfieldValue: String
    var title: String
    var keyboardType: UIKeyboardType
    
    //MARK: - Methods
    
    init(title: String, value: Binding<String>, keyboardType: UIKeyboardType) {
        self.title = title
        self._textfieldValue = value
        self.keyboardType = keyboardType
    }
    
    //MARK: - View
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.title)
                .foregroundColor(Color.customDarkText)
                .font(Font.system(size: 14))
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 0))
            TextField("Enter the \(self.title.lowercased()) ...", text: $textfieldValue)
                .font(.system(size: 16, weight: .bold, design: .default))
                .foregroundColor(Color.black)
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
                .keyboardType(self.keyboardType)
        }
        .background(Color.customLightGrey)
        .cornerRadius(5.0)
        .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
        .onTapGesture { self.hideKeyboard() }
    }
}

struct EditableField_Previews: PreviewProvider {
    static var previews: some View {
        EditableField(title: "Title", value: .constant("0"), keyboardType: UIKeyboardType.alphabet)
    }
}
