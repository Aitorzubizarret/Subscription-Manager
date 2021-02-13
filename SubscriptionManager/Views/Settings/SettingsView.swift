//
//  ConfigurationView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 13/02/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    
    // MARK: - View
    
    var body: some View {
        Text("Settings View")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(false))
    }
}
