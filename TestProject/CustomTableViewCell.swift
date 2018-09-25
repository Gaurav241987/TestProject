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
    
    var mediaImage = AyncImageView()
    var mediaName = UILabel()
    var mediaType = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.mediaImage = AyncImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        self.mediaName = UILabel(frame: CGRect(x: 70, y: 10, width: UIScreen.main.bounds.size.width-90, height: 20))
        self.mediaType = UILabel(frame: CGRect(x: 70, y: 35, width: UIScreen.main.bounds.size.width-90, height: 20))
        
        self.mediaImage.backgroundColor = UIColor.gray
        self.mediaImage.layer.cornerRadius = 5
        self.mediaImage.layer.masksToBounds = true
        
        contentView.addSubview(mediaImage)
        contentView.addSubview(mediaName)
        contentView.addSubview(mediaType)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 'asyncImagesCashArray' is a global varible cashed UIImage
var asyncImagesCashArray = NSCache<NSString, UIImage>()

class AyncImageView: UIImageView {
    
    //MARK: - Variables
    private var currentURL: NSString?
    
    //MARK: - Public Methods
    
    func loadAsyncFrom(url: String, placeholder: UIImage?) {
        let imageURL = url as NSString
        if let cashedImage = asyncImagesCashArray.object(forKey: imageURL) {
            image = cashedImage
            return
        }
        image = placeholder
        currentURL = imageURL
        guard let requestURL = URL(string: url) else { image = placeholder; return }
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                if error == nil {
                    if let imageData = data {
                        if self?.currentURL == imageURL {
                            if let imageToPresent = UIImage(data: imageData) {
                                asyncImagesCashArray.setObject(imageToPresent, forKey: imageURL)
                                self?.image = imageToPresent
                            } else {
                                self?.image = placeholder
                            }
                        }
                    } else {
                        self?.image = placeholder
                    }
                } else {
                    self?.image = placeholder
                }
            }
            }.resume()
    }
}
