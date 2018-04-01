//
//  Post.swift
//  DSNewsfeed
//
//  Created by Amanda Tomasetti on 3/18/18.
//  Copyright © 2018 Amanda Tomasetti. All rights reserved.
//

import Foundation
class Post {
    private var author : Author
    private var title : String
    private var description : String
    private var createdDate : String
    
    init(){
        author = Author()
        title = ""
        description = ""
        createdDate = ""
    }
    
    func printPost() {
        print("Tile: \(title)")
        print("Description: \(description)")
        print("Author: \(author.getName())")
        print("Author Image: \(author.getProfileImageUrl)")
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
    
    //MARK: Getter meathods
    /***************************************************************/
    
    func getAuthor() -> Author{
        return self.author
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
}

