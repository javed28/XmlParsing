//
//  ViewController.swift
//  XmlParsing
//
//  Created by JAVED SIDDIQUE on 09/05/20.
//  Copyright © 2020 JAVED SIDDIQUE. All rights reserved.
//

import UIKit

struct RSSItem{
    var title : String
    var description : String
    var pubDate : String
}

class FeedViewController: UIViewController {

    @IBOutlet var tblFeed : UITableView!
    
    private var rssItems : [RSSItem]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let objHttpUtility = HttpUtility()
        objHttpUtility.getApiData(request: URL(string: "https://developer.apple.com/news/rss/news.rss")!, completionHandler: {
            (data) in

            let feedParser = FeedParser()
            feedParser.parserRssData(data: data, completionHandler: {
                (data) in
                self.rssItems = data
                print("rss item---",self.rssItems![0].title)
                
                OperationQueue.main.addOperation {
                    self.tblFeed.reloadSections(IndexSet(integer: 0), with: .left)
                }
            })
        })
    }

}

extension FeedViewController : UITableViewDelegate{
    
}
extension FeedViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let rssItems = rssItems else {
            return 0
        }
        
        return rssItems.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tblFeed.dequeueReusableCell(withIdentifier: "FeedIdentifier", for: indexPath) as! FeedTableViewCell
        if let item = rssItems?[indexPath.item]{
            cell.item = item
        }
        return cell
    }
    
    
}

