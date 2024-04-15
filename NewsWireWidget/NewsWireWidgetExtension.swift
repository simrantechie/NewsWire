//
//  NewsWireWidgetExtension.swift
//  NewsWireWidgetExtension
//
//  Created by Simranjeet Kaur on 12/04/24.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
   var viewModel = HomeViewModel()
    func placeholder(in context: Context) -> SampleEntry {
        SampleEntry(date: Date(), data: DataModel(articles: []))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SampleEntry) -> ()) {
        let entry = SampleEntry(date: Date(), data: DataModel(articles: [ArticlesModel(title: "White House Report Card: Inflation, Bidenomics choking the nation - Washington Examiner", description: "White House Report Card: Inflation, Bidenomics choking the nation - Washington Examiner Desc", url: "https://www.washingtonexaminer.com/news/washington-secrets/2965121/white-house-report-card-inflation-bidenomics-choking-the-nation/", urlToImage: "https://www.thestreet.com/.image/ar_1.91%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_1200/MjAxNTgyMzcwMTg3Mzg4Mjg5/taiwan-technology-foxconn-nvidia.jpg", publishedAt: "2024-04-13T13:17:27Z"), ArticlesModel(title: "White House Report Card: Inflation, Bidenomics choking the nation - Washington Examiner", description: "White House Report Card: Inflation, Bidenomics choking the nation - Washington Examiner Desc", url: "https://www.washingtonexaminer.com/news/washington-secrets/2965121/white-house-report-card-inflation-bidenomics-choking-the-nation/", urlToImage: "https://www.thestreet.com/.image/ar_1.91%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_1200/MjAxNTgyMzcwMTg3Mzg4Mjg5/taiwan-technology-foxconn-nvidia.jpg", publishedAt: "2024-04-13T13:17:27Z"), ArticlesModel(title: "White House Report Card: Inflation, Bidenomics choking the nation - Washington Examiner", description: "White House Report Card: Inflation, Bidenomics choking the nation - Washington Examiner Desc", url: "https://www.washingtonexaminer.com/news/washington-secrets/2965121/white-house-report-card-inflation-bidenomics-choking-the-nation/", urlToImage: "https://www.thestreet.com/.image/ar_1.91%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_1200/MjAxNTgyMzcwMTg3Mzg4Mjg5/taiwan-technology-foxconn-nvidia.jpg", publishedAt: "2024-04-13T13:17:27Z"), ArticlesModel(title: "White House Report Card: Inflation, Bidenomics choking the nation - Washington Examiner", description: "White House Report Card: Inflation, Bidenomics choking the nation - Washington Examiner Desc", url: "https://www.washingtonexaminer.com/news/washington-secrets/2965121/white-house-report-card-inflation-bidenomics-choking-the-nation/", urlToImage: "https://www.thestreet.com/.image/ar_1.91%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_1200/MjAxNTgyMzcwMTg3Mzg4Mjg5/taiwan-technology-foxconn-nvidia.jpg", publishedAt: "2024-04-13T13:17:27Z")]))
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        var entry: SampleEntry = SampleEntry(date: Date(), data: DataModel(articles: []))
        viewModel.getData { (data, error)  in
                entry = SampleEntry(date: Date(), data: data ?? DataModel(articles: []))
        }
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SampleEntry: TimelineEntry {
    var date: Date
    let data: DataModel
}

struct NewsWireWidgetExtensionEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily
    var body: some View {
        switch family {
        case .systemSmall:
            NewsWireSmallWidgetView()
        case .systemMedium:
            NewsWireMediumWidgetView(articles: entry.data.articles)
        case .systemLarge:
            NewsWireLargeWidgetView(articles: entry.data.articles)
        @unknown default:
            EmptyView()
        }
    }
}



struct NewsWireSmallWidgetView : View  {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Top News")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding(.leading, 8)
                Spacer()
                Image("Carouselheader_5")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20, alignment: .center)
                    .padding(.trailing, 5)
            }
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Jon Stewart Confirms Apple Wouldn't Let Him Do Show on AI With FTC Chair")
                        .font(.custom("Inter", size: 10))
                        .fontWeight(.semibold)
                        .padding(.leading, 8)
                    
                    Text("6 min ago")
                        .font(.custom("Inter", size: 10))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    
                }
                Spacer()
                ImageView(url: URL(string: "https://www.thestreet.com/.image/ar_1.91%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_1200/MjAxNTgyMzcwMTg3Mzg4Mjg5/taiwan-technology-foxconn-nvidia.jpg")!)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 80, alignment: .center)
                    .cornerRadius(8)
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
            }
            
        }
        .onAppear() {
        }
    }
}


struct NewsWireMediumWidgetView: View {
    @State var articles: [ArticlesModel]
    @StateObject var viewModel = HomeViewModel()
    
    let dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Top News")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding(.leading, 10)
                Spacer()
                Image("Carouselheader_5")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35, alignment: .center)
                    .padding(.trailing, 10)
            }
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(articles.first?.title ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.leading, 10)
                  
                    Text(getFormattedTime(from:articles.first?.publishedAt ?? ""))
                        .font(.custom("Inter", size: 10))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                    
                }
                Spacer()
                if let imagrURL = articles.first?.urlToImage, let url = URL(string: imagrURL) {
                    ImageView(url: url)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 60, alignment: .top)
                      //  .cornerRadius(5)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                }
                else {
                    ImageView(url: URL(string: "https://www.thestreet.com/.image/ar_1.91%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_1200/MjAxNTgyMzcwMTg3Mzg4Mjg5/taiwan-technology-foxconn-nvidia.jpg"))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 60, alignment: .top)
                      //  .cornerRadius(5)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                }
                
            }
            
        }
    }
    
    func getFormattedTime(from dateString: String) -> String {
        if let date = dateformatter.date(from: dateString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm:a"
            return timeFormatter.string(from: date)
        }
        else {
            return "Invalid Date"
        }
    }
    
}

struct NewsWireLargeWidgetView: View {
    @State var articles: [ArticlesModel]
    
    let dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Top News")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding(.leading, 10)
                Spacer()
                Image("Carouselheader_5")
                    .resizable()
                    .frame(width: 35, height: 35, alignment: .center)
                    .padding(.trailing, 10)
            }
            .padding(5)
            
            if articles.count != 0 {
                ForEach(1..<4) { index in
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(articles[index].title)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .padding(.leading, 10)
                            
                            Text(getFormattedTime(from: articles[index].publishedAt))
                                .font(.custom("Inter", size: 10))
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .padding(.leading, 10)
                            
                        }
                        Spacer()
                        if let imagrURL = articles[index].urlToImage, let url = URL(string: imagrURL) {
                            ImageView(url: url)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 60, alignment: .top)
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                        }
                        else {
                            ImageView(url: URL(string: "https://www.thestreet.com/.image/ar_1.91%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_1200/MjAxNTgyMzcwMTg3Mzg4Mjg5/taiwan-technology-foxconn-nvidia.jpg"))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 60, alignment: .top)
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                        }
                       
                    }
                    .padding(5)
                }
            }
        }
    }
    
    func getFormattedTime(from dateString: String) -> String {
        if let date = dateformatter.date(from: dateString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm:a"
            return timeFormatter.string(from: date)
        }
        else {
            return "Invalid Date"
        }
    }
}

struct NewsWireWidgetExtension: Widget {
    let kind: String = "NewsWireWidgetExtension"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            NewsWireWidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("Today")
        .description("Get today's headlines and news.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

//struct NewsWireWidgetExtension_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsWireWidgetExtensionEntryView(entry: SampleEntry(date: Date(), data: DataModel(status: "", totalResults: 2, articles: [])))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}

struct ImageView: View {
    let url: URL?
    
    var body: some View {
        if let url = url, let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
            
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        else {
            Image("apple")
        }
    }
}
