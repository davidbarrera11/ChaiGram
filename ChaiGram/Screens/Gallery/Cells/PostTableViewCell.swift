//
//  PostTableViewCell.swift
//  ChaiGram
//
//  Created by Chaii on 20/06/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setImage(image: UIImage) {
        self.postImageView.image = image
    }
}
