//
//  FavoriteNews+CoreDataProperties.swift
//  
//
//  Created by Alperen Kişi on 06/06/2021.
//
//

import Foundation
import CoreData


extension FavoriteNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteNews> {
        return NSFetchRequest<FavoriteNews>(entityName: "FavoriteNews")
    }

    @NSManaged public var newsAuthor: String?
    @NSManaged public var newsContent: String?
    @NSManaged public var newsImageURL: String?
    @NSManaged public var newsLinkURL: String?
    @NSManaged public var newsPublishDate: String?
    @NSManaged public var newsTitle: String?

}
