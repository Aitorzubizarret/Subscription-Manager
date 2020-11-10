//
//  View.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 10/11/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

extension View {
    
    ///
    /// Hides the keyboard.
    ///
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
