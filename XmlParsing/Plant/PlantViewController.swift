//
//  ViewController.swift
//  XmlParsing
//
//  Created by JAVED SIDDIQUE on 09/05/20.
//  Copyright © 2020 JAVED SIDDIQUE. All rights reserved.
//

import UIKit



class PlantViewController: UIViewController {
    
    @IBOutlet var tblPlant : UITableView!
    private var plantItems : [Plant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let objHttpUtility = HttpUtility()
        objHttpUtility.getApiData(request: URL(string: "https://www.w3schools.com/xml/plant_catalog.xml")!, completionHandler: {
            (data) in
            
            let plantParser = PlantParser()
            plantParser.parserPlantData(data: data, completionHandler: {
                (data) in
                self.plantItems = data
                OperationQueue.main.addOperation {
                    self.tblPlant.reloadSections(IndexSet(integer: 0), with: .left)
                }
            })
        })
    }
}

extension PlantViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Plant.To.CD", sender: self)
    }
}
extension PlantViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let plantItems = plantItems else {
            return 0
        }
        
        return plantItems.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tblPlant.dequeueReusableCell(withIdentifier: "PlantIdentifier", for: indexPath) as! PlantTableViewCell
        if let item = plantItems?[indexPath.item]{
            cell.plantItem = item
        }
        return cell
    }
    
    
}

