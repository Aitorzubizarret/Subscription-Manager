//
//  String.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta Perez on 13/03/2021.
//  Copyright © 2021 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

extension String {
    
    ///
    /// Converts a String into date.
    /// - Parameter : Self as a String.
    /// - Returns : An optional Date. 
    ///
    func convertToDate() -> Date? {
        // Date formatter.
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let convertedDate: Date? = formatter.date(from: self)
        
        return convertedDate
    }
}
