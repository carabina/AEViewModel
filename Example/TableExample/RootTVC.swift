//
//  RootTVC.swift
//  TableExample
//
//  Created by Marko Tadić on 5/26/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import Table

extension Cell.ID {
    static let `static` = "static"
    static let dynamic = "dynamic"
    static let json = "json"
}

class RootTVC: TableViewController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        model = Model.Example
    }
    
    override func handleEvent(_ event: UIControlEvents, with item: Item, sender: TableCell) {
        switch item.identifier {
        case id.static:
            pushSubmenu(with: item.model, in: TableViewController())
        case id.dynamic:
            pushSubmenu(with: item.model, in: TableViewController())
        case id.json:
            pushSubmenu(with: item.model, in: SettingsTVC(style: .grouped, model: SettingsTVC.MyModel))
        default:
            break
        }
    }
    
}