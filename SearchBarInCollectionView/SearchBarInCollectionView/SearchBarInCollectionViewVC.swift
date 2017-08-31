//
//  SearchBarInCollectionViewVC.swift
//  SearchBarInCollectionView
//
//  Created by appinventiv on 30/08/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//

import UIKit

class SearchBarInCollectionViewVC: UIViewController {
    
    let nameArray = ["appinventiv logo","up arrow","down arrow","walt disney","gmail","group login","group logo","single user logo","password logo blue","password logo red","colors","self pic","password logo","add user logo"]
    
    var filteredArray = [String]()
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var largeLabelName: UILabel!
    
    @IBOutlet weak var largeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        self.mySearchBar.delegate = self
        self.largeImageView.image = UIImage(named: nameArray[0])
        self.largeLabelName.text = nameArray[0]
        self.navigationItem.title = "My Gallery"
        filteredArray = nameArray
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension SearchBarInCollectionViewVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredArray = searchText.isEmpty ? nameArray : nameArray.filter { (temp: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return temp.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        }
        if filteredArray .isEmpty {
            let alert = UIAlertController(title: "Alert", message: "No Image Found:", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        myCollectionView.reloadData()
    }

}


extension SearchBarInCollectionViewVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell_ID", for: indexPath) as? CollectionCell else {
            fatalError()
        }
        cell.smallImageView.image = UIImage(named: filteredArray[indexPath.row])
        cell.layer.cornerRadius = 8
        cell.labelName.text = filteredArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.largeImageView.image = UIImage(named: filteredArray[indexPath.row])
        self.largeLabelName.text = filteredArray[indexPath.row]
    }
    
}

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var smallImageView: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    
}

