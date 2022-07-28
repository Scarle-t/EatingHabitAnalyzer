//
//  SettingsView.swift
//  VisionExample
//
//  Created by Scarlet on 27/7/2022.
//  Copyright © 2022 Google Inc. All rights reserved.
//

import UIKit

class SettingsView: UITableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DetectionSensitivityCell else {return UITableViewCell()}
        switch UserDefaults.standard.integer(forKey: "detectionSensitivity") {
        case 2:
            cell.sensitivitySwitch.selectedSegmentIndex = 2
        case 5:
            cell.sensitivitySwitch.selectedSegmentIndex = 1
        case 15:
            cell.sensitivitySwitch.selectedSegmentIndex = 0
        default:
            cell.sensitivitySwitch.selectedSegmentIndex = 1
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

class DetectionSensitivityCell: UITableViewCell {
    
    @IBOutlet weak var sensitivitySwitch: UISegmentedControl!
    
    @IBAction func sensitivityControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(15, forKey: "detectionSensitivity")
        case 1:
            UserDefaults.standard.set(5, forKey: "detectionSensitivity")
        case 2:
            UserDefaults.standard.set(2, forKey: "detectionSensitivity")
        default:
            UserDefaults.standard.set(5, forKey: "detectionSensitivity")
        }
    }
}

