//
//  PostCellNode.swift
//  DSNewsfeed
//
//  Created by Amanda Tomasetti on 4/14/18.
//  Copyright © 2018 Amanda Tomasetti. All rights reserved.
//

import Foundation
import AsyncDisplayKit


final class PostCellNode: ASCellNode {
    
    private var articleImageView: ASNetworkImageNode?
    private var titleLabel: ASTextNode?
    private var descriptionLabel: ASTextNode?
    private var authorNameLabel: ASTextNode?
    private var createdDateLabel: ASTextNode?
    
    init(post: Post) {

        super.init()
        articleImageView = ASNetworkImageNode()
        articleImageView?.clipsToBounds = true
        articleImageView?.url = URL(string: post.getarticleImage())

        titleLabel = ASTextNode()
        descriptionLabel = ASTextNode()
        authorNameLabel = ASTextNode()
        createdDateLabel = ASTextNode()
        
        titleLabel = createLayerBackedTextNode(attributedString: NSAttributedString(string: post.getTitle(), attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 17) as Any, NSAttributedStringKey.foregroundColor: UIColor.darkGray]))

        descriptionLabel = createLayerBackedTextNode(attributedString: NSAttributedString(string: post.getDescription(), attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 16) as Any, NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
        
        authorNameLabel = createLayerBackedTextNode(attributedString: NSAttributedString(string: post.getAuthorName(), attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 16) as Any, NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
        
        createdDateLabel = createLayerBackedTextNode(attributedString: NSAttributedString(string: post.getCreatedDate(), attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 16) as Any, NSAttributedStringKey.foregroundColor: UIColor.darkGray]))
        
        automaticallyManagesSubnodes = true
    }
    
    fileprivate func createLayerBackedTextNode(attributedString: NSAttributedString) -> ASTextNode {
        let textNode = ASTextNode()
        textNode.isLayerBacked = true
        textNode.attributedText = attributedString
        
        return textNode
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let verticalStack = ASStackLayoutSpec.vertical()
        guard let title = titleLabel, let description = descriptionLabel,let authorName = authorNameLabel, let createdDate = createdDateLabel, let articleImage = articleImageView else {
            return verticalStack
        }
        
        let cellWidth = constrainedSize.max.width
        articleImageView?.style.preferredSize = CGSize(width: cellWidth, height: cellWidth)
        
        //Formatting article image
        let articleImageViewLayout = ASAbsoluteLayoutSpec(children: [articleImage])
        let articleImageViewStack = ASStackLayoutSpec.vertical()
        articleImageViewStack.alignItems = ASStackLayoutAlignItems.stretch
        articleImageViewStack.children = [articleImageViewLayout]
        
        //Adding buffer
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let titleLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10), child: title)
        let descriptionLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10), child: description)
        let createdDateLayout = ASInsetLayoutSpec(insets: insets, child: createdDate)
        let authorNameLayout = ASInsetLayoutSpec(insets: insets, child: authorName)
        let articleImageLayout = ASInsetLayoutSpec(insets: insets, child: articleImageViewStack)

        verticalStack.children = [titleLayout, descriptionLayout, authorNameLayout, createdDateLayout, articleImageLayout]
        return verticalStack

    }
    
}
