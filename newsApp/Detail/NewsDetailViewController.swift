 
 import UIKit
 import SDWebImage
  
class NewsDetailViewController: UIViewController {
 
 //MARK: - UI Objects -
    lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000)
        return scrollView
    }()
    lazy var contentView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + articleContentTextLabel.frame.height))
    
    lazy var articleImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var articleTitleTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.font = UIFont(name:"TimesNewRomanPS-BoldMT", size: 24.0)
        label.numberOfLines = 3
        return label
    }()
    lazy var articleAuthorNameTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var articleDateTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var articleContentTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    lazy var urlButton : UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title(for: .normal)
        button.setTitle("News Source", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(didTappedLink), for: .touchUpInside)
        return button
    }()
    
        var selectedNewsTitle : String?
        var selectedNewsImageURL : String?
        var selectedNewsAuthor : String?
        var selectedNewsDate : String?
        var selectedNewsContent: String?
        var selectednewsDetailUrl : String?
    
        var favoritesVC = FavoritesViewController()
        var favoritesViewModel = FavoritesViewModel()
    
     override func viewDidLoad() {
         super.viewDidLoad()        
        setupNavigationBarButtons()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        setupContent()
    }
    
    private func setupNavigationBarButtons() {
        let navBarFavoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favoriteButtonClicked))
        navBarFavoriteButton.tintColor = .black
        let navBarShareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonClicked))
        navBarShareButton.tintColor = .black
        self.navigationItem.rightBarButtonItems  = [navBarFavoriteButton,navBarShareButton]
    }

    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(articleImageView)
        contentView.addSubview(articleTitleTextLabel)
        contentView.addSubview(articleAuthorNameTextLabel)
        contentView.addSubview(articleDateTextLabel)
        contentView.addSubview(articleContentTextLabel)
        contentView.addSubview(urlButton)s
     }
     
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            articleImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            articleImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width-40),
            articleImageView.heightAnchor.constraint(equalToConstant: ((contentView.frame.width-40)/4)*3),

           articleTitleTextLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 20),
            articleTitleTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            articleTitleTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            articleTitleTextLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - 40),

            articleAuthorNameTextLabel.topAnchor.constraint(equalTo: articleTitleTextLabel.bottomAnchor, constant: 10),
            articleAuthorNameTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            articleAuthorNameTextLabel.widthAnchor.constraint(equalToConstant: 180),


            articleDateTextLabel.topAnchor.constraint(equalTo: articleTitleTextLabel.bottomAnchor, constant: 10),
            articleDateTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),


            articleContentTextLabel.topAnchor.constraint(equalTo: articleAuthorNameTextLabel.bottomAnchor, constant: 10),
            articleContentTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            articleContentTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            articleContentTextLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - 40),

            urlButton.topAnchor.constraint(equalTo: articleContentTextLabel.bottomAnchor, constant: 10),
            urlButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            urlButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setupContent() {
        articleImageView.sd_setImage(with: URL(string: selectedNewsImageURL ?? GenericComponents.unknownImageUrlLink))
        articleTitleTextLabel.text = selectedNewsTitle
        articleAuthorNameTextLabel.text = selectedNewsAuthor
        articleDateTextLabel.text = selectedNewsDate
        articleContentTextLabel.text = selectedNewsContent
    }
    
    @objc func didTappedLink() {
        guard let url = URL(string: selectednewsDetailUrl ?? "") else { return }
        let vc = WebViewViewController(url:url , title: "News Source")
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true, completion: nil)
    }
    
    @objc func favoriteButtonClicked() {
        favoritesViewModel.saveFavoritedNew(newsTitle: selectedNewsTitle ?? "",
                                            newsImageURL: selectedNewsImageURL ?? GenericComponents.unknownImageUrlLink,
                                            newsAuthor: selectedNewsAuthor ?? "",
                                            newsPublishDate: selectedNewsDate ?? "",
                                            newsContent: selectedNewsContent ?? "",
                                            newsLinkURL: selectednewsDetailUrl ?? "")
        favoritesVC.favoriteNewsTableView.reloadData()
        navigationController?.pushViewController(favoritesVC, animated: true)
    }
    
    @objc func shareButtonClicked() {
        let activityVC = UIActivityViewController(activityItems: [selectednewsDetailUrl ?? "Link is not valid."], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
 }
 
