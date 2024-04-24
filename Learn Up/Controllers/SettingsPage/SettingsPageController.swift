//
//  SettingsPageController.swift
//  Learn Up
//
//  Created by PowerMac on 03.01.2024.
//

import UIKit

class SettingsPageController: UITableViewController {

    
    @IBOutlet weak var targetLang: UIButton!
    
    @IBOutlet weak var nativeLang: UIButton!
    
    private func fixFirstLaunch(){
        NSLog("fix launch...")
        if !LearnUpConfiguration.launchedEarlier {
            LearnUpConfiguration.launchedEarlier = true
            
            SettingsStorage.saveIsFirstLaunch(true)
            NSLog("fixed ✅")
        }
    }
    
    private func showTutorial(){
        if !LearnUpConfiguration.launchedEarlier {          
            fixFirstLaunch()
            }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PulldownButton.setUpLanguages(button: &targetLang,buttonTitle: PulldownButtonType.fromLan, menuClosure: {(action: UIAction) in
            
            LearnUpConfiguration.defaultFromLang = Languages(rawValue: Languages.removeEmoji(lang: action.title))!
            
            AnalyticsManager.shared.logEvent(eventType:.selectLearnLang)

        })
        PulldownButton.setUpLanguages(button: &nativeLang, buttonTitle: PulldownButtonType.toLan, menuClosure: {(action: UIAction) in
            
            LearnUpConfiguration.defaultUILang = Languages(rawValue: Languages.removeEmoji(lang: action.title))!
            AnalyticsManager.shared.logEvent(eventType:.selectUILang)

        })
        
        showTutorial()
    }
}
