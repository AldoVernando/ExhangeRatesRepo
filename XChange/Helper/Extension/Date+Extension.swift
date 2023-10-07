//
//  Date+Extension.swift
//  XChange
//
//  Created by Aldo Vernando on 06/10/23.
//

import Foundation

/**
 An extension for the Date type, providing methods and properties to simplify working with dates.
 */
extension Date {
    
    /**
     Calculates the time difference between the current date and another date in terms of months, days, hours, minutes, and seconds.
     
     - Parameter date: The date to calculate the time difference with.
     - Returns: A tuple containing the time difference components. If a component is not applicable, it is `nil`.
     */
    func timeDiff(for date: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: self, to: date).day
        let month = Calendar.current.dateComponents([.month], from: self, to: date).month
        let hour = Calendar.current.dateComponents([.hour], from: self, to: date).hour
        let minute = Calendar.current.dateComponents([.minute], from: self, to: date).minute
        let second = Calendar.current.dateComponents([.second], from: self, to: date).second
        
        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
}
