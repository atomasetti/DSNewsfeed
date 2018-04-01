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
    let cellIdentifier = "rootCells"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONData ()
        tableView.register(PostCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Http Request
    func getJSONData() {
        Alamofire.request("https://www.dysiopen.com/v1/posts/public", method:.get).responseJSON {
            response in
            if response.result.isSuccess {
                let JSONresponse : JSON = JSON(response.result.value!)
                if let JSONStr = JSONresponse.rawString(){
                    self.ParsingJSONData(JSONData : JSONStr)
                    self.finishedDataRequest()
                }
            }
            else {
                print("Error \(response.result.error)")
            }
        }
    }
    
    func ParsingJSONData(JSONData : String) {
        
        let data = JSONData.data(using: String.Encoding.utf16, allowLossyConversion: false)!
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            let JSONPosts = json?["posts"] as! [AnyObject]
            for post in JSONPosts {
                
                let newPost = Post()
                newPost.setTitle(title: post["title"] as! String)
                newPost.setDescription(description: post["description"] as! String)
                newPost.setCreatedDate(createdDate: formatDate(strDate : post["createdDate"] as! String))
                
                let authorInfo = post["author"] as! NSDictionary
                let author = Author()
                author.setName(name: authorInfo["postSourceName"] as! String)
                if let profileImage = authorInfo["profileImageUrl"] as? String {
                    // profileImage is not nil
                    author.setProfileImageUrl(profileImageUrl: profileImage)
                }
                
                newPost.setAuthor(author: author)
                postsArray.append(newPost)
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func finishedDataRequest(){
        navigationItem.title = "Posts"
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostCell()
        cell.titleLabel.text = postsArray[indexPath.row].getTitle()
        cell.descriptionLabel.text = postsArray[indexPath.row].getDescription()
        cell.createdDateLabel.text = postsArray[indexPath.row].getCreatedDate()
        cell.authorNameLabel.text = postsArray[indexPath.row].getAuthor().getName()
        
        if let url = URL(string: postsArray[indexPath.row].getAuthor().getProfileImageUrl()), let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                cell.authorImage.contentMode = .scaleAspectFit
                cell.authorImage.image = image
        }
        return cell
    }
    
    func formatDate(strDate : String) -> String {
        
        let dateFormatter = DateFormatter()
        //Current date format
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        //Current time zone
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        //Convert String to Date
        let date = dateFormatter.date(from: strDate)
        
        //New date format
        dateFormatter.dateFormat = "MMM d, yyyy   h:m a"
        //Convert date to correct format string
        let newDate = dateFormatter.string(from: date!)
        return newDate
    }
}

class PostCell : UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize + 1)
        
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let createdDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let authorNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let authorImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func setupViews() {
        
        //adding subviews to the table cell
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(createdDateLabel)
        addSubview(authorImage)
        addSubview(authorNameLabel)
        
        let viewsDictionary = ["titleLabel": titleLabel, "descriptionLabel": descriptionLabel, "createdDateLabel": createdDateLabel, "authorNameLabel": authorNameLabel, "authorImage" : authorImage]
        
        //Horizontal constraints
        for item in viewsDictionary.keys {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[\(item)]|", options: [], metrics: nil, views: viewsDictionary))
        }
        
        //Vertical constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[titleLabel]-[descriptionLabel]-[createdDateLabel]-[authorNameLabel]-[authorImage]-10-|", options: [], metrics: nil, views: viewsDictionary))
    }
}





