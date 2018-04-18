//
//  ViewController.swift
//  DSNewsfeed
//
//  Created by Amanda Tomasetti on 3/17/18.
//  Copyright © 2018 Amanda Tomasetti. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Alamofire
import SwiftyJSON

class ViewController: ASViewController<ASDisplayNode> {
    
    var postsArray : [Post] = [Post]()
    let cellIdentifier = "PostCell"
    
    var tableNode: ASTableNode
    var activityIndicatorView: UIActivityIndicatorView!
    var dataProvider: PostsTableDataProvider!

    init() {
        tableNode = ASTableNode()
        super.init(node: tableNode)
        dataProvider = PostsTableDataProvider()
        dataProvider.tableNode = tableNode
        tableNode.dataSource = dataProvider
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.sizeToFit()
        
        var refreshRect = activityIndicatorView.frame
        refreshRect.origin = CGPoint(x: (view.bounds.size.width - activityIndicatorView.frame.width) / 2.0, y: activityIndicatorView.frame.midY)
        
        activityIndicatorView.frame = refreshRect
        view.addSubview(activityIndicatorView)
        
        tableNode.view.allowsSelection = false
        tableNode.view.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        activityIndicatorView.startAnimating()
        self.navigationItem.title = "Posts"
        getJSONData ()
        
    }
    
    func foundPostItems(_ posts: [Post]?) {
            dataProvider.insertNewPostsInTableView(posts!)
            activityIndicatorView.stopAnimating()
    }

    //Http Request
    func getJSONData() {
        Alamofire.request("https://www.dysiopen.com/v1/posts/public", method:.get).responseJSON {
            response in
            if response.result.isSuccess, let value = response.result.value {
                let JSONresponse : JSON = JSON(value)
                if let JOSNData = JSONresponse.rawString(){
                    self.ParsingJSONData(JSONData: JOSNData)
                    self.foundPostItems(self.postsArray)
                }
            }
        }
    }

    //Parsing using SwiftyJSON
    func ParsingJSONData(JSONData : String) {
        if let data = JSONData.data(using: .utf8) {
            if let json = try? JSON(data: data) {

                for item in json["posts"].arrayValue {

                    let title = item["title"].stringValue
                    let description = item["description"].stringValue
                    let articleImage = item["images"]["Box1440"]["url"].stringValue
                    let authorName = item["author"]["postSourceName"].stringValue
                    //if date is not nill after formatting
                    if let date = formatDate(strDate : item["createdDate"].stringValue) {
                        let newPost = Post(title : title, description : description, createdDate : date, articleImage : articleImage, authorName : authorName)
                        postsArray.append(newPost)
                    }
                    //if date is nill after formatting
                    else {
                        let date = item["createdDate"].stringValue
                        let newPost = Post(title : title, description : description, createdDate : date, articleImage : articleImage, authorName : authorName)
                        postsArray.append(newPost)

                    }
                }
            }
        }
    }

    func formatDate(strDate : String) -> String? {

        let dateFormatter = DateFormatter()
        //Current date format
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        //Current time zone
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        //Convert String to Date
        if let date = dateFormatter.date(from: strDate) {
            //New date format
            dateFormatter.dateFormat = "MMM d, yyyy   h:m a"
            //Convert date to correct format string
            return dateFormatter.string(from: date)
        }
        return nil
    }
}







