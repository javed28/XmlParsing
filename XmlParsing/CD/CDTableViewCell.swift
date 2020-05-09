//
//  CDTableViewCell.swift
//  XmlParsing
//
//  Created by JAVED SIDDIQUE on 09/05/20.
//  Copyright © 2020 JAVED SIDDIQUE. All rights reserved.
//

import UIKit

class CDTableViewCell: UITableViewCell {

        @IBOutlet var lblTitle : UILabel!
       @IBOutlet var lblArtist : UILabel!
       @IBOutlet var lblCountry : UILabel!
       
       var cdItem : CD!{
           didSet{
               lblTitle.text = cdItem.Artist
               lblArtist.text = cdItem.Artist
               lblArtist.numberOfLines = 3
               lblCountry.text = cdItem.Country
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
