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
    
}
