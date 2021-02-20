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
    private var navBarTitle: String = ""
    private var descriptionText: String = ""
    private var sectionDeleteTitle: String = ""
    private var sectionDeleteDescription1: String = ""
    private var sectionDeleteDescription2: String = ""
    private var sectionDeleteDescription3: String = ""
    private var sectionDeleteButtonTitle: String = ""
    private var sectionDeleteAlertTitle: String = ""
    private var sectionDeleteAlertMessage: String = ""
    private var sectionDeleteAlertPrimaryButton: String = ""
    private var sectionDeleteAlertSecondaryButton: String = ""
    
    // MARK: - Methods
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        self.localizeText()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get strings from localizable.
        self.navBarTitle = NSLocalizedString("Settings", comment: "")
        self.descriptionText = NSLocalizedString("settingsView", comment: "")
        self.sectionDeleteTitle = NSLocalizedString("sectionDeleteTitle", comment: "")
        self.sectionDeleteDescription1 = NSLocalizedString("sectionDeleteDescription1", comment: "")
        self.sectionDeleteDescription2 = NSLocalizedString("sectionDeleteDescription2", comment: "")
        self.sectionDeleteDescription3 = NSLocalizedString("sectionDeleteDescription3", comment: "")
        self.sectionDeleteButtonTitle = NSLocalizedString("sectionDeleteButtonTitle", comment: "")
        self.sectionDeleteAlertTitle = NSLocalizedString("sctionDeleteAlertTitle", comment: "")
        self.sectionDeleteAlertMessage = NSLocalizedString("sectionDeleteAlertMessage", comment: "")
        self.sectionDeleteAlertPrimaryButton = NSLocalizedString("sectionDeleteAlertPrimaryButton", comment: "")
        self.sectionDeleteAlertSecondaryButton = NSLocalizedString("no", comment: "")
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
                SectionTitle(title: self.sectionDeleteTitle)
                SectionDescription(texts: [self.sectionDeleteDescription1, self.sectionDeleteDescription2, self.sectionDeleteDescription3])
                Button(action: {
                    self.showingAlert = true
                }) {
                    BigButton(style: .delete, title: self.sectionDeleteButtonTitle)
                }.alert(isPresented: self.$showingAlert, content: {
                    Alert(title: Text(self.sectionDeleteAlertTitle),
                          message: Text(self.sectionDeleteAlertMessage),
                          primaryButton: Alert.Button.destructive(Text(self.sectionDeleteAlertPrimaryButton),
                          action: {
                            self.deleteAllData()
                          }),
                          secondaryButton: Alert.Button.cancel(Text(self.sectionDeleteAlertSecondaryButton)))
                })
                Spacer()
                .navigationBarTitle(Text(self.navBarTitle), displayMode: .inline)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
    }
}
