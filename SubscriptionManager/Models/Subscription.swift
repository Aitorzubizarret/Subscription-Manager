//
//  Subscription.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 29/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import Foundation

enum SubscriptionType: String {
    case prueba = "prueba"
    case pago = "pago"
}

struct Subscription: Identifiable {
    let id = UUID()
    let name: String
    let company: String
    let type: SubscriptionType
    let period: String
    let dayStart: String
    let dayEnd: String
    let price: Float
    let accountEmail: String
}
