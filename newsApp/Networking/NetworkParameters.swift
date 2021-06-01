//
//  NetworkParameters.swift
//  newsApp
//
//  Created by Alperen Kişi on 01/06/2021.
//

import Foundation

struct NetworkParameters {
    static let baseURL = "https://newsapi.org/"
    static let urlType = "v2/everything?q="
    let searchText : String?
    static let apiKey = "&apiKey=bb5422666a6c4395af73e2b92de21d15"
}
