//
//  NewsTableViewCell.swift
//  newsApp
//
//  Created by Alperen Kişi on 01/06/2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    static let identifier = "NewsTableViewCell"

    //MARK: - UI Objects -
    
     var newsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Loading"
        return label
    }()
    
     var newsShortDetailLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        label.numberOfLines = 2
        return label
    }()
     var newsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "House")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(newsLabel)
        addSubview(newsShortDetailLabel)
        addSubview(newsImageView)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            newsLabel.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            newsLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            newsLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -10),
            
            newsShortDetailLabel.topAnchor.constraint(equalTo: newsLabel.bottomAnchor,constant: 5),
            newsShortDetailLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            newsShortDetailLabel.widthAnchor.constraint(equalToConstant: 250),
            
            newsImageView.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            newsImageView.widthAnchor.constraint(equalToConstant: 80),
            newsImageView.heightAnchor.constraint(equalToConstant: 60)
           
        ])
    }
}
