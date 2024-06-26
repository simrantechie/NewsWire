//
//  ViewModel.swift
//  NewsWire
//
//  Created by Simranjeet Kaur on 12/04/24.
//
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var dataModel: DataModel?
    
    func getData(completion: @escaping (DataModel?, Error?) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=apple&from=2024-05-03&to=2024-05-04&sortBy=popularity&apiKey=ed142d0f63b44c38b1edd34c5ddfd44c") else {
            return
        }
        Manager.shared.sendGetRequestWithURLSession(url: url, type: DataModel.self) { (result: Result<DataModel, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.dataModel = data
                }
            case .failure(let error):
                print(error)
            }
            
        }
        completion(dataModel, nil)
    }
}
