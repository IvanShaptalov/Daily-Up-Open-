//
//  ExperimentalCollectionViewCell.swift
//  Learn Up
//
//  Created by PowerMac on 02.02.2024.
//

import UIKit

class ExperimentalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var isPremium: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    @IBOutlet weak var langFlag: UILabel!
    
    @IBOutlet weak var deleteIcon: UIImageView!
    
    func showPremiumBadge(isPremium: Bool) {
        if isPremium{
            self.isPremium.isHidden = false
        } else {
            self.isPremium.isHidden = true
        }
    }
    
    func showDeleteIcon(show: Bool){
        self.deleteIcon.isHidden = !show
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.showDeleteIcon(show: false)
        // Initialization code
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemFill.cgColor
        self.layer.cornerRadius = 15
    }

}
