//
//  PendingPaymentRow.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 07/02/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct PendingPaymentRow: View {
    
    // MARK: - Properties
    
    var payment: Payment
    var price: String {
        let paymentAmount: Float = payment.amount
        let finalPrice: String = String(format: "%.2f €", paymentAmount)
        return finalPrice
    }
    var SFSymbolImageString: String {
        let categorySymbol: SubscriptionsViewModel.subscriptionCategory = SubscriptionsViewModel.subscriptionCategory.init(rawValue: self.payment.subscription_category) ?? SubscriptionsViewModel.subscriptionCategory.none
        return categorySymbol.getSFSymbolImageString()
    }
    
    // MARK: - Methods
    
    init(payment: Payment) {
        self.payment = payment
    }
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Image(systemName: SFSymbolImageString)
                .frame(width: 40, height: 40, alignment: .center)
                .font(Font.system(size: 20, weight: Font.Weight.light, design: Font.Design.default))
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .foregroundColor(.black)
                .background(Color.customDarkGrey)
                .cornerRadius(6)
            VStack(alignment: .leading, spacing: 4) {
                Text(self.payment.subscription_name)
                    .font(Font.system(size: 20, weight: Font.Weight.bold, design: Font.Design.default))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                Text(self.payment.date.getYearMonthDay())
                    .font(Font.system(size: 14, weight: Font.Weight.light, design: Font.Design.default))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
            Spacer()
            Text(self.price)
                .font(Font.system(size: 16, weight: Font.Weight.bold, design: Font.Design.default))
        }
    }
}

struct PendingPaymentRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let payment: Payment = Payment(context: context)
        payment.id = UUID()
        payment.subscription_id = UUID()
        payment.subscription_name = "Demo"
        payment.subscription_category = "video"
        payment.amount = 4.95
        payment.date = Date()
        
        return PendingPaymentRow(payment: payment)
        .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
