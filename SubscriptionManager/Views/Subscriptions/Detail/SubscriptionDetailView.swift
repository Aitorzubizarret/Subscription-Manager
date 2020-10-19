//
//  SubscriptionDetail.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 30/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

private var dateFormatter: DateFormatter = {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    return dateFormatter
}()

struct SubscriptionDetailView: View {
    
    //MARK: - Properties
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    @State private var showingAlert: Bool = false
    @State private var deleteInProcess: Bool = false
    var subscription: Subscription
    
    //MARK: - Methods
    ///
    /// Deletes the subscription.
    ///
    private func deleteSubscription() {
        self.subscriptionsViewModel.deleteSubscription(subscription: self.subscription)
        self.deleteInProcess = true
    }
    
    //MARK: - Views
    var body: some View {
        ScrollView {
            SubscriptionLogoTitleField(title: subscription.name)
            CustomDivider()
            VStack {
                SubscriptionDataField(title: "Price", value: String(format: "%.2f €", subscription.price))
                Divider()
                SubscriptionDataField(title: "Cycle", value: "Every \(subscription.cycle)")
                Divider()
                // Avoids unknown error with dateFormatter when deleting the Subscription.
                if !self.deleteInProcess {
                    SubscriptionDataField(title: "Next Payment", value: dateFormatter.string(from: self.subscription.nextPayment))
                }
            }
            .padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 20))
            CustomDivider()
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
                .background(Color.customRedButton)
                .foregroundColor(Color.white)
                .font(.headline)
                .cornerRadius(6)
                .padding(EdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10))
            }.alert(isPresented: self.$showingAlert, content: {
                Alert(title: Text("Delete Subscription"), message: Text("This action can’t be undone. Are you sure?") ,primaryButton: Alert.Button.destructive(Text("Delete"), action: {
                    self.deleteSubscription()
                }), secondaryButton: Alert.Button.cancel(Text("No")))
            })
        }
        .navigationBarTitle("\(subscription.name)", displayMode: .inline)
    }
}

struct SubscriptionDetail_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let subscription: Subscription = Subscription(context: context)
        subscription.name = "Test"
        subscription.price = 9
        subscription.cycle = "month"
        subscription.nextPayment = Date()
        
        return SubscriptionDetailView(subscription: subscription)
    }
}
