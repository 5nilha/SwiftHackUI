//
//  Appointment.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 5/1/21.
//

import Foundation

public struct Appointment {
    public let startTime: Date
    public private (set) var endTime: Date?
    public let minutesDuration: Int
    public let title: String
    public private (set) var subTitle: String?
    
    init(startTime: Date, minutesDuration: Int, title: String, subTitle: String? = nil) {
        self.startTime = startTime
        self.minutesDuration = minutesDuration
        self.title = title
        self.subTitle  = subTitle
        self.endTime = startTime.dateFrom(.minute, value: minutesDuration)
    }
}
