//
//  CategoryCollectionLocalViewController.swift
//  Learn Up
//
//  Created by PowerMac on 17.01.2024.
//

import UIKit

private let reuseIdentifier = "ExperimentalCollectionViewCell"

class CategoryCollectionLocalViewController: UICollectionViewController, CategorySelectionDelegateProtocol {
    var selectCollectionDelegate: ((WordCategoryProtocol?, CategorySelectionOperation) -> Void)?
    
    @IBOutlet var localCollectionView: UICollectionView!
    
    @IBOutlet weak var localCollectionFlowLayout: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
        NSLog("CollectionServer> viewDidLoad> discoverCategories: \(localCategories.count)")
        // Uncomment the following line to preserve selection between presentations
        self.localCollectionView.delegate = self
        
        // Register cell classes
        // MARK: - XIB
        let customCollectionViewCellNib = UINib(nibName: reuseIdentifier, bundle: nil)
        
        collectionView.register(customCollectionViewCellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        
    }
    
    private var localCategories: [[String: Any]] = []
    
    // MARK: - Fetch categories from server
    private func fetchCategories(){
        localCategories = CategoryWordStorage.loadAllCategoryLinks()
        localCategories = localCategories.filter { $0["id"] as! String != StorageConfiguration.savedCategoryKey }
        // then fetch from server
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.localCategories.count
    }
    
    // MARK: - Configuration cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let category: Dictionary = self.localCategories[indexPath.row]
        
        let cell : ExperimentalCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ExperimentalCollectionViewCell
        

        cell.thumbnail.image = UIImage(named: category["assetPath"] as? String ?? LearnUpConfiguration.baseCategoryAssetPath)
        
        let title = category["title"] as? String ?? "title"

        let rawLang = category["language"] as? String ?? "english"
        let lang = Languages(rawValue: rawLang)
        
        let isPremium = category[LocalMetaCategoryKeys.isPremium] as! Bool
        
        NSLog("isPremium: \(isPremium)")
       
        cell.title.text = title
        cell.showPremiumBadge(isPremium: isPremium)
        cell.langFlag.text = Languages.addFlag(word: "", lang: lang ?? .English)

        cell.showDeleteIcon(show: isManaging)
        
        return cell
    }
    
    // MARK: - Category Local Selected
    // MARK: - Category Deleting
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        
        let rawCategory: Dictionary = self.localCategories[indexPath.row]
        
        if self.isManaging {
            // delete collection
            
            let questionController = UIAlertController(title: "Are you sure you want to permanently remove collection?", message: "You can’t undo this action.", preferredStyle: .alert)
            questionController.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: {_ in
                let deleteCategoryRaw = self.localCategories[indexPath.item]
                
                guard let deleteId = deleteCategoryRaw[LocalMetaCategoryKeys.id] as? String else {
                    return
                }
                
                guard let deleteJson = CategoryWordStorage.loadJson(key: deleteId) else {
                    return
                }
                
                let deleteCategory = CategoryWordJsonCoder.fromJson(wordCategoryJson: deleteJson)
                
                self.localCategories.remove(at: indexPath.item)
                
                self.collectionView.deleteItems(at:[indexPath])
                CategoryWordStorage.removeCollection(category: deleteCategory)
                self.selectCollectionDelegate!(deleteCategory, .del)
                self.fetchCategories()
                self.collectionView.reloadData()
                
                // change to saved if deleted selected category
                
            }))
            
            questionController.addAction(UIAlertAction(title: "Back", style: .cancel))
            self.present(questionController, animated: true)
            
        } else {
            AnalyticsManager.shared.logEvent(eventType: .localCategorySelected, parameters: ["title": rawCategory[LocalMetaCategoryKeys.title] ?? "title not found"])
            
            // if account is premium - execute
            if rawCategory[LocalMetaCategoryKeys.isPremium]! as! Bool == false
                || MonetizationConfiguration.isPremiumAccount
            {
                let json = CategoryWordStorage.loadJson(key: rawCategory[LocalMetaCategoryKeys.id] as! String)
                if json != nil {
                    let category: CategoryWords = CategoryWordJsonCoder.fromJson(wordCategoryJson: json!)
                    self.selectCollectionDelegate!(category, .select)
                    
                    self.navigationController?.popViewController(animated: true)
                }
                
                
            } else {
                let paywallScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PaywallScreen")
                
                self.navigationController?.pushViewController(paywallScreen , animated: true)            }
        }
    }
    
    
    
    // MARK: - Manage toggle
    
    var isManaging: Bool = false
    
    @IBAction func startManageCollection(_ sender: UIBarButtonItem) {
        if self.isManaging == false {
            self.isManaging = true
        } else {
            self.isManaging = false
        }
        
        
        if self.isManaging == true {
            sender.title = "Done"
        } else {
            sender.title = "Manage"
        }
        
        NSLog("is managing \(self.isManaging)")
        
        self.collectionView.isEditing = self.isManaging
        self.collectionView.reloadData()
    }
    
    
}



