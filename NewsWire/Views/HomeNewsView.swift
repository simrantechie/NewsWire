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
                let count = viewModel.dataModel?.articles.count ?? 0
                if detailBtn == false {
                    ForEach(1..<7) { index in
                        VStack {
                            Text(viewModel.dataModel?.articles[index].title ?? "")
                                .padding()
                            if let imagrURL = viewModel.dataModel?.articles[index].urlToImage, let url = URL(string: imagrURL) {
                                ImageView(url: url)
                                    .frame(height: 200)
                                    .cornerRadius(10)
                                    .padding()
                            }
                            else {
                                Text("Image not available")
                                    .foregroundColor(.red)
                            }
                            Text(viewModel.dataModel?.articles[index].description ?? "")
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
                                   print(error)
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
                    NavigationLink("", destination: NewsDetailView(url: viewModel.dataModel?.articles[indexCount].url ?? ""), isActive: $detailBtn)
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

