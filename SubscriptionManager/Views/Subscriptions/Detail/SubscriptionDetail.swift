//
//  SubscriptionDetail.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 30/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionDetail: View {
    
    //MARK: - Properties
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var showingAlert: Bool = false
    var subscription: Subscription
    
    //MARK: - Methods
    ///
    /// Deletes the subscription.
    ///
    private func deleteSubscription() {
        self.subscriptionsViewModel.deleteSubscription(subscription: self.subscription)
    }
    
    //MARK: - View
    var body: some View {
        return VStack {
            Image(systemName: "info.circle")
                .resizable()
                .frame(width: 75, height: 75, alignment: .center)
                .scaledToFit()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                .foregroundColor(Color.red)
            HStack {
                Text("Name :")
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                Spacer()
                Text(subscription.name)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 20))
            }
            HStack {
                Text("Price :")
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
                Spacer()
                Text(String(format: "%.2f €", subscription.price))
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 20))
            }
            Spacer()
            Button(action: {
                self.showingAlert = true
            }) {
                HStack {
                    Spacer()
                    Image(systemName: "trash")
                        .padding(EdgeInsets(top: -3, leading: 0, bottom: 0, trailing: 0))
                    Text("Delete Subscription")
                        .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(Color.white)
                .font(.headline)
                .cornerRadius(6)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
            }.alert(isPresented: self.$showingAlert, content: {
                Alert(title: Text("Delete Subscription"), message: Text("This action can’t be undone. Are you sure?") ,primaryButton: Alert.Button.destructive(Text("Delete"), action: {
                    self.deleteSubscription()
                }), secondaryButton: Alert.Button.cancel(Text("No")))
            })
        }
    }
}

struct SubscriptionDetail_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let subscription: Subscription = Subscription(context: context)
        subscription.name = "Test"
        subscription.price = 9
        
        return SubscriptionDetail(subscription: subscription)
    }
}
