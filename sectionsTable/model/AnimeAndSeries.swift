//
//  AnimeAndSeries.swift
//  sectionsTable
//
//  Created by Nathan Ranghel on 13/10/18.
//  Copyright © 2018 Nathan Ranghel. All rights reserved.
//

import Foundation

struct ExpandableNames {
    
    var isExpanded : Bool
    var names : [AnimesAndSeries]
}

struct AnimesAndSeries {
    
    var name : String
    var hasFavorited : Bool
    var genre : String
   
}
