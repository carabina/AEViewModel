//
//  WiFiSettingsTVC.swift
//  TableExample
//
//  Created by Marko Tadić on 4/20/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

class WiFiSettingsTVC: ViewController {
    
    // MARK: - Types
    
    enum CellType: String {
        case wifiSwitch
        case wifiNetwork
        case joinNetworksSwitch
    }
    
    // MARK: - Override
    
    override func cellStyle(forIdentifier identifier: String) -> Cell.Style {
        if let cellType = CellType(rawValue: identifier) {
            switch cellType {
            case .wifiSwitch:
                return .toggle
            case .wifiNetwork:
                return .basic
            case .joinNetworksSwitch:
                return .toggle
            }
        } else {
            return .basic
        }
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: TableCell) {
        if let cellType = CellType(rawValue: item.identifier) {
            switch cellType {
            case .wifiSwitch, .joinNetworksSwitch:
                if event == .valueChanged {
                    print("handleEvent with id: \(item.identifier)")
                }
            case .wifiNetwork:
                let tmvc = ViewController(style: .grouped)
                pushSubmenu(with: item, in: tmvc)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func pushSubmenu(with item: Item, in tmvc: ViewController) {
        if let table = item.table {
            tmvc.model = table
            navigationController?.pushViewController(tmvc, animated: true)
        }
    }
    
}
