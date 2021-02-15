//
//  ContentView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 24/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var showingNewSubscriptionForm: Bool = false
    @State private var showingConfigPanel: Bool = false
    private var navBarTitle: String = ""
    
    // MARK: - Methods
    
    init() {
        self.localizeText()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get the NavBar title string from localizable.
        self.navBarTitle = NSLocalizedString("Subscriptions", comment: "")
    }
    
    // MARK: - View
    
    var body: some View {

        // NavigationView + Scrollview
        NavigationView {
            ScrollView {
                if self.subscriptionsViewModel.subscriptions.count == 0 {
                    EmptySubscriptionList()
                    .padding(EdgeInsets(top: 120, leading: 0, bottom: 0, trailing: 0))
                } else {
                    ForEach(self.subscriptionsViewModel.subscriptions, id:\Subscription.id) { subscription in
                        SubscriptionRow(subscription: subscription).environmentObject(self.subscriptionsViewModel)
                    }
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
                }
            }
            .navigationBarTitle(self.navBarTitle)
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.showingConfigPanel.toggle()
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(Font.system(size: 20, weight: Font.Weight.bold, design: Font.Design.default))
                    }.sheet(isPresented: $showingConfigPanel) {
                        SettingsView(isPresented: self.$showingConfigPanel).environmentObject(self.subscriptionsViewModel)
                    }
                ,
                trailing:
                    Button(action: {
                        self.showingNewSubscriptionForm.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(Font.system(size: 20, weight: Font.Weight.bold, design: Font.Design.default))
                    }.sheet(isPresented: $showingNewSubscriptionForm) {
                        NewSubscriptionForm(isPresented: self.$showingNewSubscriptionForm)
                            .environmentObject(self.subscriptionsViewModel)
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let subscriptionsViewModel = SubscriptionsViewModel()
    
    static var previews: some View {
        SubscriptionsView().environmentObject(subscriptionsViewModel)
    }
}
