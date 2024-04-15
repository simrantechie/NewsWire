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
    @StateObject var viewModel = HomeViewModel()
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct NewsWireWidgetExtensionEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily
    var body: some View {
        switch family {
        case .systemSmall:
            NewsWireSmallWidgetView()
        case .systemMedium:
            NewsWireMediumWidgetView()
        case .systemLarge:
            NewsWireLargeWidgetView()
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
    @StateObject var viewModel = HomeViewModel()
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
                    Text(viewModel.dataModel?.articles.first?.title ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.leading, 10)
                    
                    Text("6 min ago")
                        .font(.custom("Inter", size: 10))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                    
                }
                Spacer()
                ImageView(url: URL(string: "https://www.thestreet.com/.image/ar_1.91%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_1200/MjAxNTgyMzcwMTg3Mzg4Mjg5/taiwan-technology-foxconn-nvidia.jpg")!)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 60, alignment: .top)
                  //  .cornerRadius(5)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            }
            
        }
        .onAppear() {
            viewModel.getData()
        }
        .overlay (
            Group {
//                if viewModel.dataModel == nil {
//                    ProgressView()
//                }
            }
        )
    }
}

struct NewsWireLargeWidgetView: View {
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
            
            ForEach(0..<3) {item in
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Jon Stewart Confirms Apple Wouldn't Let Him Do Show on AI With FTC Chair")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .padding(.leading, 10)
                        
                        Text("6 min ago")
                            .font(.custom("Inter", size: 10))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        
                    }
                    Spacer()
                    ImageView(url: URL(string: "https://www.thestreet.com/.image/ar_1.91%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_1200/MjAxNTgyMzcwMTg3Mzg4Mjg5/taiwan-technology-foxconn-nvidia.jpg")!)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 60, alignment: .top)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                }
                .padding(5)
            }
        }
    }
}

struct NewsWireWidgetExtension: Widget {
    let kind: String = "NewsWireWidgetExtension"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            NewsWireWidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("NewsWire Widget")
        .description("This is an NewsWire widget.")
      //  .supportedFamilies([.systemSmall])
    }
}

struct NewsWireWidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        NewsWireWidgetExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

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
