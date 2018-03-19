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

class ViewController: UIViewController {
    var postsArray : [Post] = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        getJSONData(url : "https://www.dysiopen.com/v1/posts/public")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishedDataRequest(){
        for post in postsArray{
            post.printPost()
        }
    }

    //MARK: Http Request
    /***************************************************************/
    func getJSONData(url : String) {
        Alamofire.request(url, method:.get).responseJSON {
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
    
}









