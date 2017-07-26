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
            Characters(title: "", featuredImage: UIImage(named: "f1")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "f2")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "f3")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "f4")!, color: .clear),
            
            Characters(title: "", featuredImage: UIImage(named: "f5")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "f6")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "f7")!, color: .clear),
            Characters(title: "", featuredImage: UIImage(named: "f8")!, color: .clear),
        ]
    }
}
