//
//  FeedbackPageController.swift
//  Learn Up
//
//  Created by PowerMac on 04.01.2024.
//

import UIKit
import MessageUI

class FeedbackPageController: UIViewController, MFMailComposeViewControllerDelegate {
    
    private func sendEmail() {
        if !MFMailComposeViewController.canSendMail() {
            let alertController = UIAlertController(title: "Email unavailable", message: "But you can copy email address", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Later", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Copy email", style: .default, handler: {action in
                UIPasteboard.general.string = FeedBackConfiguration.mailURL
                
            }))
            self.present(alertController, animated: true)
            return
        }
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([FeedBackConfiguration.mailURL])
        composeVC.setSubject("Daily Up enhancing, ideas 💡")
        let body: String = """
Firstly - include audio pronunciation for each word;
Additionally - ...
Moreover - integrating a daily quiz;
"""
        composeVC.setMessageBody(body, isHTML: false)
        
        self.present(composeVC, animated: true, completion: nil)
    }
    
    @IBAction func leaveFeedbackAppstore(_ sender: UIButton) {
        RateProvider.rateApp()
        AnalyticsManager.shared.logEvent(eventType: .rateDirect)

    }
    
    @IBAction func leaveFeedbackMail(_ sender: UIButton) {
        sendEmail()
    }
    
    @IBAction func leaveFeedbackTikTok(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: FeedBackConfiguration.TikTokURL)!)
    }
    @IBAction func leaveFeedbackTg(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: FeedBackConfiguration.telegramURL)!)
    }
    
    @IBAction func leaveFeedbackInstagram(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: FeedBackConfiguration.InstagramURL)!)
        
    }
    @IBAction func leaveFeedbackX(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: FeedBackConfiguration.XURL)!)
    }
    
    @IBOutlet weak var viewCard: UIView!
    //MARK: - viewCard layer
    
    private func setUpViewCard(viewCard: inout UIView){
        viewCard.layer.cornerRadius = 10
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewCard(viewCard: &viewCard)
        // Do any additional setup after loading the view.
    }
}
