//
//  AddDemoData.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 28/02/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct AddDemoData: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var showingAlert: Bool = false
    private var sectionTitle: String = ""
    private var sectionDescription: String = ""
    private var sectionAlertTitle: String = ""
    private var sectionAlertMessage: String = ""
    private var sectionAlertPrimaryButton: String = ""
    private var sectionAlertSecondaryButton: String = ""
    
    // MARK: - Methods
    
    init() {
        self.localizeText()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        self.sectionTitle = NSLocalizedString("settingsAddDemoTitle", comment: "")
        self.sectionDescription = NSLocalizedString("settingsAddDemoDescription", comment: "")
        self.sectionAlertTitle = NSLocalizedString("settingsAddDemoAlertTitle", comment: "")
        self.sectionAlertMessage = NSLocalizedString("settingsAddDemoAlertMessage", comment: "")
        self.sectionAlertPrimaryButton = NSLocalizedString("settingsAddDemoAlertPrimaryButton", comment: "")
        self.sectionAlertSecondaryButton = NSLocalizedString("no", comment: "")
    }
    
    ///
    /// Adds demo Subscriptions and Payments.
    ///
    private func addDemoData() {
        // Adds demo Subscriptions and Payments to Core Data.
        self.subscriptionsViewModel.addDemoData()
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle(title: self.sectionTitle)
            SectionDescription(texts: [self.sectionDescription])
            Button(action: {
                self.showingAlert = true
            }) {
                BigButton(style: .add, title: "Add")
            }.alert(isPresented: self.$showingAlert, content: {
                Alert(title: Text(self.sectionAlertTitle),
                      message: Text(self.sectionAlertMessage),
                      primaryButton: Alert.Button.default(Text(self.sectionAlertPrimaryButton),
                      action: {
                        self.addDemoData()
                      }),
                      secondaryButton: Alert.Button.cancel(Text(self.sectionAlertSecondaryButton)))
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

struct AddDemoData_Previews: PreviewProvider {
    static var previews: some View {
        AddDemoData()
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
