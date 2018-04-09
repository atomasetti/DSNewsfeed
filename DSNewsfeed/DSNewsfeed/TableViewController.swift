//
//  ViewController.swift
//  DSNewsfeed
//
//  Created by Amanda Tomasetti on 3/17/18.
//  Copyright © 2018 Amanda Tomasetti. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    
    var postsArray : [Post] = [Post]()
    let cellIdentifier = "PostCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Posts"
        getJSONData ()
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Http Request
    func getJSONData() {
        Alamofire.request("https://www.dysiopen.com/v1/posts/public", method:.get).responseJSON {
            response in
            if response.result.isSuccess, let value = response.result.value {
                let JSONresponse : JSON = JSON(value)
                if let JOSNData = JSONresponse.rawString(){
                    self.ParsingJSONData(JSONData: JOSNData)
                    self.tableView.reloadData()
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostTableCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = postsArray[indexPath.row].getTitle()
        cell.descriptionLabel.text = postsArray[indexPath.row].getDescription()
        cell.createdDateLabel.text = postsArray[indexPath.row].getCreatedDate()
        cell.authorNameLabel.text = postsArray[indexPath.row].getAuthorName()
    
        if let url = URL(string: postsArray[indexPath.row].getarticleImage()), let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                cell.articleImageView.image = image
            cell.articleImageView.autoresizesSubviews = true
        }
        return cell
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







