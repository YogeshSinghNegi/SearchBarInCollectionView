//
//  SearchBarInCollectionViewVC.swift
//  SearchBarInCollectionView
//
//  Created by appinventiv on 30/08/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//

import UIKit

//=============================================================//
//MARK: SearchBarInCollectionViewVC Class
//=============================================================//

class SearchBarInCollectionViewVC: UIViewController {
    
//=============================================================//
//MARK: Stored Properties
//=============================================================//
    
    // Array contains the names of the images
    let nameArray = ["appinventiv logo","up arrow","down arrow","walt disney","gmail","group login","group logo","single user logo","password logo blue","password logo red","colors","self pic","password logo","add user logo"]
    
    // Array to store filtered Data
    var filteredArray = [String]()
    
//=============================================================//
//MARK: Defining IBOutlets
//=============================================================//
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var largeLabelName: UILabel!
    
    @IBOutlet weak var largeImageView: UIImageView!
    
//=============================================================//
//MARK: View Method
//=============================================================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        self.mySearchBar.delegate = self
        // Setting the default image and label value
        self.largeImageView.image = UIImage(named: self.nameArray[0])
        self.largeLabelName.text = self.nameArray[0]
        self.navigationItem.title = "My Gallery"
        self.filteredArray = self.nameArray
        self.myCollectionView.backgroundColor = UIColor.clear
    }

}

//=================================================================//
//MARK: SearchBarInCollectionViewVC Class Extension for UISearchController
//=================================================================//

extension SearchBarInCollectionViewVC: UISearchBarDelegate{
    
//=================================================================//
//MARK: Filtering data according to the text entered in the Search Bar
//=================================================================//
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredArray = searchText.isEmpty ? self.nameArray : self.nameArray.filter { (temp: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return temp.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        if self.filteredArray .isEmpty {
            let alert = UIAlertController(title: "Alert", message: "No Image Found:", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        self.myCollectionView.reloadData()
    }

}

//====================================================================//
//MARK: SearchBarInCollectionViewVC Class Extension for UICollectionView
//====================================================================//

extension SearchBarInCollectionViewVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
//=============================================================//
//MARK: Setting Number Of Items
//=============================================================//
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredArray.count
    }
    
//=============================================================//
//MARK: Setting the Items
//=============================================================//
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell_ID", for: indexPath) as? CollectionCell else {
            fatalError("Cell Failed to load")
        }
        cell.smallImageView.image = UIImage(named: self.filteredArray[indexPath.row])
        // Setting the corner edges of the ImageView
        cell.layer.cornerRadius = 8
        cell.labelName.text = self.filteredArray[indexPath.row]
        return cell
    }
    
//=============================================================//
//MARK: Showing the Selected Images
//=============================================================//
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.largeImageView.image = UIImage(named: self.filteredArray[indexPath.row])
        self.largeLabelName.text = self.filteredArray[indexPath.row]
    }
    
}

//=============================================================//
//MARK: Class for Cell UIViews
//=============================================================//

class CollectionCell: UICollectionViewCell {
    
//=============================================================//
//MARK: UICollectionViewCell IBOutlets
//=============================================================//
    
    @IBOutlet weak var smallImageView: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    
}

