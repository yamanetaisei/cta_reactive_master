//
//  HomeViewModel.swift
//  CtaReactiveMaster
//
//  Created by 山根大生 on 2021/01/04.
//

import Foundation
import RxSwift
import RxRelay

struct HomeViewModel {
    struct Dependency {
        let repository: NewsArticleRepository
    }

    struct HomeViewModelOutput {
        let articles = BehaviorRelay<[Article]>(value: [])
        let showLoading = BehaviorRelay<Bool>(value: false)
    }

    let dependency: Dependency
    let disposeBag = DisposeBag()
    let output = HomeViewModelOutput()
        
    init(dependency: Dependency) {
        self.dependency = dependency
        output.articles
            .materialize()
            .do(onNext: { [self] _ in
                output.showLoading.accept(false)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }

    func fetch() {
        output.showLoading.accept(true)
        dependency.repository.fetch()
            .asObservable()
            .map(\.articles)
            .bind(to: output.articles)
            .disposed(by: disposeBag)
    }
}
