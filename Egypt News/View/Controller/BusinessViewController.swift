//
//  BusinessViewController.swift
//  Egypt News
//
//  Created by Apple on 4/20/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class BusinessViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource{
   
    //MARK: - Variables and constants
    var business = [Article]()
    
    /// Refresh control
    let refreshController = UIRefreshControl()
    
    // MARK: Outlets
    @IBOutlet weak var collection: UICollectionView!
    
    // MARK: ViewDidLoad method ,happens first time View appears
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: ViewDidLoad method ,happens first time View appears
        collection.delegate = self
        collection.dataSource = self
        
        // MARK: Refresh control settings
        refreshController.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collection.alwaysBounceVertical = true
        collection.refreshControl = refreshController
        refreshController.tintColor = .black
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black ,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)]
        
        refreshController.attributedTitle = NSAttributedString(string: "Refreshing please wait" , attributes: attributes)
        
        
        
        // Navigation item title color
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

    }

    
    // MARK: viewWillAppear method , called every time view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// calling an api to get news
        getBusiness()
    }
    
    // MARK: A method to get news
    func getBusiness(){
        /// show loading indecator
        showHUD()
        
        // calling getBusiness api
        APIClient.getBusiness{(result) in
            switch result {
            case .success(let res):
                // passing data came from response to the News MODEL
                self.business = res.articles
                
                // reload data for collection after getting it from the response
                self.collection.reloadData()
                self.hideHUD()
            case .failure(_):
                self.hideHUD()
                self.showMessage("Connection interrupted")
                return
            }
        }
    }
    
    
    // MARK: What happens when calling did pull to refresh
    // MARK: didPullToRefresh
    @objc private func didPullToRefresh(_ sender: Any){
        
        /* Do you your api calls in here, and then asynchronously remember to stop the
         refreshing when you've got a result (either positive or negative) */
        
        // check the internet connection
        if Connectivity.isConnectedToInternet{
        APIClient.getBusiness{(result) in
            switch result {
            case .success(let res):
                self.business = res.articles
                self.collection.reloadData()
                self.refreshController.endRefreshing()
            case .failure(_):
                self.refreshController.endRefreshing()
                self.showMessage("Connection interrupted")
                return
            }
        }
        }else{
            self.refreshController.endRefreshing()
            self.showMessage("Check your network connection")
        }
    }
    
    
    // MARK: Used to define number of items per section
    /// - Returns: number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return business.count
    }
    
    // MARK: Declaration of each cell
    /// - Returns: cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.newsTitle.text = business[indexPath.row].title
        
        // using addingPercentEncoding to clear url from any undefined chars, or to parse it correctly
        let imagePath = URL(string: "\(business[indexPath.row].urlToImage ?? "")".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        
        // using kingFisher pod to indecate image view and to get the photo
        cell.newsImage.kf.indicatorType = .activity
        
        // if image url has no photo , the image view will replaced with specific photo from assets
        if business[indexPath.row].urlToImage != nil{
            cell.newsImage.kf.setImage(with: imagePath)
        }else{
            cell.newsImage.image = UIImage(named: "No image")
        }
        
        // to hide separator of the last cell
        let index = (business.count) - 1
        if indexPath.row == index {
            cell.sepaateLine.isHidden = true
        }else{
            cell.sepaateLine.isHidden = false
        }
        
        return cell
    }

    // MARK: do an action while pressing on the cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        // pasing cell data to a variable in the next view
        vc.article = business[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
   

}

// MARK: define width and height of cells
extension BusinessViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: 140)
    }
}
