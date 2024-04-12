//
//  ImageView.swift
//  NewsWire
//
//  Created by Simranjeet Kaur on 12/04/24.
//

import SwiftUI

struct ImageView: View {
    @State private var image: Image?
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFit()
        }
        else {
            ProgressView()
            .onAppear {
                downloadImage()
                
            }
        }
    }
    
    private func downloadImage() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = Image(uiImage: UIImage(data: data)!)
                }
            }
            
        }.resume()
    }
}

