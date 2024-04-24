//
//  TutorialWidget.swift
//  Learn Up
//
//  Created by PowerMac on 05.01.2024.
//

import UIKit
import WebKit

class TutorialWidget: UIViewController, WKUIDelegate {
    
    func tutorial(){
        if !LearnUpConfiguration.launchedEarlier {
            let settingsPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SettingController")  as UIViewController
            

            self.navigationController?.pushViewController(settingsPage , animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorial()
        AnalyticsManager.shared.logEvent(eventType: .openWidgetTutorial)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
