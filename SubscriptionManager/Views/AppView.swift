//
//  AppView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 02/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    //MARK: - Properties
    var subscriptionsViewModel = SubscriptionsViewModel()
    
    //MARK: - View
    var body: some View {
        TabView {
            SubscriptionsView().environmentObject(self.subscriptionsViewModel)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Subscriptions")
            }
            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.pie")
                    Text("Statistics")
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
