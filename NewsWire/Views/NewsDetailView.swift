//
//  NewsDetailView.swift
//  NewsWire
//
//  Created by Simranjeet Kaur on 12/04/24.
//

import SwiftUI
import WebKit

struct NewsDetailView: View {
    @State var url: String
    var body: some View {
        NavigationView {
           WebView(urlString: url)
        }
        .navigationTitle("Webview")
        .navigationBarBackButtonHidden(false)
        
    }
}

struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

