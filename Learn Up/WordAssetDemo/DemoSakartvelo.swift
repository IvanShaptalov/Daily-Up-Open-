//
//  WordAssetDemo.swift
//  Learn Up
//
//  Created by PowerMac on 17.01.2024.
//

import Foundation

class WordAssetDemoSakartvelo: WordAssetProtocol {
    static var wordCategory = CategoryWords(title: "25 Sakartvelo Words & Phrases Vol.1", language: .Georgian, id: "sakartveloDemo", wordList: loadWordList(), isPremium: false, assetPath: LearnUpConfiguration.baseCategoryAssetPath)
    
    static func loadWordList() -> [Word] {
        return [
            // MARK: - Здраствуйте
            Word(id: "528BC134-44D5-4334-A029-C0E1DB97BA50",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "გამარჯობა (gamarjoba)",
         
                 translation: "",
             
                 meaning: "",
                  
                 pronunciation: "",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "გამარჯობა (gamarjoba)",
                 meaningOrigin: "ფორმალური მისალმება, როგორც წესი, გამოიყენება პირველად შეხვედრისას ან უცხო ადამიანებთან ურთიერთობისას",
                 pronunciationOrigin: "[здр`аствуй'т'э]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Спасибо
            Word(id: "C55273C3-CB85-4E70-B894-ACE0725DDB96",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "მადლობა (madloba)",
                 translation: "Thank you",
                 meaning: "expression of gratitude",
                 pronunciation: "[spəsʲɪ'bo]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "მადლობა (madloba)",
                 meaningOrigin: "მადლიერების გამოხატვა",
                 pronunciationOrigin: "[спа-си́-бо]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Пожалуйста
            Word(id: "2E81E660-EB45-4299-BC3D-1FBBF0AC38BD",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "გთხოვ (gtkhova)",
                 translation: "Please",
                 meaning: "Polite expressions of address, request, response to gratitude",
                 pronunciation: "[ˌpliːzɡlædˈliː]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "გთხოვ (gtkhova)",
                 meaningOrigin: "თავაზიანი მიმართვის, თხოვნის, მადლიერების პასუხის გამოხატვა",
                 pronunciationOrigin: "[пажалуй’ста]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Простите
            Word(id: "1E8C1BB5-D296-42B0-877B-00E660741CAF",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: " შემეცადე (shemecade)",
                 translation: "Excuse me",
                 meaning: "სინანული უხერხულობის, დისკომფორტის ან დისკომფორტის გამოწვევისთვის",
                 pronunciation: "[Prəˈstaɪt]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: " შემეცადე (shemecade)",
                 meaningOrigin: "სინანული გამოწვეული არეულობის, უხერხულობის, უბედურების გამო",
                 pronunciationOrigin: "[изв’ин’ит’э]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Да
            Word(id: "EE08B5F3-8A30-41FA-9065-CA7B4B3F11BB",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "დიახ (diax)",
                 translation: "Yes",
                 meaning: "Agreement with something",
                 pronunciation: "[dæ]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "დიახ (diax)",
                 meaningOrigin: "რაღაცაზე თანხმობა",
                 pronunciationOrigin: "[да]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Нет
            Word(id: "9A12A29A-5842-46E9-8B4A-397E4894E13F",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "არა (ara)",
                 translation: "",
                 meaning: "Disagreement with something",
                 pronunciation: "[nɛt]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "არა (ara)",
                 meaningOrigin: "რაღაცას არ ეთანხმება",
                 pronunciationOrigin: "[н’эт]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Как дела?
            Word(id: "FAC41092-A1DC-4129-9FB4-AF2B0C2CD079",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "როგორ ხარ? (rogor khar)",
                 translation: "How are you?",
                 meaning: "Greetings, inquiry about current state of affairs.",
                 pronunciation: "[kak dʲɪˈla]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "როგორ ხარ? (rogor khar)",
                 meaningOrigin: "მისალმება, კითხვა საქმის მიმდინარე მდგომარეობის შესახებ",
                 pronunciationOrigin: "[к`ак д'ила]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Хорошо
            Word(id: "989D6AEE-BD35-4A75-BFA1-4B418C57BE8E",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "კარგად (kargad)",
                 translation: "Good",
                 meaning: "As is customary, what is considered beautiful, correct.",
                 pronunciation: "[xɐˈroʂə.]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "კარგად (kargad)",
                 meaningOrigin: "როგორც უნდა იყოს, რაც ლამაზად ითვლება, სწორია",
                 pronunciationOrigin: "[харашо]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Плохо
            Word(id: "80109E60-838D-45A7-97E6-8030907FE5CF",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: " ცუდად (ts'udad)",
                 translation: "Bad",
                 meaning: "უკმაყოფილების შეფასება ან გამოხატვა, იმედგაცრუება",
                 pronunciation: "[ˈploxə]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: " ცუდად (ts'udad)",
                 meaningOrigin: "უკმაყოფილების, იმედგაცრუების შეფასება ან გამოხატვა",
                 pronunciationOrigin: "[пл`оха]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Где это?
            Word(id: "BB85F13B-373B-4AE9-B787-4F5D18584F7D",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "სად იგივეა? (sad igoivea?)",
                 translation: "Where is this?",
                 meaning: "Request for the location or positioning of something.",
                 pronunciation: "[ɡdʲe ɛˈto]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "სად იგივეა? (sad igoivea?)",
                 meaningOrigin: "რაიმეს ადგილმდებარეობის ან ადგილმდებარეობის მოთხოვნა",
                 pronunciationOrigin: "[гд'э эта]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Сколько это стоит?
            Word(id: "C7C1215F-546A-4A98-8A63-6AA891BC865B",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "რამდენი კოშკია? (ramdeni koshkia?)",
                 translation: "How much does it cost?",
                 meaning: "Inquiry about the price of a specific product or service",
                 pronunciation: "[ˈskolʲkə ɛˈto stojɪt]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "რამდენი კოშკია? (ramdeni koshkia?)",
                 meaningOrigin: "მოითხოვეთ ფასი ნებისმიერი პროდუქტის ან მომსახურებისთვის",
                 pronunciationOrigin: "[ск`ол'ка эта стои́т]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Можно помочь?
            Word(id: "ACFBC464-D657-4E84-8F09-F0E99C6C4937",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "შემიძლია დაგეხმარო? (shemidzlia daqexmaro?)",
                 translation: "Can you help?",
                 meaning: "Expression of readiness to provide assistance or support",
                 pronunciation: "[ˈmoʐnə pamɐʂˈtʲi.]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "შემიძლია დაგეხმარო? (shemidzlia daqexmaro?)",
                 meaningOrigin: "დახმარების ან მხარდაჭერისთვის მზადყოფნის გამოხატვა",
                 pronunciationOrigin: "[можна пам`оч']",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Я не понимаю
            Word(id: "E2794BD0-19E2-4130-8D36-88D473D70BD0",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "არ გამეჭირდება (ar gametshirda)",
                 translation: "I don't understand",
                 meaning: "Expression of not understanding something.",
                 pronunciation: "[ja nʲɪ pɐnʲɪˈmaju]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "არ გამეჭირდება (ar gametshirda)",
                 meaningOrigin: "იმის გამოხატვა, რომ მოსაუბრეს რაღაც არ ესმის",
                 pronunciationOrigin: "[й'а́ н'э пан'имай'у]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Я говорю по-английски
            Word(id: "0EBB60FC-478D-46E5-9086-EACB7F7A5454",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "მე ლათინურს ვლოცავ (me latinurs vlocsav)",
                 translation: "I speak English",
                 meaning: "The phrase means that you can speak English.",
                 pronunciation: "[ja ɡɐˈvorʊ pə ˈanɡlʲɪjskʲɪ]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "მე ლათინურს ვლოცავ (me latinurs vlocsav)",
                 meaningOrigin: "ეს ფრაზა ნიშნავს, რომ თქვენ შეგიძლიათ ინგლისურად ისაუბროთ",
                 pronunciationOrigin: "[й'а́ гавар'`у па англ'ийски]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Как вас зовут?
            Word(id: "160CBDE5-0C8A-45A1-8695-B9FE0981DE16",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "რა გქვია? (ra gkvia?)",
                 translation: "What is your name?",
                 meaning: "The phrase represents a question about a person's name.",
                 pronunciation: "[kak vas zoˈvut]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "რა გქვია? (ra gkvia?)",
                 meaningOrigin: "ფრაზა წარმოადგენს კითხვას ადამიანის სახელის შესახებ",
                 pronunciationOrigin: "[к`ак вас завут]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Меня зовут...
            Word(id: "2790F4C0-CB76-4FDB-8574-2C01C63D2B63",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "მე მქვია (me mkvia)",
                 translation: "My name is...",
                 meaning: "What is your name?",
                 pronunciation: "[mɛˈnʲa zoˈvut]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "მე მქვია (me mkvia)",
                 meaningOrigin: "მითხარი რა გქვია",
                 pronunciationOrigin: "[м'ин'а завут]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Я голоден
            Word(id: "A2D45824-0B9C-4765-AAA1-578255486D80",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "მე შამბირივია (me shambirivia)",
                 translation: "I'm hungry",
                 meaning: "Feeling of hunger",
                 pronunciation: "[ja ɡɐˈlodʲɪn]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "მე შამბირივია (me shambirivia)",
                 meaningOrigin: "შიმშილის გრძნობა",
                 pronunciationOrigin: "[й'а г`олад'ин]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Я хочу пить
            Word(id: "153A2E04-FD49-4ED6-9351-916BA64D0299",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "მე მინდა სვალი (me minda svali)",
                 translation: "I want to drink",
                 meaning: "Wish to drink",
                 pronunciation: "[ya khochu pit']",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "მე მინდა სვალი (me minda svali)",
                 meaningOrigin: "დალევის სურვილი",
                 pronunciationOrigin: "[й'а хач'`у п'`ит']",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: -  Где туалет?
            Word(id: "6A6BF232-00D0-43F8-BED7-E52F0B554DA5",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "სად არის ბუნდუკი? (sad aris bunduki?)",
                 translation: "Where is the restroom?",
                 meaning: "Where toilet located",
                 pronunciation: "[gdye tualet]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "სად არის ბუნდუკი? (sad aris bunduki?)",
                 meaningOrigin: "კითხვა ტუალეტის ადგილმდებარეობის შესახებ",
                 pronunciationOrigin: "[гд'э туʌл❜э́т]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Сколько времени?
            Word(id: "71CDD6E8-192F-456C-B47A-50848892C199",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "რა საათია? (ra saati?)",
                 translation: "What time is it?",
                 meaning: "Current time?",
                 pronunciation: "[skol'ko vremeni]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "რა საათია? (ra saati?)",
                 meaningOrigin: "კითხვა მიმდინარე დროის შესახებ",
                 pronunciationOrigin: "[ск`ол'ка вр'эм'ин'и]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Я люблю тебя
            Word(id: "C720C705-B14F-4437-B3A7-DDDA945A0B03",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "მიყვარხარ (miqvarxar)",
                 translation: "I love you",
                 meaning: "Possible expression of love",
                 pronunciation: "[ya lyublyu tebya]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "მიყვარხარ (miqvarxar)",
                 meaningOrigin: "სიყვარულის შესაძლო გამოხატვა",
                 pronunciationOrigin: "[й'а л'убл'у т'иб'а́]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Какой прекрасный день!
            Word(id: "E130276F-A64D-4BA2-B5FD-2984C83566B3",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "რა კარგი დღე! (ra kargi dge)",
                 translation: "What a beautiful day!",
                 meaning: "Positive description of the day",
                 pronunciation: "[kakoy prekrasnyy den']",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "რა კარგი დღე! (ra kargi dge)",
                 meaningOrigin: "დღის დადებითი აღწერა",
                 pronunciationOrigin: "[какой' пр'икрасный' д'эн']",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Удачи!
            Word(id: "A4963013-0742-4A44-ABEC-141B93C968B7",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "გილოცავ (gilocav)",
                 translation: "Good luck!",
                 meaning: "Wishing Good luck",
                 pronunciation: "[udachi]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "გილოცავ (gilocav)",
                 meaningOrigin: "წარმატებებს გისურვებთ",
                 pronunciationOrigin: "[удач'и]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Будьте здоровы (после чихания)
            Word(id: "2F69719C-E212-4B74-A4BA-EF514D3643A7",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "ჯოჯორი (joojori)",
                 translation: "Bless you! (after sneezing)",
                 meaning: "Wishing good health",
                 pronunciation: "[bud'te zdorovy]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "ჯოჯორი (joojori)",
                 meaningOrigin: "ჯანმრთელობას უსურვებ ადამიანს, ვინც ცემინება",
                 pronunciationOrigin: "[б`уд'т'э здаровы]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - До свидания!
            Word(id: "2CEEA866-D1FD-4975-ADFC-0731D73E4021",
                 fromLang: .Georgian,
                 toLang: .English,
                 word: "ნახვამდის (nakhvamdis)",
                 translation: "Goodbye!",
                 meaning: "Farewell",
                 pronunciation: "[da svidaniya]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "ნახვამდის (nakhvamdis)",
                 meaningOrigin: "განშორება",
                 pronunciationOrigin: "[дасв'идан'`ий'а]",
                 languageLinkList: demoCategoriesLinkVol1),
            
        ]
    }
}
