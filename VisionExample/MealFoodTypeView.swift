//
//  MealTypeView.swift
//  VisionExample
//
//  Created by Scarlet on 29/7/2022.
//  Copyright © 2022 Google Inc. All rights reserved.
//

import UIKit

class MealTypeView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MenuViewItemCell else {return UICollectionViewCell()}
        
        switch indexPath.row {
        case 0:
            cell.menuImg.image = UIImage(systemName: "sunrise")
            cell.menuLbl.text = "Breakfast"
        case 1:
            cell.menuImg.image = UIImage(systemName: "sun.max")
            cell.menuLbl.text = "Lunch"
        case 2:
            cell.menuImg.image = UIImage(systemName: "moon.stars")
            cell.menuLbl.text = "Dinner"
        case 3:
            cell.menuImg.image = UIImage(systemName: "clock")
            cell.menuLbl.text = "Others"
        default:
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MenuViewItemCell
        UserDefaults.standard.set(cell.menuLbl.text, forKey: "mealType")
        let food = storyboard?.instantiateViewController(withIdentifier: "foodTypeView") as! FoodTypeView
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(food, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 3 * 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meal Type"
    }
}

class FoodTypeView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
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
            cell.menuImg.image = UIImage(systemName: "cross.case")
            cell.menuLbl.text = "Solid Food"
        case 1:
            cell.menuImg.image = UIImage(systemName: "cross.case")
            cell.menuLbl.text = "Pureed Food"
        case 2:
            cell.menuImg.image = UIImage(systemName: "cross.case")
            cell.menuLbl.text = "Snacks"
        default:
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MenuViewItemCell
        UserDefaults.standard.set(cell.menuLbl.text, forKey: "foodType")
        let analyzer = storyboard?.instantiateViewController(withIdentifier: "camview") as! CameraViewController
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(analyzer, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 3 * 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Food Type"
    }
}
