//
//  CalendarField.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 05/11/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct CalendarField: View {
    
    // MARK: - Properties
    
    @Binding var selectedDate: Date
    @State private var selectedYear: Int
    @State private var selectedMonth: Int
    @State private var selectedDay: Int
    @State private var calendarYear: Int = 0
    @State private var calendarMonth: Int = 0 {
        didSet {
            self.updateCalendar()
        }
    }
    @State private var calendarDay: Int = 0
    @State private var calendarMonthName: String = ""
    @State private var daysPosition: [String] = []
    private var spacing: CGFloat {
        return (UIScreen.main.bounds.size.width - (12 * 4) - (40 * 7)) / 6
    }
    private var title: String
    private var textWidth: CGFloat {
        return (UIScreen.main.bounds.size.width - 12 - 88 - 24 - 4 - 12)
    }
    private var daysNames: [String] = []
    
    // MARK: - Methods
    
    init(title: String, value: Binding<Date>) {
        self.title = title
        self._selectedDate = value
        self._selectedYear = State(wrappedValue: 0)
        self._selectedMonth = State(wrappedValue: 0)
        self._selectedDay = State(wrappedValue: 0)
        
        self.localizeText()
        
        self.setCalendarDate()
    }
    
    ///
    /// Localize UI text elements.
    ///
    private mutating func localizeText() {
        // FIXME: Use native strings from calendar.
        self.daysNames = [
            NSLocalizedString("monday", comment: ""),
            NSLocalizedString("tuesday", comment: ""),
            NSLocalizedString("wednesday", comment: ""),
            NSLocalizedString("thursday", comment: ""),
            NSLocalizedString("friday", comment: ""),
            NSLocalizedString("saturday", comment: ""),
            NSLocalizedString("sunday", comment: "")
        ]
    }
    
    ///
    /// Sets the calendar date.
    ///
    private mutating func setCalendarDate() {
        
        // Number of the year.
        if let yearNumber: Int = self.selectedDate.getYearNumber() {
            self._calendarYear = State(wrappedValue: yearNumber)
            self._selectedYear = State(wrappedValue: yearNumber)
        }
        
        // Number of the month.
        if let monthNumber: Int = self.selectedDate.getMonthNumber() {
            self._calendarMonth = State(wrappedValue: monthNumber)
            self._selectedMonth = State(wrappedValue: monthNumber)
        }
        
        // Number of the day.
        if let dayNumber: Int = self.selectedDate.getDayNumber() {
            self._calendarDay = State(wrappedValue: dayNumber)
            self._selectedDay = State(wrappedValue: dayNumber)
        }
        
        // Full name of the month.
        self._calendarMonthName = State(wrappedValue: selectedDate.getMonthFullName())
        
        // Days position in calendar.
        self._daysPosition = State(wrappedValue: self.getDaysPositionInCalendar())
    }
    
    ///
    /// Gets how many days a month has and returns it as a number.
    /// - Returns : A number representing the amount of days of the month.
    ///
    private func getDaysInMonth() -> Int {
        // Create a date with components.
        var components = DateComponents()
        components.month = self.calendarMonth
        components.year = self.calendarYear
        
        let date: Date = Calendar.current.date(from: components) ?? Date()
        
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    ///
    /// Calculates the position of each day in the calendar and returns it.
    /// - Returns : An array of strings representing the position of each day.
    ///
    private func getDaysPositionInCalendar() -> [String] {
        
        // Gets how many days the calendar month has.
        let numberDaysInMonth: Int = self.getDaysInMonth()
        
        // Creates the structure.
        var structure: [String] = []
        
        // Creates a new date with the first day of the calendar month.
        var components = DateComponents()
        components.second = 0
        components.minute = 0
        components.hour = 1
        components.day = 1
        components.month = self.calendarMonth
        components.year = self.calendarYear
        
        // Get day of the week.
        let date = Calendar.current.date(from: components) ?? Date()
        let dayName: String = date.getDayOfWeek()
        
        switch dayName {
        case "Tuesday":
            structure.append("")
        case "Wednesday":
            structure.append("")
            structure.append("")
        case "Thursday":
            structure.append("")
            structure.append("")
            structure.append("")
        case "Friday":
            structure.append("")
            structure.append("")
            structure.append("")
            structure.append("")
        case "Saturday":
            structure.append("")
            structure.append("")
            structure.append("")
            structure.append("")
            structure.append("")
        case "Sunday":
            structure.append("")
            structure.append("")
            structure.append("")
            structure.append("")
            structure.append("")
            structure.append("")
        default:
            structure = []
        }
        
        // All months have at least 28 days.
        for day in 1...28 {
            structure.append("\(day)")
        }
        
        // Except february, the rest have more than 28 days.
        if numberDaysInMonth > 28 {
            for extraDay in 29...numberDaysInMonth {
                structure.append("\(extraDay)")
            }
        }
        
        // Fill the rest of the structure with empty spaces.
        for _ in self.daysPosition.count...42 {
            structure.append("")
        }
        
        return structure
    }
    
    ///
    /// Checks if the day is the selected day to highlight it on the calendar.
    /// - Parameter dayNumber : The number of the day.
    /// - Returns : True if the number of the day received is the selected day.
    ///
    private func isSelectedDay(dayNumber: String) -> Bool {
        
        // Convert received string number into an Int.
        let day: Int = Int(dayNumber) ?? 0
        
        // Check if the day, month and year is the same.
        if self.selectedDay == day {
            if (self.selectedMonth == self.calendarMonth) && (self.selectedYear == self.calendarYear) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    ///
    /// Updates the calendar.
    ///
    private func updateCalendar() {
        
        // Create the new date.
        var components = DateComponents()
        components.second = 0
        components.minute = 0
        components.hour = 1
        components.day = 1
        components.month = self.calendarMonth
        components.year = self.calendarYear
        
        let date = Calendar.current.date(from: components) ?? Date()
        
        // Get the month name.
        let actualMonthName: String = date.getMonthFullName()
        self.calendarMonthName = actualMonthName
        
        // Get the position of each day in the new month.
        self.daysPosition = []
        self.daysPosition = self.getDaysPositionInCalendar()
    }
    
    ///
    /// Changes the month of the calendar to the previous one.
    ///
    private func goToPreviousMonth() {
        if self.calendarMonth == 1 {
            self.calendarYear = self.calendarYear - 1
            self.calendarMonth = 12
        } else {
            self.calendarMonth = self.calendarMonth - 1
        }
    }
    
    ///
    /// Changes the month of the calendar to the next one.
    ///
    private func goToNextMonth() {
        if self.calendarMonth == 12 {
            self.calendarYear = self.calendarYear + 1
            self.calendarMonth = 1
        } else {
            self.calendarMonth = self.calendarMonth + 1
        }
    }
    
    ///
    /// Changes the selected day to the received one.
    /// - Parameter day : A string that represents a day number selected by the user.
    ///
    private func updateSelectedDay(day: String) {
        if day != "" {
            // Update selected day.
            self.selectedDay = Int(day) ?? 0
            
            // Save the rest of the date.
            self.selectedMonth = self.calendarMonth
            self.selectedYear = self.calendarYear
            
            // Update selected date.
            var components = DateComponents()
            components.second = 0
            components.minute = 0
            components.hour = 1
            components.day = self.selectedDay
            components.month = self.calendarMonth
            components.year = self.calendarYear
            
            self.selectedDate = Calendar.current.date(from: components) ?? Date()
        }
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            FieldTitle(title: self.title)
            HStack(spacing: 0) {
                Button(action: {
                    self.goToPreviousMonth()
                }) {
                    Image(systemName: "chevron.left")
                        .font(Font.system(size: 18))
                        .foregroundColor(Color.customDarkText)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .frame(width: 44, height: 44, alignment: .center)
                        .background(RoundedCorners(upperLeft: 10, upperRight: 0, lowerLeft: 10, lowerRigth: 0))
                        .foregroundColor(Color.customGrayButton)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 3))
                Text(self.calendarMonthName.capitalized + " \(self.calendarYear)")
                    .font(Font.system(size: 16))
                    .fontWeight(Font.Weight.medium)
                    .foregroundColor(Color.black)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .frame(width: self.textWidth, height: 44, alignment: .center)
                    .background(Color.customGrayButton)
                Button(action: {
                    self.goToNextMonth()
                }) {
                    Image(systemName: "chevron.right")
                        .font(Font.system(size: 18))
                        .foregroundColor(Color.customDarkText)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .frame(width: 44, height: 44, alignment: .center)
                        .background(RoundedCorners(upperLeft: 0, upperRight: 10, lowerLeft: 0, lowerRigth: 10))
                        .foregroundColor(Color.customGrayButton)
                }
                .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 0))
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
            HStack(spacing: self.spacing) {
                ForEach(self.daysNames, id: \.self) { name in
                    CalendarDayElement(type: .letter, value: name, selected: false)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
            ForEach(0..<6, id: \.self) { rowIndex in
                HStack(spacing: self.spacing) {
                    ForEach((rowIndex*7)..<((rowIndex*7)+7), id: \.self) { columnIndex in
                        Button(action: {
                            self.updateSelectedDay(day: self.daysPosition[columnIndex])
                        }) {
                            CalendarDayElement(type: .number, value: self.daysPosition[columnIndex], selected: self.isSelectedDay(dayNumber: self.daysPosition[columnIndex]))
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
            }
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }
}

struct CalendarField_Previews: PreviewProvider {
    static var previews: some View {
        CalendarField(title: "Calendar", value: .constant(Date()))
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
