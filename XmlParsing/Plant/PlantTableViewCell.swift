//
//  FeedTableViewCell.swift
//  XmlParsing
//
//  Created by JAVED SIDDIQUE on 09/05/20.
//  Copyright © 2020 JAVED SIDDIQUE. All rights reserved.
//

import UIKit

class PlantTableViewCell: UITableViewCell {

    @IBOutlet var lblCommon : UILabel!
    @IBOutlet var lblBotanical : UILabel!
    @IBOutlet var lblZone : UILabel!
    
    var plantItem : Plant!{
        didSet{
            lblCommon.text = plantItem.Common
            lblBotanical.text = plantItem.Botanical
            lblBotanical.numberOfLines = 3
            lblZone.text = plantItem.Zone
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
