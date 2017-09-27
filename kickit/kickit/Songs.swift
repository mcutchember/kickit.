//
//  Songs.swift
//  kickit
//
//  Created by Myle$ on 7/26/17.
//  Copyright © 2017 Myle$. All rights reserved.
//

import Foundation
import UIKit

class Songs
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
    
    static func fetchInterests() -> [Songs]
    {
        return [
            Songs(title: "Kickit", featuredImage: UIImage(named: "s1")!, color: .clear),
            Songs(title: "gamestop", featuredImage: UIImage(named: "s4")!, color: .clear),
            Songs(title: "kickit2", featuredImage: UIImage(named: "s2")!, color: .clear),
            Songs(title: "rainbow", featuredImage: UIImage(named: "s5")!, color: .clear),
            Songs(title: "kickit3", featuredImage: UIImage(named: "s3")!, color: .clear),
        ]
    }
}
