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
    

    
    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables and constants
    var news = [Article]()
    // TODO: user refresher while scrolling collectionView down
    
    /// Refresh control
    private let refreshControl = UIRefreshControl()

    
    // MARK: ViewDidLoad method ,happens first time View appears
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: CollectionView dataSource, delegate, and customization
        
        collectionView.backgroundColor = .black
        self.collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
       
        
        // MARK: Refresh control settings
        
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
    

    
    
    // MARK: viewWillAppear method , called every time view appears
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// calling an api to get news
        getNews()
    }
    
    
    // MARK: A method to get news
    func getNews(){
        /// show loading indecator
        showHUD()
        // calling getnews api
        APIClient.getNews{(result) in
            switch result {
            case .success(let res):
                // passing data came from response to the News MODEL
                self.news = res.articles
                // reload data for collection after getting it from the response
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
    
    
    // MARK: What happens when calling did pull to refresh
    // MARK: didPullToRefresh
    @objc private func didPullToRefresh(_ sender: Any){
        /* Do you your api calls in here, and then asynchronously remember to stop the
         refreshing when you've got a result (either positive or negative) */
        
        // check the internet connection
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
    
    

    
    // MARK: Used to define number of items per section
    /// - Returns: number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(news.count)
        return news.count
    }
    
    
    // MARK: Declaration of each cell
    /// - Returns: cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.newsTitle.text = news[indexPath.row].title
        
        // if title of cell has word "عاجل" , title color become red
        if news[indexPath.row].title.hasPrefix("عاجل") {
            print("contains")
            cell.newsTitle.textColor = .red
        }else{
            cell.newsTitle.textColor = .white
        }
        
        // using addingPercentEncoding to clear url from any undefined chars, or to parse it correctly
        let imagePath = URL(string: "\(news[indexPath.row].urlToImage ?? "")".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        print(imagePath ?? "")
        
        // using kingFisher pod to indecate image view and to get the photo
        cell.newsImage.kf.indicatorType = .activity
        
        // if image url has no photo , the image view will replaced with specific photo from assets
        if news[indexPath.row].urlToImage != nil{
        cell.newsImage.kf.setImage(with: imagePath)
        }else{
            cell.newsImage.image = UIImage(named: "No image")
        }
        
        
        // to hide separator of the last cell
        let index = (news.count) - 1
        if indexPath.row == index{
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
        vc.article = news[indexPath.row]

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: define width and height of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       
        let width  = view.frame.width
        return CGSize(width: width, height: 140
        )
    }
    
}


