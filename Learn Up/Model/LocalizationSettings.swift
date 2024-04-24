//
//  Settings.swift
//  Learn Up
//
//  Created by PowerMac on 02.01.2024.
//

import Foundation


struct LocalizationSettings: LocalizationSettingsProtocol, Codable {
    var defaultFromLang: Languages
    
    var defaultToLang: Languages
    
    var uiLanguage: Languages
}
