//
//  NewsArticleRepository.swift
//  CtaReactiveMaster
//
//  Created by 山根大生 on 2020/12/06.
//

import Foundation

protocol UrlGetter {
    var url: String { get }
}

struct BitcoinNewsAPI: UrlGetter {
    var url: String {
        return "http://newsapi.org/v2/everything?q=bitcoin&sortBy=publishedAt&apiKey=30d06e4f9a934402a204fa89f9d9acfc"
    }
}

struct BusinessNewsAPI: UrlGetter {
    var url: String {
        return "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=30d06e4f9a934402a204fa89f9d9acfc"
    }
}

struct AppleNewsAPI: UrlGetter {
    var url: String {
        return "http://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=30d06e4f9a934402a204fa89f9d9acfc"
    }
}

struct TechCrunchNewsAPI: UrlGetter {
    var url: String {
        return "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=30d06e4f9a934402a204fa89f9d9acfc"
    }
}

struct WallStreetJournalNewsAPI: UrlGetter {
    var url: String {
        return "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=30d06e4f9a934402a204fa89f9d9acfc"
    }
}
