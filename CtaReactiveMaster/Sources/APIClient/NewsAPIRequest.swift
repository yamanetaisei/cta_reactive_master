//
//  NewsAPIRequest.swift
//  CtaReactiveMaster
//
//  Created by 山根大生 on 2020/12/26.
//

import Foundation

enum Key {
    static var newsApi: String {
        let value: String = "30d06e4f9a934402a204fa89f9d9acfc"
        return value
    }
}


enum Endpoint {
    case topHeadline(country: Country, category: Category)
    case sources(q: String)
    case everything(country: Country, category: Category, language: Language)
    func endpoint() -> String {
        switch self {
        case .topHeadline:
            return "/v2/top-headlines"
        case .sources:
            return "/v2/sources"
        case .everything:
            return "/v2/everything"
        }
    }
}

struct NewsAPIRequest: Requestable {
    typealias Response = NewsDataModel
    
    private let endpoint: Endpoint
    
    var url: URL {
        var baseURL = URLComponents(string: "https://newsapi.org")!
        baseURL.path = endpoint.endpoint()
        
        switch endpoint {
        case let .topHeadline(country, category):
            baseURL.queryItems = [
                URLQueryItem(name: "country", value: country.rawValue),
                URLQueryItem(name: "category", value: category.rawValue),
                URLQueryItem(name: "apiKey", value: Key.newsApi)
            ]
        case let .sources(q):
            baseURL.queryItems = [
                URLQueryItem(name: "q", value: q),
                URLQueryItem(name: "apiKey", value: Key.newsApi)
            ]
        case let .everything(country, category, language):
            baseURL.queryItems = [
                URLQueryItem(name: "country", value: country.rawValue),
                URLQueryItem(name: "category", value: category.rawValue),
                URLQueryItem(name: "language", value: language.rawValue),
                URLQueryItem(name: "apiKey", value: Key.newsApi)
            ]
        }
        return baseURL.url!
    }
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
}

