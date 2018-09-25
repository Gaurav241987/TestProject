//
//  ViewController.swift
//  TestProject
//
//  Created by Gaurav on 25/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var mediasListTableView:UITableView!
    
    var iTunesData:Array = [[String: Any]]()
    var mediaType:String = "Apple Music"
    
    var appleMusicButton:UIButton!
    var iTunesMusicButton:UIButton!
    var iOSAppsButton:UIButton!
    
    var titleLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initControls()
        self.getData()
        
    }
    
    private func initControls() {
        
        var yPosition:CGFloat = iPhoneX_TopPadding;
        
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: iPhoneX_TopPadding, width: UIScreen.main.bounds.width, height: 30))
        self.titleLabel.text = "MUSIC"
        self.titleLabel.backgroundColor = UIColor.gray
        self.titleLabel.font = UIFont(name: "Arial", size: 22)
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(self.titleLabel)
        
        let buttonWidth = (UIScreen.main.bounds.size.width-60)/3;
        
        var xPosition:CGFloat = 20;
        yPosition = yPosition + 40;
        
        self.appleMusicButton = UIButton(frame: CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: 30))
        self.appleMusicButton.setTitle("Apple Music", for: .normal)
        self.appleMusicButton.titleLabel?.font = UIFont(name: "Arial", size: 12)
        self.appleMusicButton.tag = 1
        self.appleMusicButton.backgroundColor = UIColor.darkGray
        self.appleMusicButton.addTarget(self, action:#selector(buttonPressed(sender:)), for: .touchUpInside)
        self.view.addSubview(self.appleMusicButton)
        
        xPosition = xPosition + buttonWidth + 10
        
        self.iTunesMusicButton = UIButton(frame: CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: 30))
        self.iTunesMusicButton.setTitle("iTunes Music", for: .normal)
        self.iTunesMusicButton.titleLabel?.font = UIFont(name: "Arial", size: 12)
        self.iTunesMusicButton.tag = 2
        self.iTunesMusicButton.backgroundColor = UIColor.lightGray
        self.iTunesMusicButton.addTarget(self, action:#selector(buttonPressed(sender:)), for: .touchUpInside)
        self.view.addSubview(self.iTunesMusicButton)
        
        xPosition = xPosition + buttonWidth + 10
        
        self.iOSAppsButton = UIButton(frame: CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: 30))
        self.iOSAppsButton.setTitle("iOS Apps", for: .normal)
        self.iOSAppsButton.backgroundColor = UIColor.lightGray
        self.iOSAppsButton.titleLabel?.font = UIFont(name: "Arial", size: 12)
        self.iOSAppsButton.tag = 3
        self.iOSAppsButton.addTarget(self, action:#selector(buttonPressed(sender:)), for: .touchUpInside)
        self.view.addSubview(self.iOSAppsButton)
        
        yPosition = yPosition + 40;
        
        self.mediasListTableView = UITableView(frame: CGRect(x:0.0, y: yPosition, width:  UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-yPosition), style: .plain)
        self.mediasListTableView.delegate = self
        self.mediasListTableView.dataSource = self
        self.mediasListTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.mediasListTableView)
        
        
        self.mediasListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraints([
            
            NSLayoutConstraint(item: self.mediasListTableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: iPhoneX_TopPadding+80),
            NSLayoutConstraint(item: self.mediasListTableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.mediasListTableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: self.mediasListTableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0),
            ])
        
    }
    
    //MARK:- Tableview Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.iTunesData.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell

        let myDic = self.iTunesData[indexPath.row] as [String:Any]
    
        cell.mediaImage.loadAsyncFrom(url: myDic["artworkUrl100"]! as! String, placeholder: UIImage(named: "PlaceholderIcon"))
        
        cell.mediaName.text = myDic["name"]! as? String
        cell.mediaType.text = myDic["MediaType"]! as? String
        
        
        return cell
    }
    
    //MARK:- Tableview Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    //MARK:- WebService
    func getData(){
        
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        view.addSubview(activity)
        activity.center=view.center
        activity.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        var mediaTypeParameterURLString:String = ""
        
        if mediaType == "Apple Music" {
            mediaTypeParameterURLString = "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/10/explicit.json"
        } else if mediaType == "iTunes Music" {
            mediaTypeParameterURLString = "https://rss.itunes.apple.com/api/v1/us/itunes-music/hot-tracks/all/10/explicit.json"
        } else if mediaType == "iOS Apps" {
            mediaTypeParameterURLString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/10/explicit.json"
        }
        
        let parametersDic:Parameters = ["Country":"United States","Media Type":mediaType,"Feed Type":"Coming Soon","Genre":"All","Results limit":"10","Format":"JSON"]
        
        
        Alamofire.request(mediaTypeParameterURLString,method:.get,parameters:parametersDic).responseJSON {
            response in
            
            print(response.result.value)
            
            switch response.result {
            case .success:
                
                self.iTunesData.removeAll()
                
                if let objJson = response.result.value as! NSDictionary! {
                    
                    
                    if let objJson2 = objJson["feed"] as! NSDictionary! {
                        
                        
                         if let objJson3 = objJson2["results"] as! NSArray! {
                            
                            for ele in objJson3 {
                                
                                let dt = ele as? [String:Any]
                                
                                var myDic = [String:Any]()
                                myDic["name"] = dt!["name"]! as? String
                                myDic["artworkUrl100"] = dt!["artworkUrl100"]! as? String
                                myDic["MediaType"] = self.mediaType
                                
                                self.iTunesData.append(myDic)
                                
                                
                            }
                            
                            
                        }
                    
                        
                    }
                
                    
                }
                
                self.mediasListTableView.reloadData()

            case .failure(let error):
                print("Error: \(error)")
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                let okbutton = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    print("You've pressed default");
                }
                
                
                alertController.addAction(okbutton)
                self.present(alertController, animated: true, completion: nil)
            }
            
            activity.stopAnimating()
            activity.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }

    //MARK:- actions
    @objc func buttonPressed(sender: UIButton) {
        
        if sender.tag == 1 {
            // apple music
            mediaType = "Apple Music"
            
            self.appleMusicButton.backgroundColor = UIColor.darkGray
            self.iTunesMusicButton.backgroundColor = UIColor.lightGray
            self.iOSAppsButton.backgroundColor = UIColor.lightGray
        } else if sender.tag == 2 {
            // iTunes Music
            mediaType = "iTunes Music"
            
            self.appleMusicButton.backgroundColor = UIColor.lightGray
            self.iTunesMusicButton.backgroundColor = UIColor.darkGray
            self.iOSAppsButton.backgroundColor = UIColor.lightGray
            
        } else if sender.tag == 3 {
            // ios Apps
            mediaType = "iOS Apps"
            
            self.appleMusicButton.backgroundColor = UIColor.lightGray
            self.iTunesMusicButton.backgroundColor = UIColor.lightGray
            self.iOSAppsButton.backgroundColor = UIColor.darkGray
        }
        
        self.getData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        var buttonWidth:CGFloat = 0.0;
        var yPosition:CGFloat = iPhoneX_TopPadding;
        
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
           
            buttonWidth = (UIScreen.main.bounds.size.height-60)/3;
            self.titleLabel.frame = CGRect(x: 0, y: iPhoneX_TopPadding, width: UIScreen.main.bounds.height, height: 30)
            
        } else {
            print("Portrait")
            
            buttonWidth = (UIScreen.main.bounds.size.height-60)/3;
            self.titleLabel.frame = CGRect(x: 0, y: iPhoneX_TopPadding, width: UIScreen.main.bounds.height, height: 30)
        }
        
        
        var xPosition:CGFloat = 20;
        yPosition = yPosition + 40;
        
        self.appleMusicButton.frame = CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: 30)
        
        xPosition = xPosition + buttonWidth + 10
        
        self.iTunesMusicButton.frame = CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: 30)
        
        xPosition = xPosition + buttonWidth + 10
        
        
        self.iOSAppsButton.frame = CGRect(x: xPosition, y: yPosition, width: buttonWidth, height: 30)
        
    }
    

}



