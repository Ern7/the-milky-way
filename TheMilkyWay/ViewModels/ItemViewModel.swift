//
//  ItemViewModel.swift
//  TheMilkyWay
//
//  Created by Ernest Nyumbu on 2021/11/23.
//

import Foundation
import Combine
import UIKit

class ItemListViewModel {
    var itemsViewModel: [ItemViewModel]
    init(){
        self.itemsViewModel = [ItemViewModel]()
    }
}

extension ItemListViewModel {
    
    func itemViewModel(at index: Int) -> ItemViewModel {
        return self.itemsViewModel[index]
    }
}

struct ItemViewModel {
    let item: Item
}

extension ItemViewModel {
    
    var title: String {
        if self.item.data.count > 0 {
            return self.item.data[0].title
        }
        return ""
    }
    
    var subtitle: String {
        if self.item.data.count > 0 {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            let dateCreated = dateFormatter.date(from: self.item.data[0].dateCreated)
            
            dateFormatter.dateFormat = "dd MMM, yyyy"
            let friendlyDate = dateFormatter.string(from: dateCreated!)
            
            var _subtitle: String = ""
            if (self.item.data[0].photographer != nil){
                _subtitle = _subtitle + self.item.data[0].photographer!
            }
            
            if _subtitle.count > 0 {
                _subtitle = _subtitle + " | " + friendlyDate
            }
            else {
                _subtitle = friendlyDate
            }
            
            return _subtitle
        }
        return ""
    }
    
    var photo: String {
        if self.item.links.count > 0 {
            return self.item.links[0].href
        }
        return ""
    }
    
    var dataDescription: String {
        if self.item.links.count > 0 {
            return self.item.data[0].datumDescription
        }
        return ""
    }
    
    func loadImage(for url: String) -> AnyPublisher<UIImage?, Never> {
        return Just(url)
        .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            let url = URL(string: url)!
            return ImageLoader.shared.loadImage(from: url)
        })
        .eraseToAnyPublisher()
    }
}
