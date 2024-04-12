//
//  NewsDetailView.swift
//  NewsWire
//
//  Created by Simranjeet Kaur on 12/04/24.
//

import SwiftUI
import WebKit

struct NewsDetailView: View {
    
    var body: some View {
        NavigationView {
            Text("Webview")
        }
        .navigationTitle("Webview")
        
    }
}

//struct WebView: UIViewRepresentable {
//    let urlString: String
//
//    func makeUIView(context: Context) -> some UIView {
//        let webview = WKWebView()
//        return webview
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        if let url = URL(string: urlString) {
//            let request = URLRequest(url: url)
//            uiView.load(request)
//        }
//    }
//}

