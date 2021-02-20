//
//  SubscriptionRow.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 29/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionRow: View {
    
    // MARK: - Properties
    
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
    private var SFSymbolImageString: String = ""
    private var todayText: String = ""
    private var tomorrowText: String = ""
    private var inXdays: String = ""
    private var inOneWeekText: String = ""
    
    // MARK: - Methods
    
    init(subscription: Subscription) {
        self.subscription = subscription
        
        self.configureUIElements()
        self.localizeText()
        
        self.compareTodaysDateWithPaymentDate()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // Get strings from localizable.
        self.todayText = NSLocalizedString("today", comment: "")
        self.tomorrowText = NSLocalizedString("tomorrow", comment: "")
        self.inOneWeekText = NSLocalizedString("inOneWeek", comment: "")
    }
    
    ///
    /// Configures the colors of the UI.
    ///
    private mutating func configureUIElements() {
        self.textColor = Color.white
        
        // BackgroundColor.
        let selectedColor: String = self.subscription.rowColor
        let selectedBackgroundColor: SubscriptionsViewModel.subscriptionRowColor = SubscriptionsViewModel.subscriptionRowColor(rawValue: selectedColor) ?? .blue
        
        let subscriptionRowBackgroundColor: Color = selectedBackgroundColor.convertFromStringToColor()
        let subscriptionRowStrokeColor: Color = subscriptionRowBackgroundColor
        
        self.backgroundColor = subscriptionRowBackgroundColor
        self.strokeColor = subscriptionRowStrokeColor
        
        // Icon - Logo - Image.
        let symbol: SubscriptionsViewModel.subscriptionCategory = SubscriptionsViewModel.subscriptionCategory.init(rawValue: self.subscription.category) ?? SubscriptionsViewModel.subscriptionCategory.none
        self.SFSymbolImageString = symbol.getSFSymbolImageString()
    }
    
    ///
    /// Compares today's date and the payment date, and displays a label if the date is 10 days or less apart.
    ///
    private mutating func compareTodaysDateWithPaymentDate() {
        
        let paymentDate: Date = self.subscription.nextPayment
        
        // Creates today's date with the time as 00:00:00. Ex. 2020/04/25 00:00:00
        var todayComponents: DateComponents = DateComponents()
        todayComponents.year = Date().getYearNumber()
        todayComponents.month = Date().getMonthNumber()
        todayComponents.day = Date().getDayNumber()
        todayComponents.hour = 1
        todayComponents.minute = 0
        todayComponents.second = 0
        let today: Date = Calendar.current.date(from: todayComponents) ?? Date()
        
        // Creates a new date adding 10 days to today's date.
        var dayComponent = DateComponents()
        dayComponent.day = 10
        let dateInTenDays: Date? = Calendar.current.date(byAdding: dayComponent, to: today)
        
        if let finalDate: Date = dateInTenDays {
            
            // Checks if payment date is before final date (today's date plus 10 days), and payment date is today or after today's date.
            if (paymentDate < finalDate) && (paymentDate >= today) {
                // There are less than 10 days of difference between dates.
                let component = Calendar.current.dateComponents([.day], from: today, to: paymentDate)
                if let daysLeft: Int = component.day {
                    // Shows the label on the row.
                    self.paymentDayNear = true
                    
                    // Displays a different text on the label based on the number of days left.
                    switch daysLeft {
                    case 0 :
                        self.daysToPaymentText = self.todayText
                    case 1:
                        self.daysToPaymentText = self.tomorrowText
                    case 2, 3, 4, 5, 6, 8, 9, 10 :
                        // FIXME: Do this in another way.
                        self.daysToPaymentText = String(format: NSLocalizedString("in %d days", comment: ""), daysLeft)
                    case 7:
                        self.daysToPaymentText = self.inOneWeekText
                    default:
                        self.daysToPaymentText = ""
                    }
                }
            }
        }
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationLink(destination: SubscriptionDetailView(subscription: subscription).environmentObject(self.subscriptionsViewModel)) {
            HStack {
                Image(systemName: self.SFSymbolImageString)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25, alignment: .center)
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
        
        // DateComponent.
        var dayComponent = DateComponents()
        
        // First Subscription.
        dayComponent.day = 2 // 2 Days
        
        let subscription1: Subscription = Subscription(context: context)
        subscription1.id = UUID()
        subscription1.name = "Test 1"
        subscription1.price = 9
        subscription1.cycle = "1y"
        subscription1.rowColor = SubscriptionsViewModel.subscriptionRowColor.blue.rawValue
        subscription1.nextPayment = Calendar.current.date(byAdding: dayComponent, to: Date())!
        
        // Second Subscription.
        dayComponent.day = 16 // 2 Weeks
        
        let subscription2: Subscription = Subscription(context: context)
        subscription2.id = UUID()
        subscription2.name = "Test 2"
        subscription2.price = 9
        subscription2.cycle = "2m"
        subscription1.rowColor = SubscriptionsViewModel.subscriptionRowColor.blue.rawValue
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
