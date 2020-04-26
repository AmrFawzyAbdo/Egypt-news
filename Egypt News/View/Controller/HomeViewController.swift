//
//  ViewController.swift
//  Egypt News
//
//  Created by Apple on 4/19/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var news = [Article]()
    private let refreshControl = UIRefreshControl()
    let userDefault = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .black
        self.collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
       
        // Refresh control settings

        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        refreshControl.tintColor = .white
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing please wait", attributes: attributes)
        
        
        // Navigation item title color
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        // Do you your api calls in here, and then asynchronously remember to stop the
        // refreshing when you've got a result (either positive or negative)
        
        if Connectivity.isConnectedToInternet{
        
        APIClient.getNews{(result) in
            switch result {
            case .success(let res):
                self.refreshControl.endRefreshing()
                self.news = res.articles
                self.collectionView.reloadData()
            case .failure(_):
                self.refreshControl.endRefreshing()
                self.showMessage("Connection faild")
                return
            }
        }
        }else{
            self.refreshControl.endRefreshing()
            self.showMessage("Check your network connection")
        }
    }
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getNews()
    }
    
    func getNews(){
        showHUD()
        
        APIClient.getNews{(result) in
            switch result {
            case .success(let res):
                self.news = res.articles
                self.collectionView.reloadData()
                self.hideHUD()
            case .failure(_):
                self.hideHUD()
                self.showMessage("Connection interrupted")
                self.collectionView.reloadData()
                return
            }
        }

    }
    
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(news.count)
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.newsTitle.text = news[indexPath.row].title
            
        let imagePath = URL(string: "\(news[indexPath.row].urlToImage ?? "")".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        print(imagePath ?? "")
        cell.newsImage.kf.indicatorType = .activity
        if news[indexPath.row].urlToImage != nil{
        cell.newsImage.kf.setImage(with: imagePath)
        }else{
            cell.newsImage.image = UIImage(named: "No image")
        }
        
        let index = (news.count) - 1
        if indexPath.row == index{
            cell.sepaateLine.isHidden = true
        }else{
            cell.sepaateLine.isHidden = false
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.article = news[indexPath.row]

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       
        let width  = view.frame.width
        return CGSize(width: width, height: 140
        )
    }
    
}


