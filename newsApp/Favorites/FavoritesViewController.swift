//
//  FavoritesViewController.swift
//  newsApp
//
//  Created by Alperen Kişi on 31/05/2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    var favoriteNewsTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepView()
        addSubViews()
        setupConstraints()
        
        favoriteNewsTableView.dataSource = self
        favoriteNewsTableView.delegate = self
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteNewsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteNewsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favoriteNewsTableView.trailingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteNewsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteNewsTableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    func addSubViews() {
        view.addSubview(favoriteNewsTableView)
    }
    
    func prepView() {
        title = "Favorites"
        view.backgroundColor = .white

    }
}
extension FavoritesViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,for : indexPath) as? NewsTableViewCell{
            cell.newsLabel.text = "test"
            cell.newsImageView.image = UIImage(systemName: "pencil")
            cell.newsShortDetailLabel.text = "testOTest"
            return cell
        }
        else {
            return UITableViewCell() }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
