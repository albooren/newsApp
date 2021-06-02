//
//  ViewController.swift
//  newsApp
//
//  Created by Alperen Kişi on 31/05/2021.
//

import UIKit
import SDWebImage

class FeedViewController: UIViewController {
    
    let searchController = UISearchController()
    private var feedViewModel = FeedViewModel()
    
    //MARK: -UI Objects -
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    public var loadingView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        prepNavigationController()
        prepSearchBar()
        view.addSubview(tableView)
        setupConstraints()
        setupLoadingView()
        getData()
    }
    
    func prepNavigationController() {
        title = "News"
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
    }
    func prepSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    func getData() {
        feedViewModel.getArticle(onCompleted: { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.endLoadingView()
        },onFailed: { [weak self] in
            guard let self = self else { return }
            self.endLoadingView()
            self.showError(alertTitle: "Hata!", alertSubtitle: "Veriler yüklenmedi", okButtonTitle: "Ok")
        })
    }
    public func setupLoadingView(){
        loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = loadingView.center
        loadingIndicator.startAnimating()
        loadingView.addSubview(loadingIndicator)
        view.addSubview(loadingView)
    }
    public func endLoadingView() {
        loadingView.removeFromSuperview()
    }
}

extension FeedViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,for : indexPath) as? NewsTableViewCell{
            cell.newsLabel.text = feedViewModel.articleList[indexPath.row].title
            cell.newsImageView.sd_setImage(with: URL(string: feedViewModel.articleList[indexPath.row].urlToImage ?? ""))
            cell.newsShortDetailLabel.text = feedViewModel.articleList[indexPath.row].description
            return cell
        }
        else {
            return UITableViewCell() }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = NewsDetailViewController()
        detailVC.articleImageView.sd_setImage(with: URL(string: feedViewModel.articleList[indexPath.row].urlToImage ?? ""))
        detailVC.articleAuthorNameTextLabel.text = " 📰 \(String(feedViewModel.articleList[indexPath.row].author ?? ""))"
        detailVC.articleContentTextLabel.text = feedViewModel.articleList[indexPath.row].content
        detailVC.articleTitleTextLabel.text = feedViewModel.articleList[indexPath.row].title
        detailVC.articleDateTextLabel.text = feedViewModel.articleList[indexPath.row].publishedAt
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FeedViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        print(text)
    }
    
}

