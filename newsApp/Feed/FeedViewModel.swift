//
//  FeedViewModel.swift
//  newsApp
//
//  Created by Alperen Kişi on 01/06/2021.
//

import Foundation

class FeedViewModel {
    
    var articleList = [Article]()
    
    func getArticle(onCompleted: @escaping () -> (), onFailed: @escaping () -> ()) {
        NetworkManager.shared.request(with: getApiUrl()) { [weak self] (data: Welcome) in
            guard let self = self else { return }
            self.handleArticleData(data)
            onCompleted()
        } onError: {
            onFailed()
        }

    }
    
    func handleArticleData(_ data: Welcome){
        guard let articles = data.articles else { return }
        for article in articles {
            let model = Article(source: article.source, author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content)
            articleList.append(model)
        }
    }
    
    func getApiUrl() -> String{
        return NetworkParameters.baseURL + NetworkParameters.urlType + "besiktas" + NetworkParameters.apiKey
    }

}
