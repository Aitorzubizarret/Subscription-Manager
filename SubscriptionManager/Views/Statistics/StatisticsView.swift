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
    private var navBarTitle: String = ""
    private var subscriptionsText: String = ""
    private var subscriptionText: String = ""
    private var nextPaymentsText: String = ""
    private var totalPayed: String {
        var total: Float = 0.0
        subscriptionsViewModel.subscriptions.forEach { (subscription) in
            total += subscription.payed
        }
        return "\(total) €"
    }
    
    // MARK: - Methods
    
    init() {
        self.localizeText()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get strings from localizable.
        self.navBarTitle = NSLocalizedString("Statistics", comment: "")
        self.subscriptionsText = NSLocalizedString("Subscriptions", comment: "")
        self.subscriptionText = NSLocalizedString("Subscription", comment: "")
        self.nextPaymentsText = NSLocalizedString("nextPayments", comment: "")
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    // Statistics.
                    SectionTitle(title: self.navBarTitle)
                    VStack {
                        HStack(alignment: .center, spacing: 12) {
                            // FIXME: There is a problem with Basque language.
                            SmallSimpleBox(value: self.subscriptionsViewModel.subscriptions.count, descriptionText: self.subscriptionsViewModel.subscriptions.count > 1 ? self.subscriptionsText : self.subscriptionText)
                            TotalPayedBox(value: self.totalPayed)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                    // Next Payments.
                    if self.subscriptionsViewModel.payments.count > 0 {
                        SectionTitle(title: self.nextPaymentsText)
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(self.subscriptionsViewModel.getPaymentsDueToThisMonth(), id:\Payment.id) { payment in
                                PendingPaymentRow(payment: payment)
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
            }
            .navigationBarHidden(true)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static let subscriptionsViewModel = SubscriptionsViewModel()
    
    static var previews: some View {
        StatisticsView().environmentObject(subscriptionsViewModel)
    }
}
