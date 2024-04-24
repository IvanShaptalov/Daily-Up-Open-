//
//  AutofillPerDay.swift
//  Learn Up
//
//  Created by PowerMac on 25.01.2024.
//

import Foundation


struct AutofillPerDay: Codable {
    var count: Int
    var created: Date
}


struct DayStreak: Codable {
    var count: Int
    var created: Date
}
