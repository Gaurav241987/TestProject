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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initControls()
        self.getData()
        
    }
    
    private func initControls() {
        
        self.mediasListTableView = UITableView(frame: CGRect(x:0.0, y: 0.0, width:  UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        self.mediasListTableView.delegate = self
        self.mediasListTableView.dataSource = self
        self.mediasListTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.mediasListTableView)
        
        
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
        
        let parametersDic:Parameters = ["Country":"United States","Media Type":"Apple Music","Feed Type":"Coming Soon","Genre":"All","Results limit":"10","Format":"JSON"]
        
        
        Alamofire.request("https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json",method:.get,parameters:parametersDic).responseJSON {
            response in
            
            print(response.result.value)
            
            switch response.result {
            case .success:
                
                if let objJson = response.result.value as! NSDictionary! {
                    
                    
                    if let objJson2 = objJson["feed"] as! NSDictionary! {
                        
                        
                        // if let objJsn3 = try JSONSerialization.jsonObject(with: objJson2["results"], options: []) as? [Any] {
                         if let objJson3 = objJson2["results"] as! NSArray! {
                            
                            for ele in objJson3 {
                                
                                let dt = ele as? [String:Any]
                                
                                var myDic = [String:Any]()
                                myDic["name"] = dt!["name"]! as? String
                                myDic["artworkUrl100"] = dt!["artworkUrl100"]! as? String
                                myDic["MediaType"] = "Apple Music"
                                
                                self.iTunesData.append(myDic)
                                
                                
                            }
                            
                            
                        }
                    
                        
                    }
                
                    
                }
                
                self.mediasListTableView.reloadData()

            case .failure(let error):
                print("Error: \(error)")
            }
            
            activity.stopAnimating()
            activity.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }


}

