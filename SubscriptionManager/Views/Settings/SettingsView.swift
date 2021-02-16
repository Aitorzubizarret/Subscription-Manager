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
    @State private var showingAlert: Bool = false
    private var settingsText: String = ""
    private var descriptionText: String = ""
    
    // MARK: - Methods
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.localizeText()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get the NavBar title string from localizable.
        self.settingsText = NSLocalizedString("Settings", comment: "")
        self.descriptionText = NSLocalizedString("settingsView", comment: "")
    }
    
    ///
    /// Delete all data.
    ///
    private func deleteAllData() {
        // Deletes everything from Core Data.
        self.subscriptionsViewModel.deleteAllData()
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 12) {
                // Delete all data from the App.
                SectionTitle(title: "Delete everything")
                Text("This button let you delete all the data created by this App and stored locally on your phone.")
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                Text("- All Subscriptions")
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                Text("- All Payments data")
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                Button(action: {
                    self.showingAlert = true
                }) {
                    BigButton(style: .delete, title: "Delete All Subscriptions?")
                }.alert(isPresented: self.$showingAlert, content: {
                    Alert(title: Text("Delete All Subscriptions"),
                          message: Text("This action can’t be undone. Are you sure?"),
                          primaryButton: Alert.Button.destructive(Text("Delete"),
                          action: {
                            self.deleteAllData()
                          }),
                          secondaryButton: Alert.Button.cancel(Text("No")))
                })
                .navigationBarTitle("Settings", displayMode: .inline)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
    }
}
