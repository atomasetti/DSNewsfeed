//
//  Author.swift
//  DSNewsfeed
//
//  Created by Amanda Tomasetti on 3/18/18.
//  Copyright © 2018 Amanda Tomasetti. All rights reserved.
//

import Foundation
class Author {
    var name : String
    var profileImageUrl : String
    
    init() {
        name = ""
        profileImageUrl = ""
    }
    
    //MARK: Setter meathods
    /***************************************************************/
    
    func setName (name : String){
        self.name = name
    }
    
    func setProfileImageUrl (profileImageUrl : String){
        self.profileImageUrl = profileImageUrl
    }
}
