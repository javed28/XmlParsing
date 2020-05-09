//
//  CDViewController.swift
//  XmlParsing
//
//  Created by JAVED SIDDIQUE on 09/05/20.
//  Copyright © 2020 JAVED SIDDIQUE. All rights reserved.
//

import UIKit

class CDViewController: UIViewController {

     @IBOutlet var tblCD : UITableView!
        private var cdItems : [CD]?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            let objHttpUtility = HttpUtility()
            objHttpUtility.getApiData(request: URL(string: "https://www.w3schools.com/xml/cd_catalog.xml")!, completionHandler: {
                (data) in
                
                let cdParser = CDParser()
                cdParser.parserCDData(data: data, completionHandler: {
                    (data) in
                    self.cdItems = data
                    OperationQueue.main.addOperation {
                        self.tblCD.reloadSections(IndexSet(integer: 0), with: .left)
                    }
                })
            })
        }
    }

    extension CDViewController : UITableViewDelegate{
        
    }
    extension CDViewController : UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            guard let cdItems = cdItems else {
                return 0
            }
            
            return cdItems.count
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell  = tblCD.dequeueReusableCell(withIdentifier: "CDIdentifier", for: indexPath) as! CDTableViewCell
            if let item = cdItems?[indexPath.item]{
                cell.cdItem = item
            }
            return cell
        }
        
        
    }
