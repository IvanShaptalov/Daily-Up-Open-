//
//  UIButtonPulldownMenu.swift
//  Learn Up
//
//  Created by PowerMac on 28.12.2023.
//

import Foundation

import UIKit

class PulldownButton {
    
    static public func setUpLanguages(button: inout UIButton, buttonTitle: PulldownButtonType, menuClosure: @escaping (UIAction) -> () = {(action: UIAction) in }) {
       
        var children: [UIAction] = []
        
        for lang in Languages.allValues {
            if (lang == LearnUpConfiguration.defaultFromLang && buttonTitle == PulldownButtonType.fromLan) ||
                (lang == LearnUpConfiguration.defaultUILang && buttonTitle == PulldownButtonType.toLan)
            {
                children.append(UIAction(title: "\(lang.rawValue) \(Languages.langToEmoji(lang: lang)) ".capitalized,state: .on, handler: menuClosure))
            }
            
            else {
                children.append(UIAction(title: "\(lang.rawValue) \(Languages.langToEmoji(lang: lang)) ".capitalized, handler: menuClosure))
            }
            
        }
        
        button.menu = UIMenu(children: children)
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        
        
    }
    
    static public func setUpLanguages(button: inout UIButton, buttonTitle: PulldownButtonType, savedLang: Languages) {
        let menuClosure = {(action: UIAction) in
        }
        
        var children: [UIAction] = []
        
        for lang in Languages.allValues {
            if (lang == savedLang && buttonTitle == PulldownButtonType.fromLan) ||
                (lang == savedLang && buttonTitle == PulldownButtonType.toLan)
            {
                children.append(UIAction(title: "\(lang.rawValue) \(Languages.langToEmoji(lang: lang)) ".capitalized,state: .on, handler: menuClosure))
            }
            
            else {
                children.append(UIAction(title: "\(lang.rawValue) \(Languages.langToEmoji(lang: lang)) ".capitalized, handler: menuClosure))
            }
            
        }
        
        button.menu = UIMenu(children: children)
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        
        
    }
}



public enum PulldownButtonType{
    case fromLan, toLan
}
