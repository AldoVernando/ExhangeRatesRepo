//
//  Date+Extension.swift
//  XChange
//
//  Created by Aldo Vernando on 06/10/23.
//

import Foundation

extension Date {
    
    func timeDiff(for date: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: self, to: date).day
        let month = Calendar.current.dateComponents([.month], from: self, to: date).month
        let hour = Calendar.current.dateComponents([.hour], from: self, to: date).hour
        let minute = Calendar.current.dateComponents([.minute], from: self, to: date).minute
        let second = Calendar.current.dateComponents([.second], from: self, to: date).second
        
        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
}
