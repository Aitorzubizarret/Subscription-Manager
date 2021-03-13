//
//  Date.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 10/11/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

extension Date {
    
    ///
    /// Gets the number of the day from the date, if it's possible.
    /// - Returns: The number of the day (in case there is no problem formatting and converting it from a Date/String to an Int). Ex: 1, 2, 3, 10, 11, 12, ...
    ///
    func getDayNumber() -> Int? {
        
        // Date formatter.
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        // Converts from String to Int.
        let dayNumber: Int? = Int(formatter.string(from: self))
        
        return dayNumber
    }
    
    ///
    /// Gets the name of the day of the week.
    /// - Returns: Ex. Monday
    ///
    func getDayOfWeek() -> String {
        
        // Date formatter.
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        // Converts from String to Int.
        let dayOfWeek: String = formatter.string(from: self)
        
        return dayOfWeek
    }
    
    ///
    /// Gets the number of the month from the date, if it's possible.
    /// - Returns: The number of the month (In case there is no problem formatting and converting it from a Date/String to an Int). Ex: 1, 2, 3, 10, 11, 12
    ///
    func getMonthNumber() -> Int? {
        
        // Date formatter.
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MM"
        
        // Converts from String to Int.
        let monthNumber: Int? = Int(formatter.string(from: self))
        
        return monthNumber
    }
    
    ///
    /// Gets the number of the year from a date.
    /// - Returns: The number of the year, if it's possible.
    ///
    func getYearNumber() -> Int? {
        
        // Date formatter.
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        // Converts from String to Int.
        let yearNumber: Int? = Int(formatter.string(from: self))
        
        return yearNumber
    }
    
    ///
    /// Gets the full name of the month from a date.
    /// - Returns: The full name of the month.
    ///
    func getMonthFullName() -> String {
        
        // Date formatter.
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        
        let monthFullName: String = formatter.string(from: self)
        
        return monthFullName
    }
    
    ///
    /// Gets the date in the format year/month/day.
    /// - Returns: Ex. 2020/04/25
    ///
    func getYearMonthDay() -> String {
        
        // Date formatter.
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let yearMonthDay: String = formatter.string(from: self)
        
        return yearMonthDay
    }
    
    ///
    /// Compares two dates, but only the year, month and day, not the time.
    /// - Returns: True if the first date is older than the second, otherwise false.
    ///
    func isOlderThan(date: Date) -> Bool {
        var response: Bool = true
        
        let date1: Date = self
        let date2: Date = date
        
        if (date1.getYearNumber() ?? 1) > (date2.getYearNumber() ?? 1) {
            // Year is bigger.
            response = false
        } else if (date1.getYearNumber() ?? 1) == (date2.getYearNumber() ?? 1) && (date1.getMonthNumber() ?? 1) > (date2.getMonthNumber() ?? 1) {
            // Month is bigger.
            response = false
        } else if (date1.getYearNumber() ?? 1) == (date2.getYearNumber() ?? 1) && (date1.getMonthNumber() ?? 1) == (date2.getMonthNumber() ?? 1) && (date1.getDayNumber() ?? 1) > (date2.getDayNumber() ?? 1) {
            // Day is bigger.
            response = false
        }
        
        return response
    }
    
    ///
    /// Checks if the received date is the same as the current date.
    /// - Returns: True if the date is the same year and month as the current one and the day is beweetn today and then end of the month,
    ///
    func isInRangeBetweenTodayAndEndOfCurrentMonth() -> Bool {
        var response: Bool = false
        
        let receivedDate: Date = self
        let currentDate: Date = Date()
        
        if receivedDate.getYearNumber() == currentDate.getYearNumber(),
           receivedDate.getMonthNumber() == currentDate.getMonthNumber(),
           receivedDate.getDayNumber() ?? 1 >= currentDate.getDayNumber() ?? 1 {
            response = true
        }
        
        return response
    }
    
}
