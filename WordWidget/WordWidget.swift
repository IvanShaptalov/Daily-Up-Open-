import WidgetKit
import SwiftUI

struct WordWidget: Widget {
    let kind: String = "SimplestWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WordWidgetView(entry: entry).padding(.all
                                                 , 5)
        }
        .configurationDisplayName("Word Widget")
        .description("Glance").supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Provider: TimelineProvider {
    @AppStorage(StorageConfiguration.learnerKey, store: UserDefaults(suiteName: "group.wvantage"))
    var jsonData: String?
    
    func placeholder(in context: Context) -> WordWidgetEntry {
        WordWidgetEntry(date: Date(),word: LearnerLoader.loadWord(jsonWord: jsonData))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WordWidgetEntry) -> Void) {
        let entry = WordWidgetEntry(date: Date(),word: LearnerLoader.loadWord(jsonWord: jsonData))
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WordWidgetEntry>) -> Void) {
        let entry = WordWidgetEntry(date: Date(),word: LearnerLoader.loadWord(jsonWord: jsonData))
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct WordWidgetEntry: TimelineEntry {
    let date: Date
    let word: Word
}

struct WordWidgetView : View {
    @Environment(\.widgetFamily) var family
    
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            VStack (alignment: .leading) {
                Text("\(Languages.addFlag(word: entry.word.word, lang: entry.word.fromLang))").font(.subheadline).lineLimit(3)
                
                Divider()
                                            
                Text("\(entry.word.translation)").font(.footnote).lineLimit(5).foregroundColor(.gray)
                
                Spacer()
                    
            }
            
        case .systemMedium:
            VStack (alignment: .leading) {
                
                Text("\(Languages.addFlag(word: entry.word.word, lang: entry.word.fromLang))").font(.headline).lineLimit(3)
                
                Divider()
                            
                Text("\(Languages.addFlag(word: entry.word.translation, lang: entry.word.toLang))").font(.subheadline).lineLimit(3)
                
                Divider()

                Text("\(entry.word.meaning)").font(.footnote).lineLimit(5).foregroundColor(.gray)
                
                Spacer()
                
            }
            
      
           
        default:
            VStack (alignment: .leading) {
                
                Text("\(entry.word.word)").font(.subheadline).lineLimit(3)
                
                Divider()
                                            
                Text("\(entry.word.translation)").font(.footnote).lineLimit(5).foregroundColor(.gray)
                
            }
        }
    }
}


