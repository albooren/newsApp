 
 import UIKit
 import SDWebImage
  
class NewsDetailViewController: UIViewController {
 
 //MARK: - UI Objects -
    
    var articleImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var articleTitleTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.font = UIFont(name:"TimesNewRomanPS-BoldMT", size: 24.0)
        label.numberOfLines = 3
        return label
    }()
    var articleAuthorNameTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var articleDateTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public var articleContentTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 10
        label.textAlignment = .natural
        return label
    }()
    var urlButton : UIButton = {
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

    var newsDetailUrl : String?

     override func viewDidLoad() {
         super.viewDidLoad()
        setupNavigationBarButtons()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
     
    }
    private func setupNavigationBarButtons() {
        let navBarFavoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonClicked))
        navBarFavoriteButton.tintColor = .black
        let navBarShareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonClicked))
        navBarShareButton.tintColor = .black
        self.navigationItem.rightBarButtonItems  = [navBarFavoriteButton,navBarShareButton]
    }

    func addSubviews() {
        view.addSubview(articleImageView)
        view.addSubview(articleTitleTextLabel)
        view.addSubview(articleAuthorNameTextLabel)
        view.addSubview(articleDateTextLabel)
        view.addSubview(articleContentTextLabel)
        view.addSubview(urlButton)
     }
     
    func setupConstraints() {
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            articleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            articleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            articleImageView.widthAnchor.constraint(equalToConstant: view.frame.width-40),
            articleImageView.heightAnchor.constraint(equalToConstant: ((view.frame.width-40)/4)*3),

           articleTitleTextLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 20),
            articleTitleTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            articleTitleTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            articleTitleTextLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 40),

            articleAuthorNameTextLabel.topAnchor.constraint(equalTo: articleTitleTextLabel.bottomAnchor, constant: 10),
            articleAuthorNameTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            articleAuthorNameTextLabel.widthAnchor.constraint(equalToConstant: 180),

            
            articleDateTextLabel.topAnchor.constraint(equalTo: articleTitleTextLabel.bottomAnchor, constant: 10),
            articleDateTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),


            articleContentTextLabel.topAnchor.constraint(equalTo: articleAuthorNameTextLabel.bottomAnchor, constant: 10),
            articleContentTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            articleContentTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            articleContentTextLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 40),

            urlButton.topAnchor.constraint(equalTo: articleContentTextLabel.bottomAnchor, constant: 10),
            urlButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            urlButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func didTappedLink() {
        guard let url = URL(string: newsDetailUrl ?? "") else { return }
        let vc = WebViewViewController(url:url , title: "News Source")
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true, completion: nil)
    }
    @objc func favoriteButtonClicked() {
       print("Favorite Button Clicked")
    }
    @objc func shareButtonClicked() {
        let activityVC = UIActivityViewController(activityItems: [newsDetailUrl ?? "Link is not valid."], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
 }