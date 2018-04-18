//
//  PostsTableDataProvider.swift
//  DSNewsfeed
//
//  Created by Amanda Tomasetti on 4/14/18.
//  Copyright © 2018 Amanda Tomasetti. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class PostsTableDataProvider: NSObject, ASTableDataSource {
    
    var posts: [Post]?
    weak var tableNode: ASTableNode?
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let post = posts![indexPath.row]
        let cellNodeBlock = { () -> ASCellNode in
            return PostCellNode(post: post)
        }
        return cellNodeBlock
    }
    
    func insertNewPostsInTableView(_ posts: [Post]) {
        self.posts = posts
        
        let section = 0
        var indexPaths = [IndexPath]()
        posts.enumerated().forEach { (row, group) in
            let path = IndexPath(row: row, section: section)
            indexPaths.append(path)
        }
        tableNode?.insertRows(at: indexPaths, with: .none)
    }
}
