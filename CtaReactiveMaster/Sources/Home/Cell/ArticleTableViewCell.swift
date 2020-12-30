//
//  ArticleTableViewCell.swift
//  CtaReactiveMaster
//
//  Created by 山根大生 on 2020/11/23.
//

import UIKit

final class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
            titleLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var articleImageView: UIImageView! {
        didSet {
            articleImageView.contentMode = .scaleAspectFill
            articleImageView.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = .systemFont(ofSize: 14)
            descriptionLabel.numberOfLines = 3
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel! {
        didSet {
            authorLabel.font = .systemFont(ofSize: 10)
            authorLabel.textAlignment = .right
            authorLabel.textColor = .gray
        }
    }
    
    func setUpInformation(article: Article) {
        articleImageView.loadImage(from: article.urlToImage)
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        authorLabel.text = article.author
    }
}
