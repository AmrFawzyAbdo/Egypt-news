//
//  DetailsViewController.swift
//  Egypt News
//
//  Created by Apple on 4/19/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageDetails: UIImageView!
    @IBOutlet weak var publishedAt: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var link: UITextView!
    
    var article : Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        publishedAt.text = "تاريخ النشر : \(article.publishedAt ?? "")"
        
        descriptionLbl.sizeToFit()
        descriptionLbl.text = article.articleDescription
        sourceLbl.text = "المصدر : \(article.source.name)"
        
        link.text = "\(article.url)"
        link.isEditable = false
        link.dataDetectorTypes = UIDataDetectorTypes.all
//        link.dataDetectorTypes = UIDataDetectorTypes.link
        
        
        let image_url = URL(string: "\(article.urlToImage ?? "")".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        imageDetails.kf.indicatorType = .activity
        if article.urlToImage != nil{
            imageDetails.kf.setImage(with: image_url)
        }else{
            imageDetails.image = UIImage(named: "No image")
        }
        
//        UIApplication.shared.open(URL(string: "\(article.url)")!, options: [:], completionHandler: nil)
        
        
    }
    
    
    
    
}
