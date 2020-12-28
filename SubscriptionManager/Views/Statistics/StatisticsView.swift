//
//  StatisticsView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 02/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle(title: "Statistics")
            HStack(alignment: .center, spacing: 12) {
                SmallSimpleBox(value: self.subscriptionsViewModel.subscriptions.count, descriptionText: self.subscriptionsViewModel.subscriptions.count > 1 ? "Subscriptions" : "Subscription")
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
            Spacer()
        }
    .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static let subscriptionsViewModel = SubscriptionsViewModel()
    
    static var previews: some View {
        StatisticsView().environmentObject(subscriptionsViewModel)
    }
}
