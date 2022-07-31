//
//  RecordView.swift
//  VisionExample
//
//  Created by Scarlet on 31/7/2022.
//  Copyright © 2022 Google Inc. All rights reserved.
//

import UIKit
import SVProgressHUD

class RecordView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var records: [[Record]] = []
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return records.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecordCell else {return UICollectionViewCell()}
        
        let record = records[indexPath.row]
        
        switch record.first!.mealType {
        case "Breakfast":
            cell.mealType.image = UIImage(systemName: "sunrise")
        case "Lunch":
            cell.mealType.image = UIImage(systemName: "sun.max")
        case "Dinner":
            cell.mealType.image = UIImage(systemName: "moon.stars")
        case "Others":
            cell.mealType.image = UIImage(systemName: "clock")
        default:
            return UICollectionViewCell()
        }
        
        let dF = DateFormatter()
        dF.dateFormat = "yyyy-MM-dd HH:mm"
        dF.locale = NSLocale.current
        dF.timeZone = TimeZone(abbreviation: "HKT")
        cell.title.text = "\(record.first!.mealType) - \(record.first!.foodType)"
        let duration = record.last!.timestamp - record.first!.timestamp
        let hr = duration.asHours()
        var min = duration.asMinutes()
        var sec: Double = duration
        var str = ""
        if hr > 1 {
            str += "\(Int(floor(hr)))h "
            min = min - floor(hr) * 60
        }
        if min > 1 {
            str += "\(Int(floor(min)))m "
            sec = sec - floor(min) * 60
        }
        str += "\(Int(floor(sec)))s"
        
        
        cell.desc.text = "\(dF.string(from: record.first!.timestamp))\nDuration: \(str)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 92)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let items = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil).filter{$0.lastPathComponent.hasSuffix(".csv")}
            for item in items {
                let content = try String(contentsOf: item)
                var r: [Record] = []
                content.components(separatedBy: "\n").forEach({
                    let str = $0.components(separatedBy: ",")
                    if
                        let timestamp: Double = Double(str[0]),
                        let mouthDistance: Double = Double(str[3]),
                        let mouthMovement: Int = Int(str[4]),
                        let leftShoulderCoor: [Double] = str[5].components(separatedBy: ":").map({ s in
                            return Double(s)
                        }) as? [Double],
                        let leftWristCoor: [Double] = str[6].components(separatedBy: ":").map({ s in
                            return Double(s)
                        }) as? [Double],
                        let leftElbowCoor: [Double] = str[7].components(separatedBy: ":").map({ s in
                            return Double(s)
                        }) as? [Double],
                        let leftHandMovement: Int = Int(str[8]),
                        let rightShoulderCoor: [Double] = str[9].components(separatedBy: ":").map({ s in
                            return Double(s)
                        }) as? [Double],
                        let rightWristCoor: [Double] = str[10].components(separatedBy: ":").map({ s in
                            return Double(s)
                        }) as? [Double],
                        let rightElbowCoor: [Double] = str[11].components(separatedBy: ":").map({ s in
                            return Double(s)
                        }) as? [Double],
                        let rightHandMovement: Int = Int(str[12])
                        
                    {
                        let ts = Date(timeIntervalSince1970: timestamp / 1000)
                        let mealType = str[1]
                        let foodType = str[2]
                        let mM = mouthMovement == 1
                        let leftHand = leftHandMovement == 1
                        let rightHand = rightHandMovement == 1
                        let leftShoulder = CGPoint(x: leftShoulderCoor[0], y: leftShoulderCoor[1])
                        let leftWrist = CGPoint(x: leftWristCoor[0], y: leftWristCoor[1])
                        let leftElbow = CGPoint(x: leftElbowCoor[0], y: leftElbowCoor[1])
                        let rightShoulder = CGPoint(x: rightShoulderCoor[0], y: rightShoulderCoor[1])
                        let rightWrist = CGPoint(x: rightWristCoor[0], y: rightWristCoor[1])
                        let rightElbow = CGPoint(x: rightElbowCoor[0], y: rightElbowCoor[1])
                        
                        r.append(Record(timestamp: ts, mealType: mealType, foodType: foodType, mouthDistance: mouthDistance, mouthMovement: mM, leftShoulderCoordinate: leftShoulder, leftWristCoordinate: leftWrist, leftElbowCoordinate: leftElbow, leftHandMovement: leftHand, rightShoulderCoordinate: rightShoulder, rightWristCoordinate: rightWrist, rightElbowCoordinate: rightElbow, rightHandMovement: rightHand))
                        
                    }
                    
                })
                records.append(r)
            }
            title = "Records"
            collectionView.reloadData()
        } catch {
            print(error.localizedDescription)
            SVProgressHUD.showError(withStatus: "Error reading directory")
            navigationController?.popViewController(animated: true)
        }
    }
    
}

class RecordCell: UICollectionViewCell {
    @IBOutlet weak var mealType: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
}
