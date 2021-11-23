//
//  DetailPageViewController.swift
//  TheMilkyWay
//
//  Created by Ernest Nyumbu on 2021/11/23.
//

import Foundation
import UIKit
import Combine

class DetailPageViewController : UIViewController {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var photoImageView : UIImageView!
    
    
    private var cancellable: AnyCancellable?
    public var itemVM: ItemViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = itemVM.title
        subtitleLabel.text = itemVM.subtitle
        descriptionLabel.text = itemVM.dataDescription
        
        cancellable = itemVM.loadImage(for: itemVM.photo).sink { [unowned self] image in
            self.photoImageView.image = image
            
        }
    }
    
}
