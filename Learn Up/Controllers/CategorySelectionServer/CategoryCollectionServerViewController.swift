//
//  CategoryCollectionServerViewController.swift
//  Learn Up
//
//  Created by PowerMac on 17.01.2024.
//

import UIKit

private let reuseIdentifier = "ExperimentalCollectionViewCell"

class CategoryCollectionServerViewController: UICollectionViewController, CategorySelectionDelegateProtocol {
    var selectCollectionDelegate: ((WordCategoryProtocol?, CategorySelectionOperation) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
        NSLog("CollectionServer> viewDidLoad> discoverCategories: \(discoverCategories.count)")
        
        // Register cell classes
        // MARK: - XIB
        let customCollectionViewCellNib = UINib(nibName: reuseIdentifier, bundle: nil)
        
        collectionView.register(customCollectionViewCellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    private var discoverCategories: [[String: Any]] = []
    
    // MARK: - Fetch categories from server
    private func fetchCategories(){
        discoverCategories = CategoryPrototypeStorage.loadCategoryPrototypes()
        
        FirebaseStorage.shared.fetchAllPrototypes(callback: { snapshot in
            // Get user value
            let serverCategories = FirebaseStorage.snapshotToCategories(snapshot: snapshot)
            
            for sc in serverCategories {
                self.discoverCategories.append(sc)
            }
            NSLog("fetchCategories -> fetched from server, count: \(self.discoverCategories.count)")
            self.collectionView.reloadData()
            
        })
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.discoverCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let category: Dictionary = self.discoverCategories[indexPath.row]
        
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
        
        return cell
    }
    
    // MARK: - Collection Selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category: Dictionary = self.discoverCategories[indexPath.row]
        
        AnalyticsManager.shared.logEvent(eventType: .discoverCategorySelected, parameters: ["title": category[LocalMetaCategoryKeys.title] ?? "title not found"])
        
        // if account is premium - execute
        if category[LocalMetaCategoryKeys.isPremium]! as! Bool == false || MonetizationConfiguration.isPremiumAccount{
            NSLog("category not premium")
            // MARK: - Generate from server
            if category[LocalMetaCategoryKeys.isFromFirebase] as? Bool ?? false {
                CategoryPrototypeProvider.tryGenerateCategoryFromServer(
                    categoryId: category[LocalMetaCategoryKeys.id] as! String,
                    toLanguage: LearnUpConfiguration.defaultUILang,
                    callback:
                        {categoryFromServer in
                            
                            self.selectCollectionDelegate!(categoryFromServer, .select)
                            self.navigationController?.viewControllers.forEach { viewController in
                                if viewController is HomeViewController {
                                    self.navigationController?.popToViewController(viewController, animated: true)
                                }
                            }
                        }) {
                            error in
                            NSLog(error.localizedDescription)
                        }
                // here info about generating
            }
            // MARK: - Generate locally
            else {
                do {
                    let resultCategory: CategoryWords = try CategoryPrototypeProvider.tryGenerateCategory(categoryId: category[LocalMetaCategoryKeys.id] as! String, toLanguage: LearnUpConfiguration.defaultUILang)
                    
                    NSLog("collection selected > after generating save category: \(resultCategory.title) word count: \(resultCategory.wordList.count)")
                    CategoryWordStorage.saveJson(category: resultCategory)
                    
                    self.selectCollectionDelegate!(resultCategory, .select)
                    
                    self.navigationController?.popViewController(animated: true)
                    
                } catch CategoryError.ExternalCategoryNotFound{
                    NSLog(" external category not found error")
                } catch CategoryError.CategoryNotFound {
                    NSLog("category not found error")
                    
                } catch CategoryError.ExternalCategoryIdNotFound {
                    NSLog(" external category id not found error")
                    
                } catch {
                    
                }
            }
            
        } else {
            let paywallScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PaywallScreen")
            
            self.navigationController?.pushViewController(paywallScreen , animated: true)
            
        }
    }
    
    
    
}

