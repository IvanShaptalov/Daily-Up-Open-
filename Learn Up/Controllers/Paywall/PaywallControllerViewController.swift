//
//  PaywallControllerViewController.swift
//  Learn Up
//
//  Created by PowerMac on 05.02.2024.
//

import UIKit

let subReuseIdentifier = "SubscriptionCell"

class PaywallControllerViewController: UIViewController{
    var selectedSub: SubscriptionObj?
    
    @IBOutlet weak var purchaseButton: UIButton!
    
    var subs: [SubscriptionObj] = RevenueCatProductsProvider.subscriptionList

    // MARK: - Make purchase
    @IBAction func buySubscriptionPressed(_ sender: UIButton) {
        if selectedSub == nil {
            print("select sub plan")
            let alert = UIAlertController(title: "Select plan to continue", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        } else {
            
            RevenueCatProductsProvider.makePurchase(package: selectedSub!.package) { status in
                NSLog("PaywallControllerViewController > buySubscriptionPressed > RevenueCatProductsProvider.makePurchase : \(status.rawValue)")
                if status == .Processing {
                    self.purchaseButton.configuration?.showsActivityIndicator = true
                } else {
                    self.purchaseButton.configuration?.showsActivityIndicator = false
                }
            }
        }
    }
    
    @IBOutlet weak var subscriptionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Fetch subs if empty
        
        if self.subs.isEmpty {
            NSLog("subs is empty, start load")
            RevenueCatProductsProvider.getOffering(subCallback: {subs in
                self.subs = subs
                self.subscriptionTableView.reloadData()
            }, catchError: {error in
                self.subs = []
                self.subscriptionTableView.reloadData()
            })
        }
        
        self.subscriptionTableView.register(.init(nibName: subReuseIdentifier, bundle: nil), forCellReuseIdentifier: subReuseIdentifier)
        // MARK: - Select first sub
        if subs.count > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            subscriptionTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            selectedSub = self.subs[indexPath.row]
        }
//         Do any additional setup after loading the view.
    }
}

// MARK: - Table settings
extension PaywallControllerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subs.count
    }
    
    // MARK: configure cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: subReuseIdentifier, for: indexPath) as! SubscriptionCell
        let s = subs[indexPath.row]

        cell.setSubDuration(offerDurationText: s.subOffer, priceDuration: s.priceDuration)
        cell.setDiscount(s.discount)
        cell.subTitle.text = s.title
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - Row select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let cell = subs[indexPath.row]
        print(cell.title)
        self.selectedSub = cell
    }
    
    
}

