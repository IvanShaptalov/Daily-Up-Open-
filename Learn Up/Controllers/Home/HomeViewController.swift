//
//  ViewController.swift
//  Learn Up
//
//  Created by PowerMac on 23.12.2023.
//

import UIKit
import WidgetKit



class HomeViewController: UIViewController {
    private var selectedCellIndex: Int = 0
    
    @IBOutlet weak var daystreak: UIButton!
    
    @IBOutlet weak var homeTitle: UINavigationItem!
    
    @IBOutlet weak var viewCard: UIView!
    
    @IBOutlet weak var currentWordLabel: UILabel!
    
    @IBOutlet weak var currentTranslationLabel: UILabel!
    
    @IBOutlet weak var currentPronunciationLabel: UILabel!
    
    @IBOutlet weak var currentMeaningLabel: UILabel!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    var toolbarItemsDefault: [UIBarButtonItem]?
        
    @IBOutlet weak var savedCategoryButton: UIButton!
    
    func setUpToolbarItemsWhileEditing() -> [UIBarButtonItem]{
        let flex = UIBarButtonItem.flexibleSpace()
        let selectAll = UIBarButtonItem(image: UIImage(systemName: "checklist"), style: .plain, target: self, action: #selector(selectAllItems))
        
        let deleteButton = UIBarButtonItem(image: .init(systemName: "trash"), style: .plain, target: self, action: #selector(removeSelectedItems))
        
        let done = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.circle"), style: .done, target: self, action: #selector(setUpEditingDone))
        return [selectAll, deleteButton,flex, done]
    }

    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func wordTTS(_ sender: UIButton) {
        var text: String?
        text = wordLearner?.word.word
        
        TTSProvider.voiceOver(text ?? currentWordLabel.text, lang: wordLearner?.word.fromLang ?? .English)
    }
    
    @IBAction func translationTTS(_ sender: UIButton) {
        var text: String?
        text = wordLearner?.word.translation
        
        TTSProvider.voiceOver(text ?? currentTranslationLabel.text, lang: wordLearner?.word.toLang ?? .English)
    }
    
    private var allLearnedOrEmpty: Bool = false
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadWordCategory()
        setUpViewCard(viewCard: &viewCard)
        setUpCurrentWord()
        // if first launch
        openTutorialWidget()
        updateLearnProgress()
        // day streak
        updateDayStreak(
            sender:self.daystreak,
            incrementDay: false)
        
        // set button unclickable
        self.daystreak.isUserInteractionEnabled = false
        // long press to table
        setUpLongPress()
    }
    
    
    // MARK: - Day streak updating
    private func updateDayStreak(sender: UIButton,incrementDay: Bool) {
        print(sender.titleLabel?.text ?? "nil")
        
        let day = DayStreakUpdateProvider.dayStreak
        let im: UIImage?
       
        if (day.count >= 7){
            im = UIImage(systemName: "flame.fill")
        } else {
            im = UIImage(systemName: "flame")
        }
        sender.setImage(im, for: .normal)

        sender.setPreferredSymbolConfiguration(sender.preferredSymbolConfigurationForImage(in: .normal), forImageIn: .normal)
        NSLog("update daystreak: \(day.created)")
        sender.setTitle("\(day.count)", for: .normal)
    }

    // MARK: - Category Buttons
    
    @IBAction func savedCategoryPressed(_ sender: UIButton) {
        let jsonCategory = CategoryWordStorage.loadJson(key: StorageConfiguration.savedCategoryKey)
        var loadedCategory = CategoryWords.instanceEmptySaved()
        if jsonCategory != nil {
            loadedCategory = CategoryWordJsonCoder.fromJson(wordCategoryJson: jsonCategory!)
        }
        self.wordCategory = loadedCategory
        self.tableView.reloadData()
        NSLog("HomeViewController > func savedCategoryPressed > category loaded: \(loadedCategory)")
    }
    
    //MARK: - viewCard layer
    private func setUpViewCard(viewCard: inout UIView){
        viewCard.layer.cornerRadius = 10
    }
    
    /// opens tutorial if it is first launch
    func openTutorialWidget(){
        if !LearnUpConfiguration.launchedEarlier {
            let tutorialPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TutorialWidgetController")  as UIViewController
            

            self.navigationController?.pushViewController(tutorialPage , animated: true)
        }
    }
    
    // MARK: - Learn word progress
    
    @IBOutlet weak var nextWordButton: UIButton!
    
    @IBOutlet weak var learnWordProgress: UIProgressView!
    
    private func updateLearnProgress(){
        let wordCount: Float = Float(self.wordCategory.wordList.count)
        
        var learnedWords: Float = 0
        
        
        self.wordCategory.wordList.forEach({
            
            learnedWords += $0.isLearned ? 1 : 0 })
        
        
        var progress: Float = 0
        
        // set progress if any words learned, else 0
        if learnedWords > 0 && wordCount > 0 {
            progress = Float(learnedWords / wordCount)
        }
        
        
        
        learnWordProgress.setProgress(progress, animated: true)
        
        if progress == 1 {
            nextWordButton.setImage(.init(UIImage(systemName: "checkmark.seal.fill")!)!, for: .normal)
        } else {
            nextWordButton.setImage(.init(UIImage(systemName: "checkmark.circle")!)!, for: .normal)
        }
    }
    
    // MARK: - learn next word
    
    static var learnedPerSession = 0
    
    private func nextWord(){
        updateDayStreak(sender: self.daystreak ,incrementDay: true)
        
        HomeViewController.learnedPerSession += 1
        if self.wordLearner != nil {
            let index = self.wordCategory.wordList.firstIndex(where: {$0.id == self.wordLearner?.wordId})
            if index != nil {
                self.wordCategory.wordList[index!].isLearned = true
            }
        }
        self.setUpCurrentWord()
        self.tableView.reloadData()
        
        if self.wordLearner == nil{
            let alert = UIAlertController(title: "All Done 🎉", message: "You learned all words!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                //                if HomeViewController.learnedPerSession >= LearnUpConfiguration.rateAfterLearnedWords {
                RateProvider.rateAppImplicit(view: self.view)
                //                }
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func learnNextWord(_ sender: Any) {
        self.nextWord()
        AnalyticsManager.shared.logEvent(eventType:.wordLearned)
    }
    
    // MARK: - Set up word and save learner
    
    func setUpCurrentWord(){
        
        let instructions: [String] = WordSelector.setUpWord(words: self.wordCategory.wordList, wordLearner: &self.wordLearner)
        
        currentWordLabel.text = instructions[0]
        currentTranslationLabel.text = instructions[1]
        currentPronunciationLabel.text = "/\(instructions[2])/"
        currentMeaningLabel.text = instructions[3]
        saveLearnerReloadWidget()
        
    }
    
    private func saveLearnerReloadWidget(){
        NSLog("learner saved \(wordLearner?.wordId ?? "as nil")")
        
        Storage.saveJson(
            json: WordLearnerJsonCoder.toJson(self.wordLearner),
            key: StorageConfiguration.learnerKey)
        
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    
    private var oldWordCount = 0
    
    public var wordLearner: WordLearner?
    
    // MARK: - wordCategory Watcher
    public var wordCategory : CategoryWords = CategoryWords.instanceEmptySaved()
    {
        didSet {
            // sort because new words =ed, not sort if only edit
            if (oldWordCount != wordCategory.wordList.count){
                self.wordCategory.wordList.sort{$0.trDate < $1.trDate}
                
                oldWordCount = wordCategory.wordList.count
            } 
            // update category in storage and link storage
            CategoryWordStorage.saveJson(category: self.wordCategory)
            
            // set category as selected
            SelectedCategoryStorage.saveLink(categoryId: self.wordCategory.id)
            
            self.setUpCurrentWord()
            self.updateLearnProgress()
            
            WordCounter.wordCount = wordCategory.wordList.count
        }
    }
    
}

// MARK: - Data source loading
extension HomeViewController {
    private func loadLearner() {
        let jsonLearner = Storage.loadJson(key: StorageConfiguration.learnerKey)
        if jsonLearner != nil {
            wordLearner = WordLearnerJsonCoder.fromJson(learnerJson: jsonLearner!)
        }
    }
    
    func loadWordCategory(){
        // load selected category
        var category: CategoryWords = CategorySelector.setUpWordCategory()
        //        var loadedCategoryList: [WordCategory] = []
        //
        //        let wordCategoryListJson = Storage.loadJson(key: StorageConfiguration.wordCategoryListKey)
        //        if wordCategoryListJson != nil {
        //            loadedCategoryList = WordCategoryListCoder.fromJson(wordListJson: wordCategoryListJson!)
        //        }
        //
        //        // set up here
        //
        //
        //
        if !LearnUpConfiguration.launchedEarlier {
            NSLog("it`s first launch")
            
            if !category.wordList.contains(where: {$0.word == "tap to learn"}) {
                category.wordList.append(
                    Word(
                        id: UUID().uuidString,
                        fromLang: Languages.English,
                        toLang: Languages.Ukrainian,
                        word: "tap to learn",
                        translation: "👆 🧐",
                        meaning: "swipe right to change word",
                        pronunciation: "tæp tuː lɜrn",
                        trDate: Date.now,
                        isLearned: true)
                )
            }
            if !category.wordList.contains(where: {$0.word == "swipe right"}){
                category.wordList.append(
                    Word(
                        id: UUID().uuidString,
                        fromLang: Languages.English,
                        toLang: Languages.Ukrainian,
                        word: "swipe right",
                        translation: "👉 ✍️",
                        meaning: "swipe right to edit word",
                        pronunciation: "swaɪp raɪt",
                        trDate: Date.now,
                        isLearned: false)
                )
            }
            
            if !category.wordList.contains(where: {$0.word == "Courage"}){
                category.wordList.append(
                    Word(
                        id: UUID().uuidString,
                        fromLang: Languages.French,
                        toLang: Languages.English,
                        word: "Courage",
                        translation: "courage",
                        meaning: "the ability to do something that frightens one; bravery",
                        pronunciation: "kərij",
                        trDate: Date.now,
                        isLearned: false)
                )
                
            }
            
            
        } else {
            
            NSLog("not first launch")
        }
        
        // MARK: - important to load learner before words, because when words set, any change update learner, and as a result learner become first unlearned word in words list
        loadLearner()
        self.wordCategory = category
        NSLog("words loaded :\(wordCategory.wordList.count)")
        let oldWords = loadOldWords()
        wordCategory.wordList.append(contentsOf: oldWords)
    }
    /// load old words from v1
    private func loadOldWords() -> [Word] {
        let wordListJson = Storage.loadJson(key: StorageConfiguration.wordsKey)
        if wordListJson != nil {
            let words = WordListJsonCoder.fromJson(wordListJson: wordListJson!)
            if !words.isEmpty {
                NSLog("LOAD OLD WORDS V1|words loaded :\(words.count)")
                Storage.saveJson(json: WordListJsonCoder.toJson([]), key: StorageConfiguration.wordsKey)
                return words
            }
        }
        return []
    }
}




