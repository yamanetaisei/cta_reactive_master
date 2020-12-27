//
//  NewsArticleRepository.swift
//  CtaReactiveMaster
//
//  Created by 山根大生 on 2020/12/06.
//

import Foundation
import RxSwift

protocol Repository {
    associatedtype Response
    var apiClient: APIClient { get }
    
    func fetch() -> Observable<Response>
}

struct NewsArticleRepository: Repository {
    let apiClient = APIClient()
    
    typealias Response = NewsDataModel
    
    func fetch() -> Observable<NewsDataModel> {
        let request = NewsAPIRequest(endpoint: .topHeadline(country: .jp, category: .health))
        return apiClient.request(request)
    }
}
