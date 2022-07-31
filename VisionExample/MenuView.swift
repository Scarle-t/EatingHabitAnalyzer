//
//  MenuView.swift
//  VisionExample
//
//  Created by Scarlet on 29/7/2022.
//  Copyright © 2022 Google Inc. All rights reserved.
//

import UIKit

class MenuView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MenuViewItemCell else {return UICollectionViewCell()}
        
        switch indexPath.row {
        case 0:
            cell.menuImg.image = UIImage(systemName: "camera.viewfinder")
            cell.menuLbl.text = "Start Analyzer"
        case 1:
            cell.menuImg.image = UIImage(systemName: "list.bullet.rectangle")
            cell.menuLbl.text = "View Records"
        case 2:
            cell.menuImg.image = UIImage(systemName: "gear.circle")
            cell.menuLbl.text = "Settings"
        default:
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var v: UIViewController!
        switch indexPath.row {
        case 0:
            v = storyboard?.instantiateViewController(withIdentifier: "mealTypeView") as! MealTypeView
        case 1:
            v = storyboard?.instantiateViewController(withIdentifier: "recordView") as! RecordView
        case 2:
            v = storyboard?.instantiateViewController(withIdentifier: "setting") as! SettingsView
        default:
            return
        }
        navigationController?.pushViewController(v, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 3 * 2)
    }
    
}

class MenuViewItemCell: UICollectionViewCell {
    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet weak var menuLbl: UILabel!
}
