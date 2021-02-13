//
//  ConfigurationView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 13/02/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct ConfigurationView: View {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    
    // MARK: - View
    
    var body: some View {
        Text("Configuration View")
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView(isPresented: .constant(false))
    }
}
