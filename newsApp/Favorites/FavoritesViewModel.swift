//
//  FavoritesViewModel.swift
//  newsApp
//
//  Created by Alperen Kişi on 06/06/2021.
//

import UIKit
import CoreData

class FavoritesViewModel {
    var favedNews = [FavoriteNews]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllFavoritedNews() {
        do {
            favedNews = try context.fetch(FavoriteNews.fetchRequest())
            let favoritesViewController = FavoritesViewController()
            DispatchQueue.main.async {
                favoritesViewController.favoriteNewsTableView.reloadData()
            }
            
        } catch {
            print("ERROR")
        }
    }
    func saveFavoritedNew(newsTitle: String,
                          newsImageURL:String,
                          newsAuthor:String,
                          newsPublishDate:String,
                          newsContent:String,
                          newsLinkURL:String) {
        
        let favedNew = FavoriteNews(context: context)
        favedNew.newsTitle = newsTitle
        favedNew.newsImageURL = newsImageURL
        favedNew.newsAuthor = newsAuthor
        favedNew.newsPublishDate = newsPublishDate
        favedNew.newsContent = newsContent
        favedNew.newsLinkURL = newsLinkURL
        do {
            try context.save()
            getAllFavoritedNews()
        } catch  {
            print("News does not favorited!")
        }
    }
    func removeFavoritedNew(new : FavoriteNews) {
        context.delete(new)
        do {
            try context.save()
        } catch  {
            print("News does not remove from favoritedList")
        }
    }
    
    
}

