//
//  DataModel.swift
//  NewsWire
//
//  Created by Simranjeet Kaur on 12/04/24.
//

import Foundation

struct DataModel: Decodable {
    var articles: [ArticlesModel]
}

struct ArticlesModel: Decodable {
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
}
