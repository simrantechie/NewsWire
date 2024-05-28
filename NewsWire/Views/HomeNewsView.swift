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
                if let details = viewModel.dataModel?.articles, !details.isEmpty {
                    if !detailBtn {
                        ForEach(1..<7) { index in
                            VStack {
                                Text(details[index].title!)
                                    .padding()
                                if let imagrURL = details[index].urlToImage, let url = URL(string: imagrURL) {
                                    ImageView(url: url)
                                        .frame(height: 200)
                                        .cornerRadius(10)
                                    .padding() }
                                else {
                                    Text("Image not available")
                                        .foregroundColor(.red)
                                }
                                Text(details[index].description!)
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
                        }
                    }
                    else {
                        NavigationLink(
                            destination: NewsDetailView(url: details[indexCount].url!),
                            isActive: $detailBtn
                        ) {
                            Text("")
                        }
                    }
                }
                else {
                    ProgressView()
                        .onAppear {
                            viewModel.getData { data, error in
                                print(error)
                            }
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
