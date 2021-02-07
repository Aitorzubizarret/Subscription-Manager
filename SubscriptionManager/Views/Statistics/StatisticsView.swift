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
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    // Statistics.
                    SectionTitle(title: "Statistics")
                    VStack {
                        HStack(alignment: .center, spacing: 12) {
                            SmallSimpleBox(value: self.subscriptionsViewModel.subscriptions.count, descriptionText: self.subscriptionsViewModel.subscriptions.count > 1 ? "Subscriptions" : "Subscription")
                            Spacer()
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                    // Next Payments.
                    if self.subscriptionsViewModel.payments.count > 0 {
                        SectionTitle(title: "Next Payments")
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(self.subscriptionsViewModel.payments, id:\Payment.id) { payment in
                                PendingPaymentRow(payment: payment)
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static let subscriptionsViewModel = SubscriptionsViewModel()
    
    static var previews: some View {
        StatisticsView().environmentObject(subscriptionsViewModel)
    }
}
