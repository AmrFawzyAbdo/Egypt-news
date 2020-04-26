//
//  HealthViewController.swift
//  Egypt News
//
//  Created by Apple on 4/20/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Kingfisher

class HealthViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate  {
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var healthNews = [Article]()
    let refreshController = UIRefreshControl()


    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        refreshController.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshController
        refreshController.tintColor = .black
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black ,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)]
        
        refreshController.attributedTitle = NSAttributedString(string: "Refreshing please wait" , attributes: attributes)
        
        // Navigation item title color
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
    

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        health()
    }
    
    
    func health(){
        showHUD()
        APIClient.getHealth{(result) in
            switch result {
            case .success(let res):
                self.healthNews = res.articles
                self.collectionView.reloadData()
                self.hideHUD()
            case .failure(_):
                self.hideHUD()
                self.showMessage("Connection interrupted")
                return
            }
        }
    }
    
    
    @objc private func didPullToRefresh(_ sender: Any){
        if Connectivity.isConnectedToInternet{
        APIClient.getHealth{(result) in
            switch result {
            case .success(let res):
                self.healthNews = res.articles
                self.collectionView.reloadData()
                self.refreshController.endRefreshing()
                self.hideHUD()
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
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.newsTitle.text = healthNews[indexPath.row].title
        
        let imagePath = URL(string: "\(healthNews[indexPath.row].urlToImage ?? "")".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        
        if healthNews[indexPath.row].urlToImage != nil{
            cell.newsImage.kf.indicatorType = .activity
            cell.newsImage.kf.setImage(with: imagePath)
        }else{
            cell.newsImage.image = UIImage(named: "No image")
        }
       
        
        
        let index = (healthNews.count) - 1
        if indexPath.row == index {
            cell.sepaateLine.isHidden = true
        }else{
            cell.sepaateLine.isHidden = false
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.article = healthNews[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
   

}





extension HealthViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: 140)
    }
}
