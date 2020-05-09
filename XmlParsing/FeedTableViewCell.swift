//
//  FeedTableViewCell.swift
//  XmlParsing
//
//  Created by JAVED SIDDIQUE on 09/05/20.
//  Copyright © 2020 JAVED SIDDIQUE. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var lblDesc : UILabel!
    @IBOutlet var lblDate : UILabel!
    
    var item : RSSItem!{
        didSet{
            lblTitle.text = item.title
            lblDesc.text = item.description
            lblDesc.numberOfLines = 3
            lblDate.text = item.pubDate
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
