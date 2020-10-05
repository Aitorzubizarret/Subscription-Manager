//
//  SubscriptionsViewModel.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 02/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

class SubscriptionsViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var subscriptions: [Subscription] = []
    
    //MARK: - Methods
    ///
    /// Initializer
    ///
    init() {
        self.loadsDemoSubscriptions()
    }
    
    ///
    /// Loads demo data to 'subscribtions'.
    ///
    private func loadsDemoSubscriptions() {
        let subs1: Subscription = Subscription(name: "AppleTV", company: "Apple", type: SubscriptionType.pay, period: "One Year", dayStart: "2020/01/01", dayEnd: "2020/12/31", price: 15, accountEmail: "email@gmail.com")
        let subs2: Subscription = Subscription(name: "Spotify Premium", company: "Spotify", type: SubscriptionType.trial, period: "2 weeks", dayStart: "2020/01/01", dayEnd: "2020/01/14", price: 0, accountEmail: "email@gmail.com")
        let subs3: Subscription = Subscription(name: "Amazon Prime", company: "Amazon", type: SubscriptionType.pay, period: "1 month", dayStart: "2020/01/01", dayEnd: "2020/01/31", price: 34, accountEmail: "email2@gmail.com")
        
        self.subscriptions.append(subs1)
        self.subscriptions.append(subs2)
        self.subscriptions.append(subs3)
    }
    
    ///
    /// Creates a new subscription and adds it to subscriptions array.
    ///
    public func addNewSubscription(name: String, company: String, type: SubscriptionType, period: String, dayStart: String, dayEnd: String, price: Float, accountEmail: String) {
        let newSubscription: Subscription = Subscription(name: name, company: company, type: type, period: period, dayStart: dayStart, dayEnd: dayEnd, price: price, accountEmail: accountEmail)
        
        self.subscriptions.append(newSubscription)
    }
}
