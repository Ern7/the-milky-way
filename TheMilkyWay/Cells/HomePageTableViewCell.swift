//
//  HomePageTableViewCell.swift
//  TheMilkyWay
//
//  Created by Ernest Nyumbu on 2021/11/23.
//

import Foundation
import UIKit
import Combine

class HomePageTableViewCell: UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var cancellable: AnyCancellable?
    
    var onReuse: () -> Void = {}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        photoImageView.image = nil
    }

}
