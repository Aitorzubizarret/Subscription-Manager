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
    
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    var subscription: Subscription
    var price: String {
        let subscriptionPrice: Float = subscription.price
        let finalPrice: String = String(format: "%.2f €", subscriptionPrice)
        return finalPrice
    }
    private var daysToPaymentText: String = ""
    private var paymentDayNear: Bool = false
    private var textColor: Color = Color.clear
    private var backgroundColor: Color = Color.clear
    private var strokeColor: Color = Color.clear
    private var widthValue: CGFloat {
        return (UIScreen.main.bounds.size.width - 15 - 15) // SubscriptionView, leading and trailing padding.
    }
    
    //MARK: - Methods
    
    init(subscription: Subscription) {
        self.subscription = subscription
        
        self.configureUIElements()
        
        self.compareTodayDateAndPaymentDate()
    }
    
    ///
    /// Configures the colors of the UI.
    ///
    private mutating func configureUIElements() {
        self.textColor = Color.white
        self.backgroundColor = Color.customRowPistachio
        self.strokeColor = Color.customRowPistachio
    }
    
    ///
    /// Compares today's date and the payment date, and displays a label if the date is 10 days or less apart.
    ///
    private mutating func compareTodayDateAndPaymentDate() {
        
        let paymentDate: Date = self.subscription.nextPayment
        
        // Creates today's date. Ex. 2020/04/25 00:00:00
        var todayComponents: DateComponents = DateComponents()
        todayComponents.year = Date().getYearNumber()
        todayComponents.month = Date().getMonthNumber()
        todayComponents.day = Date().getDayNumber()
        todayComponents.hour = 1
        todayComponents.minute = 0
        todayComponents.second = 0
        let today: Date = Calendar.current.date(from: todayComponents) ?? Date()
        
        // Create the date, Today plus 10 more days.
        var dayComponent = DateComponents()
        dayComponent.day = 10
        let dateInTenDays: Date? = Calendar.current.date(byAdding: dayComponent, to: today)
        
        if let finalDate: Date = dateInTenDays {
            if paymentDate > finalDate {
                self.paymentDayNear = false
            } else {
                let component = Calendar.current.dateComponents([.day], from: today, to: paymentDate)
                if let daysLeft: Int = component.day {
                    switch daysLeft {
                    case 0 :
                        self.daysToPaymentText = "Today"
                    case 1:
                        self.daysToPaymentText = "Tomorrow"
                    case 2, 3, 4, 5, 6, 8, 9, 10 :
                        self.daysToPaymentText = "In \(daysLeft) days"
                    case 7:
                        self.daysToPaymentText = "In 1 week"
                    default:
                        self.daysToPaymentText = ""
                    }
                    
                }
                self.paymentDayNear = true
            }
        } else {
            self.paymentDayNear = false
        }
    }
    //MARK: - View
    
    var body: some View {
        NavigationLink(destination: SubscriptionDetailView(subscription: subscription).environmentObject(self.subscriptionsViewModel)) {
            HStack {
                Image(systemName: "tv")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                    .scaledToFit()
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .foregroundColor(self.textColor)
                Text(subscription.name)
                    .font(Font.system(size: 18, weight: Font.Weight.bold, design: Font.Design.default))
                    .foregroundColor(self.textColor)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    if self.paymentDayNear {
                        Text(price)
                            .font(Font.system(size: 18, weight: Font.Weight.bold, design: Font.Design.default))
                            .foregroundColor(self.textColor)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        Text(self.daysToPaymentText)
                            .font(Font.system(size: 12, weight: Font.Weight.medium, design: Font.Design.default))
                            .foregroundColor(self.textColor)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    } else {
                        Text(price)
                            .font(Font.system(size: 18, weight: Font.Weight.bold, design: Font.Design.default))
                            .foregroundColor(self.textColor)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    }
                }
            }
            .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
            .frame(width: self.widthValue, height: 62, alignment: .leading)
            .background(self.backgroundColor)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(self.strokeColor, lineWidth: 2)
            )
        }
    }
}

struct SubscriptionRow_Previews: PreviewProvider {
    static let subscriptionsViewModel = SubscriptionsViewModel()
    
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // First Subscription.
        let subscription1: Subscription = Subscription(context: context)
        subscription1.id = UUID()
        subscription1.name = "Test 1"
        subscription1.price = 9
        subscription1.cycle = "1y"
        subscription1.nextPayment = Date()
        
        // Second Subscription with a DateComponent.
        var dayComponent = DateComponents()
        dayComponent.day = 16 // 2 Weeks
        
        let subscription2: Subscription = Subscription(context: context)
        subscription2.id = UUID()
        subscription2.name = "Test 2"
        subscription2.price = 9
        subscription2.cycle = "2m"
        subscription2.nextPayment = Calendar.current.date(byAdding: dayComponent, to: Date())!
        
        return Group {
            SubscriptionRow(subscription: subscription1).environmentObject(subscriptionsViewModel)
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Payment day near")
            
            SubscriptionRow(subscription: subscription2).environmentObject(subscriptionsViewModel)
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Payment day NOT near")
        }
    }
}
