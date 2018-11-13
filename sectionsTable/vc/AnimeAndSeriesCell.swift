//
//  AnimeCell.swift
//  sectionsTable
//
//  Created by Nathan Ranghel on 13/10/18.
//  Copyright © 2018 Nathan Ranghel. All rights reserved.
//

import UIKit

class AnimeAndSeriesCell: UITableViewCell {
    
    var link : ViewController?
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initButtonComponent()
        
    }
    
    fileprivate func initButtonComponent() {
        let starButton = UIButton(type: .system)
        starButton.setTitle("title", for: .normal)
        starButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        starButton.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        starButton.tintColor = .yellow
        starButton.setImage( UIImage(named: "star_full"), for: .normal)
        
        starButton.addTarget(self, action: #selector(handlerMarkAsFavorite), for: .touchUpInside)
        
        accessoryView = starButton
    }
    
    @objc func handlerMarkAsFavorite(){
        link?.callMethodToCall(cell: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
