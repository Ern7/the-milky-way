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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var photoImageView : UIImageView!
    @IBOutlet weak var photoImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
    private var cancellable: AnyCancellable?
    public var itemVM: ItemViewModel!
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        titleLabel.text = itemVM.title
        subtitleLabel.text = itemVM.subtitle
        descriptionLabel.text = itemVM.dataDescription
        
        
        cancellable = itemVM.loadImage(for: itemVM.photo).sink { [unowned self] image in
            self.photoImageView.image = image
            
            let ratio = photoImageView.frame.size.width / image!.size.width
            let scaledHeight = image!.size.height * ratio
            self.photoImageViewHeightConstraint.constant = scaledHeight
            
            let contentHeight = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: contentHeight + 300)
        }
        
    }
}
