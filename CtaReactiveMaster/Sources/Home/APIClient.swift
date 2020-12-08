//
//  APIClient.swift
//  CtaReactiveMaster
//
//  Created by 山根大生 on 2020/12/03.
//

import Foundation
import Alamofire
import RxSwift

struct APIClient {
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetchArticles() -> Observable<[Article]> {
        Observable<[Article]>.create { observer in
            let request = AF.request("http://newsapi.org/v2/everything?q=bitcoin&sortBy=publishedAt&apiKey=30d06e4f9a934402a204fa89f9d9acfc")
            request.response { response in
                switch response.result {
                case .success(let data):
                    guard let data = data else { return }
                    do {
                        let decodeData = try decoder.decode(NewsDataModel.self, from: data)
                        observer.onNext(decodeData.articles)
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
}
