//
//  ContentView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 24/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionsView: View {
    
    //MARK: - Properties
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var showingNewSubscriptionForm: Bool = false
    
    //MARK: - View
    var body: some View {

        // NavigationView + Scrollview
        NavigationView {
            ScrollView {
                ForEach(self.subscriptionsViewModel.subscriptions, id:\.self) { subscription in
                    SubscriptionRow(subscription: subscription).environmentObject(self.subscriptionsViewModel)
                }
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            }
            .navigationBarTitle("Subscriptions")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingNewSubscriptionForm.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                }.sheet(isPresented: $showingNewSubscriptionForm) {
                    NewSubscriptionForm(isPresented: self.$showingNewSubscriptionForm)
                        .environmentObject(self.subscriptionsViewModel)
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let subscriptionsViewModel = SubscriptionsViewModel()
    
    static var previews: some View {
        SubscriptionsView().environmentObject(subscriptionsViewModel)
    }
}
