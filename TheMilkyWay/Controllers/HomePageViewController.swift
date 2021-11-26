//
//  HomePageViewController.swift
//  TheMilkyWay
//
//  Created by Ernest Nyumbu on 2021/11/24.
//

import Foundation
import UIKit
import Combine


class HomePageViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    //View Model
    var itemListViewModel = ItemListViewModel()
    
    //Observers
    var imageObservers: [AnyCancellable] = []
    
    //Segue Names
    let showDetailPageSegue = "showDetailPageSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.largeTitleDisplayMode = .always
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        fetchItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func fetchItems(){
        showLoader()
        WebService.shared.load(resource: NasaResponse.all) { [weak self] result in
            self?.hideLoader()
            switch result {
            case .success(let nasaResponse):
                
                if (nasaResponse.collection.items.count == 0){
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Empty!", message: "No Nasa data was found on the server.", preferredStyle: .alert)

                            alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                                self?.fetchItems()
                            }))

                            self?.present(alert, animated: true)
                        }
                }
                else {
                    self?.itemListViewModel.itemsViewModel = nasaResponse.collection.items.map(ItemViewModel.init)
                    self?.tableView.reloadData()
                }
            case .failure(let error):
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemListViewModel.itemsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    //MARK: - Loader
    private func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorView.startAnimating()
        }
    }
    
    private func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
}
