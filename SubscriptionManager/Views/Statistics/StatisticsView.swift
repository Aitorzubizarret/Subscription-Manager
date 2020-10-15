//
//  StatisticsView.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 02/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    
    //MARK: - Properties
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    
    //MARK: - View
    var body: some View {
        Text("Statistics for \(self.subscriptionsViewModel.subscriptions.count) subscriptions.")
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static let subscriptionsViewModel = SubscriptionsViewModel()
    
    static var previews: some View {
        StatisticsView().environmentObject(subscriptionsViewModel)
    }
}
