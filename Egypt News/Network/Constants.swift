//
//  Constants.swift
//  Egypt News
//
//  Created by Apple on 4/19/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct Constants {
    struct ProductionServer {
        static let baseURL = "http://newsapi.org/v2/top-headlines?country=eg&"

    }
    
    struct APIParameterKey {
        static let countryCode = "country_code"
        static let randomCode = "random_code"
        static let cPassword = "c_password"
        static let apiKey = "f6ff4d5803624d259c61b9f88e9ef11a"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
