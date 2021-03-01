//
//  DeleteAllDataSection.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 27/02/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct DeleteAllDataSection: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var showingAlert: Bool = false
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
    
    init() {
        self.localizeText()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        self.sectionDeleteTitle = NSLocalizedString("settingsDeleteAllTitle", comment: "")
        self.sectionDeleteDescription1 = NSLocalizedString("settingsDeleteAllDescription1", comment: "")
        self.sectionDeleteDescription2 = NSLocalizedString("settingsDeleteAllDescription2", comment: "")
        self.sectionDeleteDescription3 = NSLocalizedString("settingsDeleteAllDescription3", comment: "")
        self.sectionDeleteButtonTitle = NSLocalizedString("settingsDeleteAllButtonText", comment: "")
        self.sectionDeleteAlertTitle = NSLocalizedString("settingsDeleteAllAlertTitle", comment: "")
        self.sectionDeleteAlertMessage = NSLocalizedString("settingsDeleteAllAlertMessage", comment: "")
        self.sectionDeleteAlertPrimaryButton = NSLocalizedString("settingsDeleteAllPrimaryButton", comment: "")
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
        VStack(alignment: .leading, spacing: 12) {
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
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        .background(Color.white)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .border(Color.customBgLightGray, width: 4)
        .cornerRadius(6)
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}

struct DeleteAllDataSection_Previews: PreviewProvider {
    static let subscriptionsViewModel = SubscriptionsViewModel()
    
    static var previews: some View {
        DeleteAllDataSection().environmentObject(subscriptionsViewModel)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
