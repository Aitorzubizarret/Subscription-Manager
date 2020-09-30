//
//  ContentView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 24/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // Local Data
        let subs1: Subscription = Subscription(name: "AppleTV", company: "Apple", type: SubscriptionType.pago, period: "One Year", dayStart: "2020/01/01", dayEnd: "2020/12/31", price: 15, accountEmail: "email@gmail.com")
        let subs2: Subscription = Subscription(name: "Spotify Premium", company: "Spotify", type: SubscriptionType.prueba, period: "2 weeks", dayStart: "2020/01/01", dayEnd: "2020/01/14", price: 0, accountEmail: "email@gmail.com")
        let subs3: Subscription = Subscription(name: "Amazon Prime", company: "Amazon", type: SubscriptionType.pago, period: "1 month", dayStart: "2020/01/01", dayEnd: "2020/01/31", price: 34, accountEmail: "email2@gmail.com")
        
        let subscriptions: [Subscription] = [subs1, subs2, subs3]
        
        // NavigationView + List
        return NavigationView {
            List(subscriptions) { subscription in
                SubscriptionRow(subscription: subscription)
            }.navigationBarTitle("Subscriptions")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
