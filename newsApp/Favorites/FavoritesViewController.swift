//
//  FavoritesViewController.swift
//  newsApp
//
//  Created by Alperen Kişi on 31/05/2021.
//

import UIKit

class FavoritesViewController: UIViewController {
        
    var favoritesViewModel = FavoritesViewModel()
    
   lazy var favoriteNewsTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesViewModel.getAllFavoritedNews()
        prepView()
        addSubViews()
        setupConstraints()
        
        favoriteNewsTableView.dataSource = self
        favoriteNewsTableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        favoritesViewModel.getAllFavoritedNews()
        favoriteNewsTableView.reloadData()
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
        return favoritesViewModel.favedNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,for : indexPath) as? NewsTableViewCell{
            cell.newsLabel.text = favoritesViewModel.favedNews[indexPath.row].newsTitle
            cell.newsImageView.sd_setImage(with: URL(string: favoritesViewModel.favedNews[indexPath.row].newsImageURL ?? GenericComponents.unknownImageUrlLink))
            cell.newsShortDetailLabel.text = favoritesViewModel.favedNews[indexPath.row].newsContent
            return cell
        }
        else {
            return UITableViewCell() }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = NewsDetailViewController()
        let feedViewController = FeedViewController()
        detailVC.selectedNewsImageURL = favoritesViewModel.favedNews[indexPath.row].newsImageURL ?? GenericComponents.unknownImageUrlLink
        detailVC.selectedNewsTitle = favoritesViewModel.favedNews[indexPath.row].newsTitle
        detailVC.selectedNewsAuthor = favoritesViewModel.favedNews[indexPath.row].newsAuthor
        detailVC.selectedNewsDate = " 🗓 \(feedViewController.prepTime(time: favoritesViewModel.favedNews[indexPath.row].newsPublishDate ?? ""))"
        detailVC.selectedNewsContent = favoritesViewModel.favedNews[indexPath.row].newsContent
        detailVC.selectednewsDetailUrl = favoritesViewModel.favedNews[indexPath.row].newsLinkURL
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            favoritesViewModel.removeFavoritedNew(new: favoritesViewModel.favedNews[indexPath.row])
            favoritesViewModel.favedNews.remove(at: indexPath.row)
            favoriteNewsTableView.reloadData()
        }
    }
}
