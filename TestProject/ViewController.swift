//
//  ViewController.swift
//  TestProject
//
//  Created by Gaurav on 25/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var mediasListTableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initControls()
        
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
        return 10;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell

    
        cell.mediaName.text = "Test \(indexPath.row)"
        cell.mediaType.text = "Test Details \(indexPath.row)"
        
        return cell
    }
    
    //MARK:- Tableview Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }


}

