//
//  AppView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 02/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    // MARK: - Properties
    
    var subscriptionsViewModel = SubscriptionsViewModel()
    private var subscriptionTabTitle: String = ""
    private var statisticsTabTitle: String = ""
    
    // MARK: - Methods
    
    init() {
        self.localizeText()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get the TabBar title strings from localizable.
        self.subscriptionTabTitle = NSLocalizedString("Subscriptions", comment: "")
        self.statisticsTabTitle = NSLocalizedString("Statistics", comment: "")
    }
    
    // MARK: - View
    
    var body: some View {
        TabView {
            SubscriptionsView().environmentObject(self.subscriptionsViewModel)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text(self.subscriptionTabTitle)
            }
            StatisticsView().environmentObject(self.subscriptionsViewModel)
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text(self.statisticsTabTitle)
            }
        }
        .accentColor(.black)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
