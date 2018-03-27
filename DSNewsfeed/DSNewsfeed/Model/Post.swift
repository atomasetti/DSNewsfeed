//
//  Post.swift
//  DSNewsfeed
//
//  Created by Amanda Tomasetti on 3/18/18.
//  Copyright © 2018 Amanda Tomasetti. All rights reserved.
//

import Foundation
class Post {
    var author : Author
    var title : String
    var description : String
    var createdDate : String
    
    init(){
        author = Author()
        title = ""
        description = ""
        createdDate = ""
    }
    
    func printPost() {
        print("Tile: \(title)")
        print("Description: \(description)")
        print("Author: \(author.name)")
        print("Author Image: \(author.profileImageUrl)")
        print("Created Date: \(createdDate)\n")
    }
    
    //MARK: Setter meathods
    /***************************************************************/
    
    func setAuthor(author : Author){
        self.author = author
    }
    
    func setTitle(title : String){
        self.title = title
    }
    
    func setDescription(description : String){
        self.description = description
    }
    
    func setCreatedDate(createdDate : String){
        self.createdDate = createdDate
    }
    
}

