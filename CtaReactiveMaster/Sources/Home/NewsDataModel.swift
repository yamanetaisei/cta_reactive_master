//
//  NewsDataModel.swift
//  CtaReactiveMaster
//
//  Created by 山根大生 on 2020/11/28.
//

import Foundation

struct NewsDataModel: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
}

struct Source: Decodable {
    let id: String?
    let name: String
}
