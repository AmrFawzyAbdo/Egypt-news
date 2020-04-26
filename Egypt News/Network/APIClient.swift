//
//  APIClient.swift
//  Egypt News
//
//  Created by Apple on 4/19/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class APIClient {
    
    
    static var AFManager = Session()
    static var searchRequest: DataRequest!
    static var concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    static var myGroup = DispatchGroup()
    static var count = 0
    
    // MARK: - API Requests Method
    
    // MARK: - getNews
    
    static func getNews(completion:@escaping (Result<News,AFError>)->Void) {
//        AF.request(APIRouter.getNews(api: Constants.APIParameterKey.apiKey)).responseDecodable { (response: AFDataResponse<News>) in
//            print(response.response?.statusCode as Any)
//            completion(response.result)
        
        var req = URLRequest(url: URL(string: "http://newsapi.org/v2/top-headlines?country=eg&apiKey=\(Constants.APIParameterKey.apiKey)")!)

        if Connectivity.isConnectedToInternet{}else{
            req.cachePolicy = .returnCacheDataDontLoad
        }
        AF.request(req).responseDecodable { (response: AFDataResponse<News>) in
                        print(response.response?.statusCode as Any)
                        completion(response.result)
        }
        
    }
    
    
    
    // MARK :- getHealth
    
    static func getHealth(completion : @escaping (Result<News , AFError>) -> Void){
//        AF.request(APIRouter.getHealth(api: Constants.APIParameterKey.apiKey)).responseDecodable {(resp : AFDataResponse<News>) in
//            print(resp.response?.statusCode as Any)
//            completion(resp.result)
//        }
        
        var req = URLRequest(url: URL(string: "http://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=\(Constants.APIParameterKey.apiKey)")!)
        
        if Connectivity.isConnectedToInternet{}else{
            req.cachePolicy = .returnCacheDataDontLoad
        }
        AF.request(req).responseDecodable {(resp : AFDataResponse<News>) in
            print(resp.response?.statusCode as Any)
            completion(resp.result)
        }
        
    }
    
    
    // MARK :- getBusiness
    
    static func getBusiness(completion : @escaping (Result<News , AFError>) -> Void){
        var req = URLRequest(url: URL(string: "http://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=\(Constants.APIParameterKey.apiKey)")!)
        
        
        
        if Connectivity.isConnectedToInternet{}else{
        req.cachePolicy = .returnCacheDataDontLoad
        }
        AF.request(req).responseDecodable {(resp : AFDataResponse<News>) in
            print(resp.response?.statusCode as Any)
            completion(resp.result)
        }
    }
    
}
