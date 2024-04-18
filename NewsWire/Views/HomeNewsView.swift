//
//  HomeNewsView.swift
//  NewsWire
//
//  Created by Simranjeet Kaur on 12/04/24.
//

import SwiftUI

struct HomeNewsView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State private var detailBtn = false
    @State private var indexCount = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                let details = viewModel.dataModel?.articles
                if detailBtn == false {
                    ForEach(1..<7) { index in
                        VStack {
                            Text(details![index].title)
                                .padding()
                            if let imagrURL = details![index].urlToImage, let url = URL(string: imagrURL) {
                                ImageView(url: url)
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .padding()
                            }
                            else {
                                Text("Image not available")
                                    .foregroundColor(.red)
                            }
                            Text(details![index].description)
                                .padding()
                            Button {
                                indexCount = index
                                detailBtn.toggle()
                                
                            } label: {
                                Text("Read More")
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 120, height: 30)
                            .background(Color.black)
                            .cornerRadius(15)
                            
                            Spacer()
                        }
                        .onAppear() {
                            viewModel.getData { (data, error) in
                                if error != nil {
                                   // error
                                }
                            }
                        }
                        .overlay (
                            Group {
                                if viewModel.dataModel == nil {
                                    ProgressView()
                                }
                            }
                        )
                    }
                }
                else {
                    NavigationLink(
                        destination: NewsDetailView(url: details![indexCount].url),
                        isActive: $detailBtn
                    ) {
                        Text("")
                    }
                }
            }
                .navigationTitle("Headlines")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeNewsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNewsView()
    }
}

