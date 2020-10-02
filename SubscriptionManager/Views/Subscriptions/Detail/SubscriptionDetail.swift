//
//  SubscriptionDetail.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 30/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionDetail: View {
    var subscription: Subscription
    
    var body: some View {
        return VStack {
            Text(subscription.name)
            Text(subscription.company)
            Text(subscription.period)
            Text(subscription.dayStart)
            Text(subscription.dayEnd)
            Text("\(subscription.price)")
        }
    }
}

struct SubscriptionDetail_Previews: PreviewProvider {
    static let subscription: Subscription = Subscription(name: "AppleTV", company: "Apple", type: SubscriptionType.trial, period: "Month", dayStart: "2020/09/01", dayEnd: "2020/09/30", price: 0, accountEmail: "email@gmail.com")
    
    static var previews: some View {
        SubscriptionDetail(subscription: subscription)
    }
}
