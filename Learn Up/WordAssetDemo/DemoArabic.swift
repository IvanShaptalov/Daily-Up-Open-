//
//  WordAssetDemo.swift
//  Learn Up
//
//  Created by PowerMac on 17.01.2024.
//

import Foundation
class WordAssetDemoArabic: WordAssetProtocol {
    static var wordCategory = CategoryWords(title: "25 Arabic Words & Phrases Vol.1", language: .Arabic, id: "arabicDemo", wordList: loadWordList(), isPremium: false, assetPath: LearnUpConfiguration.baseCategoryAssetPath)
    
    static func loadWordList() -> [Word] {
        return [
            // MARK: - Здраствуйте
            Word(id: "528BC134-44D5-4334-A029-C0E1DB97BA50",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "السلام عليكم (As-salamu alaykum)",
         
                 translation: "",
             
                 meaning: "",
                  
                 pronunciation: "",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "السلام عليكم (As-salamu alaykum)",
                 meaningOrigin: "التحية أو تمنيات النجاح",
                 pronunciationOrigin: "[здр`аствуй'т'э]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Спасибо
            Word(id: "C55273C3-CB85-4E70-B894-ACE0725DDB96",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "شكرًا (Shukran)",
                 translation: "Thank you",
                 meaning: "expression of gratitude",
                 pronunciation: "[spəsʲɪ'bo]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "شكرًا (Shukran)",
                 meaningOrigin: "التعبير عن الامتنان أو الشكر",
                 pronunciationOrigin: "[спа-си́-бо]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Пожалуйста
            Word(id: "2E81E660-EB45-4299-BC3D-1FBBF0AC38BD",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "من فضلك (Min fadlak)",
                 translation: "Please",
                 meaning: "Polite expressions of address, request, response to gratitude",
                 pronunciation: "[ˌpliːzɡlædˈliː]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "من فضلك (Min fadlak)",
                 meaningOrigin: "التعبير عن الرغبة أو التأكيد على اللطف",
                 pronunciationOrigin: "[пажалуй’ста]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Простите
            Word(id: "1E8C1BB5-D296-42B0-877B-00E660741CAF",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "عذرًا (Athan)",
                 translation: "Excuse me",
                 meaning: "Regret for causing inconvenience, discomfort, or distress",
                 pronunciation: "[Prəˈstaɪt]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "عذرًا (Athan)",
                 meaningOrigin: "التعبير عن الاعتذار أو الندم",
                 pronunciationOrigin: "[изв’ин’ит’э]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Да
            Word(id: "EE08B5F3-8A30-41FA-9065-CA7B4B3F11BB",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "نعم (Na'am)",
                 translation: "Yes",
                 meaning: "Agreement with something",
                 pronunciation: "[dæ]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "نعم (Na'am)",
                 meaningOrigin: "إجابة إيجابية تعبر عن الموافقة أو التأكيد",
                 pronunciationOrigin: "[да]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Нет
            Word(id: "9A12A29A-5842-46E9-8B4A-397E4894E13F",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "لا (La)",
                 translation: "",
                 meaning: "Disagreement with something",
                 pronunciation: "[nɛt]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "لا (La)",
                 meaningOrigin: "إجابة سلبية تعبر عن الرفض",
                 pronunciationOrigin: "[н’эт]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Как дела?
            Word(id: "FAC41092-A1DC-4129-9FB4-AF2B0C2CD079",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "كيف حالك؟ (Kayfa halak?)",
                 translation: "How are you?",
                 meaning: "Greetings, inquiry about current state of affairs.",
                 pronunciation: "[kak dʲɪˈla]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "كيف حالك؟ (Kayfa halak?)",
                 meaningOrigin: "سؤال عن حالة الشخص",
                 pronunciationOrigin: "[к`ак д'ила]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Хорошо
            Word(id: "989D6AEE-BD35-4A75-BFA1-4B418C57BE8E",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "جيد (Jayyid)",
                 translation: "Good",
                 meaning: "As is customary, what is considered beautiful, correct.",
                 pronunciation: "[xɐˈroʂə.]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "جيد (Jayyid)",
                 meaningOrigin: "إجابة على السؤال عن الحالة للتعبير عن الراحة",
                 pronunciationOrigin: "[харашо]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Плохо
            Word(id: "80109E60-838D-45A7-97E6-8030907FE5CF",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "سيء (Sayyi')",
                 translation: "Bad",
                 meaning: "Appraisal or expression of dissatisfaction, disappointment",
                 pronunciation: "[ˈploxə]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "سيء (Sayyi')",
                 meaningOrigin: "إجابة على السؤال عن الحالة للتعبير عن عدم الراحة",
                 pronunciationOrigin: "[пл`оха]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Где это?
            Word(id: "BB85F13B-373B-4AE9-B787-4F5D18584F7D",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "أين هو؟ (Ayna huwa?)",
                 translation: "Where is this?",
                 meaning: "Request for the location or positioning of something.",
                 pronunciation: "[ɡdʲe ɛˈto]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "أين هو؟ (Ayna huwa?)",
                 meaningOrigin: "سؤال عن موقع شيء",
                 pronunciationOrigin: "[гд'э эта]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Сколько это стоит?
            Word(id: "C7C1215F-546A-4A98-8A63-6AA891BC865B",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: " كم يكلف هذا؟ (Kam yukallifu hadha?)",
                 translation: "How much does it cost?",
                 meaning: "Inquiry about the price of a specific product or service",
                 pronunciation: "[ˈskolʲkə ɛˈto stojɪt]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: " كم يكلف هذا؟ (Kam yukallifu hadha?)",
                 meaningOrigin: "سؤال عن سعر شيء",
                 pronunciationOrigin: "[ск`ол'ка эта стои́т]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Можно помочь?
            Word(id: "ACFBC464-D657-4E84-8F09-F0E99C6C4937",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: " هل يمكنني مساعدتك؟ (Hal yumkinuni musa'idatak?)",
                 translation: "Can you help?",
                 meaning: "Expression of readiness to provide assistance or support",
                 pronunciation: "[ˈmoʐnə pamɐʂˈtʲi.]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: " هل يمكنني مساعدتك؟ (Hal yumkinuni musa'idatak?)",
                 meaningOrigin: "عرض المساعدة أو سؤال عن احتياجات الشخص",
                 pronunciationOrigin: "[можна пам`оч']",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Я не понимаю
            Word(id: "E2794BD0-19E2-4130-8D36-88D473D70BD0",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: " لا أفهم (La afham)",
                 translation: "I don't understand",
                 meaning: "Expression of not understanding something.",
                 pronunciation: "[ja nʲɪ pɐnʲɪˈmaju]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: " لا أفهم (La afham)",
                 meaningOrigin: "التعبير عن عدم الفهم",
                 pronunciationOrigin: "[й'а́ н'э пан'имай'у]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Я говорю по-английски
            Word(id: "0EBB60FC-478D-46E5-9086-EACB7F7A5454",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "أنا أتحدث الإنجليزية (Ana atakallam al-Ingliiziyya)",
                 translation: "I speak English",
                 meaning: "The phrase means that you can speak English.",
                 pronunciation: "[ja ɡɐˈvorʊ pə ˈanɡlʲɪjskʲɪ]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "أنا أتحدث الإنجليزية (Ana atakallam al-Ingliiziyya) ",
                 meaningOrigin: "التأكيد على القدرة على التحدث بالإنجليزية",
                 pronunciationOrigin: "[й'а́ гавар'`у па англ'ийски]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Как вас зовут?
            Word(id: "160CBDE5-0C8A-45A1-8695-B9FE0981DE16",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: " ما اسمك؟ (Ma ismak?)",
                 translation: "What is your name?",
                 meaning: "The phrase represents a question about a person's name.",
                 pronunciation: "[kak vas zoˈvut]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: " ما اسمك؟ (Ma ismak?)",
                 meaningOrigin: "سؤال مهذب عن اسم الشخص",
                 pronunciationOrigin: "[к`ак вас завут]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Меня зовут...
            Word(id: "2790F4C0-CB76-4FDB-8574-2C01C63D2B63",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "اسمي (Ismi)",
                 translation: "My name is...",
                 meaning: "What is your name?",
                 pronunciation: "[mɛˈnʲa zoˈvut]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "اسمي (Ismi)",
                 meaningOrigin: "تقديم الاسم الخاص بالشخص",
                 pronunciationOrigin: "[м'ин'а завут]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Я голоден
            Word(id: "A2D45824-0B9C-4765-AAA1-578255486D80",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "أنا جائع (Ana ja'i)",
                 translation: "I'm hungry",
                 meaning: "Feeling of hunger",
                 pronunciation: "[ja ɡɐˈlodʲɪn]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "أنا جائع (Ana ja'i)",
                 meaningOrigin: "التعبير عن الجوع",
                 pronunciationOrigin: "[й'а г`олад'ин]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Я хочу пить
            Word(id: "153A2E04-FD49-4ED6-9351-916BA64D0299",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: " أريد أن أشرب (Uriidu an ashurab)",
                 translation: "I want to drink",
                 meaning: "Wish to drink",
                 pronunciation: "[ya khochu pit']",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: " أريد أن أشرب (Uriidu an ashurab)",
                 meaningOrigin: "التعبير عن الرغبة في شرب شيء",
                 pronunciationOrigin: "[й'а хач'`у п'`ит']",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: -  Где туалет?
            Word(id: "6A6BF232-00D0-43F8-BED7-E52F0B554DA5",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "أين دورة المياه؟ (Ayna dawrat al-ma)",
                 translation: "Where is the restroom?",
                 meaning: "Where toilet located",
                 pronunciation: "[gdye tualet]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "أين دورة المياه؟ (Ayna dawrat al-ma)",
                 meaningOrigin: "سؤال عن موقع الحمام",
                 pronunciationOrigin: "[гд'э туʌл❜э́т]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Сколько времени?
            Word(id: "71CDD6E8-192F-456C-B47A-50848892C199",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "كم الساعة؟ (Kam as-sa'a?)",
                 translation: "What time is it?",
                 meaning: "Current time?",
                 pronunciation: "[skol'ko vremeni]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "كم الساعة؟ (Kam as-sa'a?)",
                 meaningOrigin: "سؤال عن الوقت الحالي",
                 pronunciationOrigin: "[ск`ол'ка вр'эм'ин'и]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Я люблю тебя
            Word(id: "C720C705-B14F-4437-B3A7-DDDA945A0B03",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: " أنا أحبك (Ana uhibbuka)",
                 translation: "I love you",
                 meaning: "Possible expression of love",
                 pronunciation: "[ya lyublyu tebya]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: " أنا أحبك (Ana uhibbuka)",
                 meaningOrigin: "التعبير عن مشاعر الحب",
                 pronunciationOrigin: "[й'а л'убл'у т'иб'а́]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Какой прекрасный день!
            Word(id: "E130276F-A64D-4BA2-B5FD-2984C83566B3",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "يوم جميل (Yawm jameel)",
                 translation: "What a beautiful day!",
                 meaning: "Positive description of the day",
                 pronunciation: "[kakoy prekrasnyy den']",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "يوم جميل (Yawm jameel)",
                 meaningOrigin: "التعبير عن إعجاب بيوم جميل أو طقس جيد",
                 pronunciationOrigin: "[какой' пр'икрасный' д'эн']",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Удачи!
            Word(id: "A4963013-0742-4A44-ABEC-141B93C968B7",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "حظ سعيد (Hazz sa'id)",
                 translation: "Good luck!",
                 meaning: "Wishing Good luck",
                 pronunciation: "[udachi]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "حظ سعيد (Hazz sa'id)",
                 meaningOrigin: " تمنيات بالنجاح",
                 pronunciationOrigin: "[удач'и]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - Будьте здоровы (после чихания)
            Word(id: "2F69719C-E212-4B74-A4BA-EF514D3643A7",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "الله يسلمك (Allah yusalmak)",
                 translation: "Bless you! (after sneezing)",
                 meaning: "Wishing good health",
                 pronunciation: "[bud'te zdorovy]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "الله يسلمك (Allah yusalmak)",
                 meaningOrigin: "تمنيات بالصحة بعد العطس",
                 pronunciationOrigin: "[б`уд'т'э здаровы]",
                 languageLinkList: demoCategoriesLinkVol1),
            // MARK: - До свидания!
            Word(id: "2CEEA866-D1FD-4975-ADFC-0731D73E4021",
                 fromLang: .Arabic,
                 toLang: .English,
                 word: "وداعًا (Wada'an)",
                 translation: "Goodbye!",
                 meaning: "Farewell",
                 pronunciation: "[da svidaniya]",
                 trDate: Date.now,
                 isLearned: false,
                 translationOrigin: "وداعًا (Wada'an)",
                 meaningOrigin: "وداع، تعبير عن الرحيل أو الفراق",
                 pronunciationOrigin: "[дасв'идан'`ий'а]",
                 languageLinkList: demoCategoriesLinkVol1),
            
        ]
    }
}
