//
//  ContentView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 24/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Properties
    @State private var showingNewSubscriptionForm: Bool = false
    var subscriptions: [Subscription] = []
    
    //MARK: - Methods
    ///
    /// Loads demo data to 'subscribtions'.
    ///
    mutating func loadsDemoSubscriptions() {
        let subs1: Subscription = Subscription(name: "AppleTV", company: "Apple", type: SubscriptionType.pay, period: "One Year", dayStart: "2020/01/01", dayEnd: "2020/12/31", price: 15, accountEmail: "email@gmail.com")
        let subs2: Subscription = Subscription(name: "Spotify Premium", company: "Spotify", type: SubscriptionType.trial, period: "2 weeks", dayStart: "2020/01/01", dayEnd: "2020/01/14", price: 0, accountEmail: "email@gmail.com")
        let subs3: Subscription = Subscription(name: "Amazon Prime", company: "Amazon", type: SubscriptionType.pay, period: "1 month", dayStart: "2020/01/01", dayEnd: "2020/01/31", price: 34, accountEmail: "email2@gmail.com")
        
        subscriptions.append(subs1)
        subscriptions.append(subs2)
        subscriptions.append(subs3)
    }
    
    ///
    /// Initializer
    ///
    init() {
        self.loadsDemoSubscriptions()
    }
    
    var body: some View {
        // NavigationView + List
        NavigationView {
            List(self.subscriptions) { subscription in
                SubscriptionRow(subscription: subscription)
                }
            .navigationBarTitle("Subscriptions")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingNewSubscriptionForm.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                }.sheet(isPresented: $showingNewSubscriptionForm) {
                    NewSubscriptionForm()
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
