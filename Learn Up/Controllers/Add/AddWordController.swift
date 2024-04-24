//
//  AddWordController.swift
//  Learn Up
//
//  Created by PowerMac on 26.12.2023.
//

import UIKit

class AddWordController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Creating Fields
    
    var word: Word?
    
    var addWordDelegate: ((WordProtocol?) -> Void)?
    
    @IBOutlet weak var FromLanguage: UIButton!
    
    @IBOutlet weak var ToLanguage: UIButton!
    
    @IBOutlet weak var textFieldWord: UITextField!
    
    @IBOutlet weak var textFieldTranslation: UITextField!
    
    @IBOutlet weak var textFieldMeaning: UITextField!
    
    @IBOutlet weak var textFieldPronunciation: UITextField!
    
    @IBOutlet weak var switchIsLearned: UISwitch!
    
    @IBOutlet weak var autoFillButton: UIButton!
    
    @IBOutlet weak var wordLoadingProgress: UIProgressView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        PulldownButton.setUpLanguages(button: &FromLanguage,buttonTitle: PulldownButtonType.fromLan)
        PulldownButton.setUpLanguages(button: &ToLanguage, buttonTitle: PulldownButtonType.toLan)
        setUpTextFieldDelegates()
        setUpAutofillButton()
        self.textFieldWord.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        wordLoadingProgress.setProgress(0, animated: false)
        
    }
    
    // MARK: - View did appeared
    override func viewDidAppear(_ animated: Bool) {
        setUpAutofillButton()
    }
    
    // MARK: - Autofill Button
    @IBAction func autofillDidTouch(_ sender: UIButton) {
        startAutoFill(self.textFieldWord)
    }
    
    func drawAutofillsLeft(){
        let leftAutofills = AutofillUpdateProvider.leftAutofills()
      
        autoFillButton.setTitle("\(leftAutofills)", for: .normal)
    }
    
    func setUpAutofillButton() {
        drawAutofillsLeft()
        if (self.textFieldWord.text != nil
            && !self.textFieldWord.text!.isEmpty) {
            autoFillButton.setImage(.init(UIImage(systemName: "character.book.closed.fill.ko")!)!, for: .normal)
        } else {
            autoFillButton.setImage(.init(UIImage(systemName: "bubbles.and.sparkles.fill")!)!, for: .normal)
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        setUpAutofillButton()
    }
    
    // MARK: - Progress imitation
    private func imitateProgress(){
        
        self.wordLoadingProgress.setProgress(0, animated: false)
        for i in 1...5{
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.5) {
                if self.wordLoadingProgress.progress <= 0.25*Float(i) {
                    self.wordLoadingProgress.setProgress(0.25*Float(i), animated: true)
                }
            }
            
            
        }
    }
    
    private var oldWordRequest: WordFillerRequest?
    
    // MARK: - Autofill process
    private func startAutoFill(_ sender: UITextField) {
        if (sender.text != nil && !sender.text!.isEmpty) {
            // if out of autofills and it is premium account
            if AutofillUpdateProvider.leftAutofills() <= 0 && MonetizationConfiguration.isPremiumAccount {
                let limiter = UIAlertController(title: "Out of autofills for today", message: "New autofills will appear tomorrow", preferredStyle: .alert)
                limiter.addAction(.init(title: "OK", style: .default))
                                                
                self.present(limiter, animated: true)
                return
            }
            // if out of autofills and it is not premium account, promote
            else if AutofillUpdateProvider.leftAutofills() <= 0 && !MonetizationConfiguration.isPremiumAccount {
                let paywallScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PaywallScreen")
                
                self.navigationController?.pushViewController(paywallScreen , animated: true)
                return
            }
            
            imitateProgress()
            
            // check limit
            
            let request = WordFillerRequest(word: sender.text!, toLang: Languages(rawValue: Languages.removeEmoji(lang:ToLanguage.titleLabel?.text))!, fromLang: Languages(rawValue: Languages.removeEmoji(lang:FromLanguage.titleLabel?.text))!)
            
            NSLog("request: \(request.word)")
            oldWordRequest = request
            self.autoFillButton.isEnabled = false
            WordFiller.fillWord(request, fillerCompletion: {response in
                DispatchQueue.main.async {
                    self.updateFields(response: response)
                    self.autoFillButton.isEnabled = true
                    self.wordLoadingProgress.setProgress(1, animated: true)
                    if response.meaning != LearnUpConfiguration.autofillPlaceholder{
                        let _ = AutofillUpdateProvider.saveAutofill()
                    }
                    self.drawAutofillsLeft()
                }
                NSLog("auto fill completed: \(response.meaning)")
            })
            
            
        } else {
            
            self.autoFillButton.isEnabled = true
            self.wordLoadingProgress.setProgress(0, animated: true)
            
            
            self.updateFields(response: WordFillerResponse(pronunciation: "", translation: "", meaning: ""))
        }
        AnalyticsManager.shared.logEvent(eventType: .autofillWord)

    }
    
    
    
    
    private func updateFields(response: WordFillerResponseProtocol){
        self.textFieldTranslation.text = response.translation
        self.textFieldMeaning.text = response.meaning
        self.textFieldPronunciation.text = response.pronunciation
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - Validating fields
    private func setUpTextFieldDelegates(){
        self.textFieldWord.delegate = self
        self.textFieldTranslation.delegate = self
        self.textFieldPronunciation.delegate = self
        self.textFieldMeaning.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = 35
        
        if textField == self.textFieldMeaning {
            maxLength = 80
        }
        let currentString: NSString = (textField.text ?? "") as NSString
        var newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        // nessesary to delete, because it used for parsing
        newString = newString.replacingOccurrences(of: "|", with: "") as NSString
        newString = newString.replacingOccurrences(of: ":", with: "") as NSString
        
        if (newString.length >= maxLength){
            newString = newString.substring(to: maxLength-1) as NSString
            textField.text = String(newString)
        }
        
        
        return newString.length <= maxLength
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return he number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    // MARK: - Add Word Function
    
    @IBAction func addWord(_ sender: Any) {
        
        let word = textFieldWord.text
        
        let translation = textFieldTranslation.text
        
        let meaning = textFieldMeaning.text
        
        let pronunciation = textFieldPronunciation.text
        
        let isLearned = switchIsLearned.isOn
        
        let fromLang = Languages.removeEmoji(lang:FromLanguage.titleLabel?.text)
        
        let toLang = Languages.removeEmoji(lang:ToLanguage.titleLabel?.text)
        
        // Validating
        
        let validator = WordValidator(fromL:Languages(rawValue: fromLang.lowercased() ),
                                      toL: Languages(rawValue: toLang.lowercased() ),
                                      word: word,
                                      translation: translation,
                                      meaning: meaning,
                                      pronunciation: pronunciation,
                                      trDate: Date.now,
                                      isLearned: isLearned,
                                      id: UUID().uuidString
        )
        let validatedWord: (String, WordProtocol?) = validator.validate()
        
        
        if validator.isValid {
            addWordDelegate!(validatedWord.1)
            self.navigationController?.popViewController(animated: true)
            if WordCounter.wordCount >= 5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        RateProvider.rateAppImplicit(view: self.view)
                }
            }
            
        } else {
            showFieldIssues(issue: validatedWord.0)
        }
        AnalyticsManager.shared.logEvent(eventType: .addWordAction)

    }
    
}


// MARK: - Field Word Validation
extension AddWordController{
    
    private func showFieldIssues(issue: String){
        if issue == WordValidator.wordError {
            textFieldWord.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
            
        }
        if issue == WordValidator.translationError {
            textFieldTranslation.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 3, revert: true)
        }
    }
    
}


