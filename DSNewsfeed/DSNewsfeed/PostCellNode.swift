//
//  PostCellNode.swift
//  DSNewsfeed
//
//  Created by Amanda Tomasetti on 4/14/18.
//  Copyright © 2018 Amanda Tomasetti. All rights reserved.
//

import Foundation
import AsyncDisplayKit

fileprivate var articleImageSize:CGFloat = 160

final class PostCellNode: ASCellNode {
    
    fileprivate var articleImageView: ASNetworkImageNode!
    fileprivate var titleLabel: ASTextNode!
    fileprivate var authorNameLabel: ASTextNode!
    fileprivate var descriptionLabel: ASTextNode!
    fileprivate var createdDateLabel: ASTextNode!
    
    init(post: Post) {
        super.init()
        
        articleImageView = ASNetworkImageNode()
        articleImageView.clipsToBounds = true
        articleImageView?.url = URL(string: post.getarticleImage())
        
        titleLabel = createLayerBackedTextNode(attributedString: NSAttributedString(string: post.getTitle(), attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 13)!, NSAttributedStringKey.foregroundColor: UIColor.darkGray]))

        descriptionLabel = createLayerBackedTextNode(attributedString: NSAttributedString(string: post.getDescription(), attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 12)!, NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
        
        authorNameLabel = createLayerBackedTextNode(attributedString: NSAttributedString(string: post.getAuthorName(), attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 12)!, NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
        
        createdDateLabel = createLayerBackedTextNode(attributedString: NSAttributedString(string: post.getCreatedDate(), attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 12)!, NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
        
        automaticallyManagesSubnodes = true
    }
    
    fileprivate func createLayerBackedTextNode(attributedString: NSAttributedString) -> ASTextNode {
        let textNode = ASTextNode()
        textNode.isLayerBacked = true
        textNode.attributedText = attributedString
        
        return textNode
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        articleImageView.style.preferredSize = CGSize(width: articleImageSize, height: articleImageSize)
        
        let stack = ASStackLayoutSpec.vertical()
        stack.children = [titleLabel, descriptionLabel, authorNameLabel, createdDateLabel, articleImageView]

        return stack
    }
    
}
