//
//  Songs.swift
//  kickit
//
//  Created by Myle$ on 9/24/17.
//  Copyright © 2017 Myle$. All rights reserved.
//



import Foundation
import UIKit

class Songs
{
    // MARK: - Public API
    var title = ""
    var song: Bundle
    var color: UIColor
    
    init(title: String, song: Bundle, color: UIColor)
    {
        self.title = title
        self.song = song
        self.color = color
    }
    
    // MARK: - Private
    
    static func fetchInterests() -> [Songs]
    {
        return [
//            Songs(title: "", featuredImage: UIImage(named: "f1")!, color: .clear),
//            Songs(title: "", featuredImage: UIImage(named: "f2")!, color: .clear),
//            Songs(title: "", featuredImage: UIImage(named: "f3")!, color: .clear),
//            Songs(title: "", featuredImage: UIImage(named: "f4")!, color: .clear),
//            Songs(title: "", featuredImage: UIImage(named: "f5")!, color: .clear),
        ]
    }
}
