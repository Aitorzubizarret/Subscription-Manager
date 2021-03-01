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
    
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @Binding var isPresented: Bool
    private var navBarTitle: String = ""
    
    // MARK: - Methods
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.localizeText()
        
        UITableView.appearance().backgroundColor = .clear
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get strings from localizable.
        self.navBarTitle = NSLocalizedString("settingsNavBarTitle", comment: "")
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Delete all data from the App.
                    DeleteAllDataSection().environmentObject(self.subscriptionsViewModel)
                    AddDemoData().environmentObject(self.subscriptionsViewModel)
                    .navigationBarTitle(Text(self.navBarTitle), displayMode: .inline)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static let subscriptionsViewModel = SubscriptionsViewModel()
    
    static var previews: some View {
        SettingsView(isPresented: .constant(true)).environmentObject(subscriptionsViewModel)
    }
}
