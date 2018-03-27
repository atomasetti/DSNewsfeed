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
        // Do any additional setup after loading the view, typically from a nib.
        
        getJSONData ()
        tableView.register(PostCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishedDataRequest(){
        for post in postsArray {
            post.printPost()
        }
        navigationItem.title = "Posts"
        self.tableView.reloadData()
    }
    
    //MARK: Http Request
    /***************************************************************/
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
                newPost.setCreatedDate(createdDate: post["createdDate"] as! String)
                
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostCell()
        cell.titleLabel.text = postsArray[indexPath.row].title
        return cell
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
        return label
    }()
    
    func setupViews() {
        addSubview(titleLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : titleLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : titleLabel]))
    }
    
}






