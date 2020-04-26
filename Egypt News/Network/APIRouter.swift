//
//  APIRouter.swift
//  Egypt News
//
//  Created by Apple on 4/19/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Alamofire
import SwiftKeychainWrapper

enum APIRouter: URLRequestConvertible {

    case getNews(api : String)
    case getHealth(api : String)
    case getBusiness(api : String)
   
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .getNews , .getHealth , .getBusiness:
            return .get
            
//        case .generateCode, .signup, .signin, .testCode, .forgetPasswordByPhone, .forgetPasswordByEmail, .checkPasswordByPhone, .checkPasswordByEmail, .createInvoice, .createWarranty, .createMonthlySubscription, .changePassword , .addMessage, .like ,.createReview , .createCollection , .sendCode , .sendToken:
//            return .post
//            
//        case .completeProfile , .changePhoneNumberWithCode, .changePhoneNumber , .editSettings , .editReviews , .editMonthlySubscription , .editInvoice , .editWarrenty , .editCollection, .convertCurrency :
//            return .put
//            
//        case .deleteInvoice  , .deleteWarrenty , .deleteMonthSub , .deleteCollection ,.deleteProduct:
//            return .delete
        }
        
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
       
        case .getNews(let api) :
            return "apiKey=\(api)"
            
        case .getHealth(let api):
            return "category=health&apiKey=\(api)"
        
        case .getBusiness(let api):
            return "category=business&apiKey=\(api)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
//        case .getNews(let getNews) :
//            return getNews
            
        case .getNews , .getHealth ,.getBusiness :
            return nil
        }
    }
    
    // MARK: - Headers
    private var queries: [Queries]? {
        switch self {
//        case .getAllAwarenesses(let queries), .getHome(let queries) , .getMonthSub(let queries):
//            return queries
            
        case .getNews , .getHealth , .getBusiness:
            return nil
        }
    }
    
    // MARK: - Dynamic Param
    private var dynamicParam: String? {
        switch self {
//        case .like(let liked, let id):
//            return "/\(id)"
            
        case .getNews , .getHealth , .getBusiness:
            
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = Constants.ProductionServer.baseURL
        var components = URLComponents(string: "\(url)\(path)\(dynamicParam ?? "")")!
        
        // Add Queries
        if let queries = queries {
            components.queryItems = [URLQueryItem]()
            for query in queries {
                let queryItem = URLQueryItem(name: query.key, value: query.value)
                components.queryItems!.append(queryItem)
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        
        var urlRequest = URLRequest(url: components.url!)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
//        if let accessToken = User.shared?.token {
//            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
//        }
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}

struct Queries : Equatable {
    var key: String
    var value: String
}
