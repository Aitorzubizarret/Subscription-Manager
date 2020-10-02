//
//  SubscriptionRow.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 29/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionRow: View {
    var subscription: Subscription
    
    var body: some View {
        NavigationLink(destination: SubscriptionDetail(subscription: subscription)) {
            VStack(alignment: HorizontalAlignment.leading, spacing: 10) {
                Text(subscription.name + " subscription")
                Text(subscription.company)
            }
        }
    }
}

struct SubscriptionRow_Previews: PreviewProvider {
    static let subscription: Subscription = Subscription(name: "AppleTV", company: "Apple", type: SubscriptionType.trial, period: "Month", dayStart: "2020/09/01", dayEnd: "2020/09/30", price: 0, accountEmail: "email@gmail.com")
    
    static var previews: some View {
        SubscriptionRow(subscription: subscription)
    }
}
