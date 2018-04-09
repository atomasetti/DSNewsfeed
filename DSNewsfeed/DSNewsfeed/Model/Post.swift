//
//  Post.swift
//  DSNewsfeed
//
//  Created by Amanda Tomasetti on 3/18/18.
//  Copyright © 2018 Amanda Tomasetti. All rights reserved.
//

import Foundation
class Post {
    private var authorName : String
    private var title : String
    private var description : String 
    private var createdDate : String
    private var articleImage : String
    
    init(){
        authorName = ""
        title = ""
        description = ""
        createdDate = ""
        articleImage = ""
    }
    
    init(title : String, description : String, createdDate : String, articleImage : String, authorName : String){
        self.authorName = authorName
        self.title = title
        self.description = description
        self.createdDate = createdDate
        self.articleImage = articleImage
    }
    
    func printPost() {
        print("Tile: \(title)")
        print("Description: \(description)")
        print("Author: \(authorName)")
        print("Created Date: \(createdDate)")
        print("Article Image: \(articleImage)\n")
    }
    
    //MARK: Getter meathods
    /***************************************************************/
    
    func getAuthorName() -> String{
        return self.authorName
    }
    
    func getTitle() -> String{
        return self.title
    }
    
    func getDescription() -> String{
        return self.description
    }
    
    func getCreatedDate() -> String{
        return self.createdDate
    }
    
    func getarticleImage() -> String{
        return self.articleImage
    }
}

