//
//  Segues.swift
//  Learn Up
//
//  Created by PowerMac on 27.12.2023.
//

import Foundation

import UIKit

extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddWord" {
            let destination = segue.destination as! AddWordController
            
            
            // MARK: - Word saving via delegate
            destination.addWordDelegate = { [unowned self] word in
                if word != nil {
                    self.wordCategory.wordList.append(word as! Word)
                    tableView.reloadData()
                }
            }
        }
        
        if segue.identifier == "toDiscover" || segue.identifier == "toCollections" {
            var destination = segue.destination as! CategorySelectionDelegateProtocol
            
            destination.selectCollectionDelegate = { [unowned self] selectedCategory, operation in
                if selectedCategory != nil {
                    if operation == .del {
                        if selectedCategory?.id == self.wordCategory.id {
                            NSLog("deleted category - select saved category")
                            self.loadWordCategory()
                        }
                    } else {
                        NSLog("select new category")
                        self.wordCategory = selectedCategory as! CategoryWords
                    }
                    tableView.reloadData()
                }
            }
        }
        
        
        
        
    }
}
