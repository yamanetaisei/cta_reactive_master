//
//  HomeViewController.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/11/21.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
            tableView.refreshControl = refreshControl
        }
    }
    private var articles: [Article] = .init()
    private let apiClient: APIClient
    private let disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    
    init(apiClient:APIClient) {
        self.apiClient = apiClient
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiClient.fetchArticles()
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] articles in
                self?.articles = articles
                self?.tableView.reloadData()
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.refresh()
            },
            onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func refresh() {
        apiClient.fetchArticles()
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] articles in
                self?.articles = articles
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.textLabel?.text = articles[indexPath.row].title
        return cell
    }
}
