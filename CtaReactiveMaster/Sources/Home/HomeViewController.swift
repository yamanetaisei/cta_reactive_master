//
//  HomeViewController.swift
//  CtaReactiveMaster
//
//  Created by Takuma Osada on 2020/11/21.
//

import UIKit
import Alamofire

final class HomeViewController: UIViewController {

    @IBOutlet private weak var articleTableView: UITableView! {
        didSet {
            articleTableView.delegate = self
            articleTableView.dataSource = self
            articleTableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        }
    }
    var dataArray:[Articles] = [Articles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        return cell
    }
    
    func fetchArticles() {
        let request = AF.request("http://newsapi.org/v2/everything?q=bitcoin&from=2020-10-30&sortBy=publishedAt&apiKey=30d06e4f9a934402a204fa89f9d9acfc")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        request.response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                do {
                    let decodeData = try decoder.decode(NewsDataModel.self, from: data)
                    self.dataArray = decodeData.articles
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
