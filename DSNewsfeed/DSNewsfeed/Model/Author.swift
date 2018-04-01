//
//  Author.swift
//  DSNewsfeed
//
//  Created by Amanda Tomasetti on 3/18/18.
//  Copyright © 2018 Amanda Tomasetti. All rights reserved.
//

import Foundation
class Author {
    private var name : String
    private var profileImageUrl : String
    
    init() {
        self.name = ""
        self.profileImageUrl = ""
    }
    
    //MARK: Setter meathods
    /***************************************************************/
    
    func setName (name : String){
        self.name = name
    }
    
    func setProfileImageUrl (profileImageUrl : String){
        self.profileImageUrl = profileImageUrl
    }
    
    //MARK: Getter meathods
    /***************************************************************/
    
    func getName () -> String{
        return self.name
    }
    
    func getProfileImageUrl () -> String{
        return self.profileImageUrl
    }
}

