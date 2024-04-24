//
//  WordTableExtension.swift
//  Learn Up
//
//  Created by PowerMac on 25.12.2023.
//

import Foundation

import UIKit

// MARK: - Table View configuration
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordCategory.wordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell") {
          
            cell = reuseCell } else {
             
                
                cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell") }
        configure(cell: &cell, for: indexPath)
        return cell
    }
    
    
    
    
    
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        // target word
        configuration.text = Languages.addFlag(word: wordCategory.wordList[indexPath.row].word, lang: wordCategory.wordList[indexPath.row].fromLang).capitalized
        // translation
        configuration.secondaryText = Languages.addFlag(word: wordCategory.wordList[indexPath.row].translation, lang: wordCategory.wordList[indexPath.row].toLang).capitalized
        
        configuration.secondaryTextProperties.font = configuration.textProperties.font
        
        
        if (wordCategory.wordList[indexPath.row].isLearned){
            configuration.image = .init(UIImage(systemName: "checkmark.circle")!)!
            
        }
        
        
        
        cell.contentConfiguration = configuration
        
    }
    
}

// MARK: - Cell swipe actions


extension HomeViewController: UITableViewDelegate{
    private func getActions(indexPath: IndexPath) -> [UIContextualAction]{
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in

            self.wordCategory.wordList.remove(at: indexPath.row)
            self.tableView.reloadData()
            AnalyticsManager.shared.logEvent(eventType:.deleteWordAction)

        }
        
        let actionEdit = UIContextualAction(style: .normal, title: "Change") { _,_,_ in
            let editWordScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EditWordController")  as EditController
            
            editWordScreen.word = self.wordCategory.wordList[indexPath.row]
            
            editWordScreen.commitAfterEdit = {[self] word in
                self.wordCategory.wordList[indexPath.row] = word as! Word
                tableView.reloadData()
            }
            
            self.navigationController?.pushViewController(editWordScreen , animated: true)
        }
        
        let actionBookmark = UIContextualAction(style: .normal, title: "Bookmark") { _,_,_ in
            
            let jsonCategory = CategoryWordStorage.loadJson(key: StorageConfiguration.savedCategoryKey)
            var loadedCategory = CategoryWords.instanceEmptySaved()
            
            if jsonCategory != nil {
                loadedCategory = CategoryWordJsonCoder.fromJson(wordCategoryJson: jsonCategory!)
            }
            
            if !loadedCategory.wordList.contains(self.wordCategory.wordList[indexPath.row]) {
                loadedCategory.wordList.append(self.wordCategory.wordList[indexPath.row])
            }
            
            // update category in storage and link storage
            CategoryWordStorage.saveJson(category: loadedCategory)
            self.savedCategoryButton.blink(duration: 0.4, repeatCount: 1)
        }
        
        

        
        actionEdit.backgroundColor = .darkGray
        actionEdit.image = .init(UIImage(systemName: "pencil")!)!
        
        
        actionDelete.image = .init(UIImage(systemName: "trash")!)!
        
        if self.wordCategory.id != StorageConfiguration.savedCategoryKey {
            actionBookmark.backgroundColor = .systemGreen
            actionBookmark.image = .init(UIImage(systemName: "bookmark")!)!
            return [actionEdit, actionBookmark, actionDelete]
        }
        
        return [actionEdit,actionDelete]
        
    }
    
    // set up actions for cell swipe LEADING
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // MARK: - trailing swipe
       
        let actions = UISwipeActionsConfiguration(actions:getActions(indexPath: indexPath))
        return actions
        
    }
    
    // MARK: - leading swipe
    // set up actions for cell swipe TRAILING
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("Определяем доступные действия для строки \(indexPath.row)")
    
        let actions = UISwipeActionsConfiguration(actions:getActions(indexPath: indexPath))

        return actions
    }
    
    // MARK: - Multiple selection

    
    @objc func removeSelectedItems(){
        let alertController = UIAlertController(title: "You can't undo this action", message: "Remove these words?", preferredStyle: .alert)
        alertController.addAction(.init(title: "Cancel", style: .cancel))
        
        alertController.addAction(.init(title: "Remove", style: .destructive, handler: {action in
            let selectedIndexes = self.tableView.indexPathsForSelectedRows
            
            self.setUpEditingDone()
            
            self.removeSelectedWords(selectedWords: selectedIndexes?.map({$0.item}) ?? [])
        }))
    
        self.present(alertController, animated: true)
    }
    
    private func removeSelectedWords(selectedWords: [Int]) {
        self.wordCategory.wordList = self.wordCategory.wordList
            .enumerated()
            .filter { !selectedWords.contains($0.offset) }
            .map { $0.element }
        self.tableView.reloadData()
    }
    
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {

        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            print("long press")
            self.tableView.isEditing = true
            self.setUpButtonsToEditing()

            let touchPoint = longPressGestureRecognizer.location(in: self.tableView)
        }
    }

    //// in view did load i have this
    
    func setUpLongPress(){
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    private func setUpButtonsToEditing(){
        self.toolbarItemsDefault = self.toolbar.items
        self.toolbar.setItems(setUpToolbarItemsWhileEditing(), animated: true)
    }
    
    @objc func selectAllItems(){
        
        let selected = self.tableView.indexPathsForSelectedRows
        
        let totalRows = self.tableView.numberOfRows(inSection: 0)
        
        if selected?.count == totalRows {
            for row in 0..<totalRows {
                self.tableView.deselectRow(at: .init(item: row, section: 0), animated: false)
            }
            
        } else {
            for row in 0..<totalRows {
                self.tableView.selectRow(at: .init(item: row, section: 0), animated: false, scrollPosition: .none)
            }
        }        
    }
    
    @objc func setUpEditingDone() {
        self.toolbar.setItems(toolbarItemsDefault, animated: true)
        self.tableView.isEditing = false
    }
    
    // MARK: - Word in cell selection and update current selected word
    
    // For single and multiple selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        _ = tableView.cellForRow(at: indexPath)
        
        // if table view is not editing
        if tableView.isEditing {
            return
        }
        
        if !wordCategory.wordList[indexPath.row].isLearned {
            // If current cell is not present in selectedIndexes
            wordLearner = WordLearner(word: wordCategory.wordList[indexPath.row])
            setUpCurrentWord()
        } else {
            let alertController = UIAlertController(title: "Already learned", message: "'\(wordCategory.wordList[indexPath.row].word)' is already learned", preferredStyle: .actionSheet)
            
            
            
            let createButton = UIAlertAction(title: "Learn Again", style: .default) { _ in
                // this didSet saving not have effVect because word learner created after saving
                self.wordCategory.wordList[indexPath.row].isLearned = false
                
                self.wordLearner = WordLearner(word: self.wordCategory.wordList[indexPath.row])
                self.setUpCurrentWord()
                // so we need to save learner after creating
                Storage.saveJson(
                    json: WordLearnerJsonCoder.toJson(self.wordLearner),
                    key: StorageConfiguration.learnerKey)
                
                self.tableView.reloadData()
            }
            
            let cancelButton = UIAlertAction(title: "Back", style: .cancel, handler: nil)
            
            alertController.addAction(createButton)
            alertController.addAction(cancelButton)
            
            self.present(alertController, animated: true)
        }
        Storage.saveJson(
            json: WordLearnerJsonCoder.toJson(self.wordLearner),
            key: StorageConfiguration.learnerKey)
        
    }
}

