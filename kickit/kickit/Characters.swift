//
//  Characters.swift
//  kickit
//
//  Created by Myle$ on 7/26/17.
//  Copyright © 2017 Myle$. All rights reserved.
//

import Foundation
import UIKit

class Characters
{
    // MARK: - Public API
    var title = ""
    var featuredImage: UIImage
    var color: UIColor
    
    init(title: String, featuredImage: UIImage, color: UIColor)
    {
        self.title = title
        self.featuredImage = featuredImage
        self.color = color
    }
    
    // MARK: - Private
    
    static func fetchInterests() -> [Characters]
    {
        return [
            Characters(title: "", featuredImage: UIImage(named: "earth")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "girl")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "angel")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "cat")!, color: .clear),
            
            Characters(title: "", featuredImage: UIImage(named: "eat")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "mink")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "julian1")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "julian")!, color: .clear),
        ]
    }
}
