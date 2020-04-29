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
    
    // MARK: Outlets
    @IBOutlet weak var imageDetails: UIImageView!
    @IBOutlet weak var publishedAt: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var link: UITextView!
    
    //MARK: - Variables and constants
    var article : Article!
    
    // MARK: - ViewDidLoad method ,happens first time View appears
    override func viewDidLoad() {
        super.viewDidLoad()
        
        publishedAt.text = "تاريخ النشر : \(article.publishedAt ?? "")"
        
        descriptionLbl.sizeToFit()
        descriptionLbl.text = article.articleDescription
        sourceLbl.text = "المصدر : \(article.source.name)"
        
        link.text = "\(article.url)"
        link.isEditable = false
        
        // MARK: use this to get textView act as a link
        link.dataDetectorTypes = UIDataDetectorTypes.all
//        link.dataDetectorTypes = UIDataDetectorTypes.link
        
        
        
        // using addingPercentEncoding to clear url from any undefined chars, or to parse it correctly
        let image_url = URL(string: "\(article.urlToImage ?? "")".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        
        // using kingFisher pod to indecate image view and to get the photo
        imageDetails.kf.indicatorType = .activity
        
        // if image url has no photo , the image view will replaced with specific photo from assets
        if article.urlToImage != nil{
            imageDetails.kf.setImage(with: image_url)
        }else{
            imageDetails.image = UIImage(named: "No image")
        }
        
        /* use this to make label act as a link
        UIApplication.shared.open(URL(string: "\(article.url)")!, options: [:], completionHandler: nil)
 */
 
        
    }
    
    
    
    
}
