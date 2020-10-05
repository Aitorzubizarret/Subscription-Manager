//
//  SubscriptionRow.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 29/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionRow: View {
    
    //MARK: - Properties
    var subscription: Subscription
    var backgroundColor: UIColor = UIColor.systemGray
    var textColor: Color = Color(UIColor.white)
    var price: String {
        let subscriptionPrice: Float = subscription.price
        let finalPrice: String = String(format: "%.2f €", subscriptionPrice)
        return finalPrice
    }
    
    //MARK: - View
    var body: some View {
        NavigationLink(destination: SubscriptionDetail(subscription: subscription)) {
            HStack {
                Image(systemName: "tv")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                    .scaledToFit()
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .foregroundColor(self.textColor)
                Text(subscription.name).font(Font.system(size: 18))
                    .foregroundColor(self.textColor)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                Spacer()
                Text(price).font(Font.system(size: 15))
                    .foregroundColor(self.textColor)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                }
            .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
            .background(Color(self.backgroundColor))
            .cornerRadius(6)
        }
    }
}

struct SubscriptionRow_Previews: PreviewProvider {
    static let subscription: Subscription = Subscription(name: "AppleTV", company: "Apple", type: SubscriptionType.trial, period: "Month", dayStart: "2020/09/01", dayEnd: "2020/09/30", price: 0, accountEmail: "email@gmail.com")
    
    static var previews: some View {
        SubscriptionRow(subscription: subscription)
    }
}
