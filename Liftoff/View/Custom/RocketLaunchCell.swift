//
//  RocketLaunchCell.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import UIKit

class RocketLaunchCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var rocketImageView: UIImageView!
    
    var launch: RocketLaunch? {
        didSet {
            // Format Properties
            if let date = launch?.date {
                let imageAttachment =  NSTextAttachment()
                imageAttachment.image = UIImage(named:"clock")
                //Set bound to reposition
                let imageOffsetY:CGFloat = -1;
                let imageOffsetX:CGFloat = -2
                imageAttachment.bounds = CGRect(x: imageOffsetX, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
                //Create string with attachment
                let attachmentString = NSAttributedString(attachment: imageAttachment)
                //Initialize mutable string
                let completeText = NSMutableAttributedString(string: "")
                //Add image to mutable string
                completeText.append(attachmentString)
                //Add your text to mutable string
                let textAfterIcon = NSMutableAttributedString(string: String(date.dropLast(12))) // Removes the time of day.
                completeText.append(textAfterIcon)
                dateLabel.textAlignment = .right
                dateLabel.attributedText = completeText
                if let status = launch?.status {
                    let dateColor:UIColor = status == true ? UIColor(red: 0, green: 184/255, blue: 148/255, alpha: 1) : UIColor(red: 214/255, green: 48/255, blue: 49/255, alpha: 1) // ternary operator so that if the launch is not on schedule or unlikely to happen, the date of the launch will turn red
                    dateLabel.textColor = dateColor
                }
            }
            /*if let status = launch?.status {
                let statusString : String = status == true ? "On schedule" : "Unlikely to launch"
                statusLabel.text = statusString
            }*/
            if let name = launch?.name {
                let main = name.characters.split{$0 == "|"}.map(String.init)
                nameLabel.text = main[0]
            }
            if let desc = launch?.missionDesc {
                // set label to description
                descriptionLabel.text = desc
            }
            if let img = launch?.rocket?.image {
                rocketImageView.image = img
            }
        }
    }
    
    func commonInit (date: String, name : String, desc : String, img: UIImage) {
        dateLabel.text = date
        nameLabel.text = name
        descriptionLabel.text = desc
        rocketImageView.image = img
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
