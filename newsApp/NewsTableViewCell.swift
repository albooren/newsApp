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
    
    lazy var newsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    lazy var newsShortDetailLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    lazy var newsImageView : UIImageView = {
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
            newsLabel.widthAnchor.constraint(equalToConstant: 150),
            
            newsShortDetailLabel.topAnchor.constraint(equalTo: newsLabel.bottomAnchor,constant: 5),
            newsShortDetailLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            newsShortDetailLabel.widthAnchor.constraint(equalToConstant: 250),
            
            newsImageView.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            newsImageView.widthAnchor.constraint(equalToConstant: 60),
            newsImageView.heightAnchor.constraint(equalToConstant: 60)
           
        ])
    }
}
