//
//  CustomTableViewCell.swift
//  TestProject
//
//  Created by Gaurav on 25/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var mediaImage = UIImageView()
    var mediaName = UILabel()
    var mediaType = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.mediaImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        self.mediaName = UILabel(frame: CGRect(x: 70, y: 10, width: 200, height: 20))
        self.mediaType = UILabel(frame: CGRect(x: 70, y: 35, width: 200, height: 20))
        
        self.mediaImage.backgroundColor = UIColor.gray
        
        
        contentView.addSubview(mediaImage)
        contentView.addSubview(mediaName)
        contentView.addSubview(mediaType)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
