//
//  HomePageTableViewController.swift
//  TheMilkyWay
//
//  Created by Ernest Nyumbu on 2021/11/23.
//

import Foundation
import UIKit
import Combine

class HomePageTableViewController : UITableViewController {
    
    //View Model
    var itemListViewModel = ItemListViewModel()
    
    //Observers
    var imageObservers: [AnyCancellable] = []
    
    //Segue Names
    let showDetailPageSegue = "showDetailPageSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchItems()
    }
    
    private func fetchItems(){
        
        WebService.shared.load(resource: NasaResponse.all) { [weak self] result in
            switch result {
            case .success(let nasaResponse):
                print(nasaResponse)
                self?.itemListViewModel.itemsViewModel = nasaResponse.collection.items.map(ItemViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "That didn't work!", message: error.localizedDescription, preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                        self?.fetchItems()
                    }))

                    self?.present(alert, animated: true)
                }
            }
        }
        
    }
    
    // MARK: - TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemListViewModel.itemsViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vm = self.itemListViewModel.itemViewModel(at: indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? HomePageTableViewCell else {
            fatalError()
        }
        cell.titleLabel?.text = vm.title
        cell.subtitleLabel?.text = vm.subtitle
        
        cell.cancellable = vm.loadImage(for: vm.photo).sink { [unowned self] image in
            cell.photoImageView.image = image
        }
        return cell
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == showDetailPageSegue,
            let destination = segue.destination as? DetailPageViewController,
            let selectedIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.itemVM = self.itemListViewModel.itemViewModel(at: selectedIndex)
        }
    }
}
