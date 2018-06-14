//
//  NewsTableViewCell.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/15/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionTitleLabel: UILabel!
    @IBOutlet var articleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
