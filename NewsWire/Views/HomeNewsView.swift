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
    
    var body: some View {
       NavigationView {
            VStack {
                Text(viewModel.dataModel?.articles.first?.title ?? "")
                    .padding()
                ImageView(url: URL(string: "https://www.thestreet.com/.image/ar_1.91%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cg_faces:center%2Cq_auto:good%2Cw_1200/MjAxNTgyMzcwMTg3Mzg4Mjg5/taiwan-technology-foxconn-nvidia.jpg")!)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding()
                    
                Text(viewModel.dataModel?.articles.first?.description ?? "")
                    .padding()
                Button {
                    detailBtn.toggle()
                    // WebView(urlString: "https://www.resilience.org/stories/2024-04-04/of-life-and-lithium/")
                  
                } label: {
                    Text("Read More")
                }
                .foregroundColor(.white)
                .padding()
                .frame(width: 120, height: 30)
                .background(Color.red)
                .cornerRadius(15)
                
                Spacer()
            }
          
            .onAppear() {
                viewModel.getData()
            }
            .overlay (
                Group {
                    if viewModel.dataModel == nil {
                        ProgressView()
                    }
                }
            )
           if detailBtn == true {
               NewsDetailView()
           }
       }
       .navigationBarTitle(Text("HeadLines"), displayMode: .large)
       .navigationBarBackButtonHidden(false)
    }
}

struct HomeNewsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNewsView()
    }
}

