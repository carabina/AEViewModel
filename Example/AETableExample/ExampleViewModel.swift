//
//  ExampleViewModel.swift
//  AETableExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AETable

struct ExampleTable: Table {
    
    // MARK: Types
    
    enum ItemType: String {
        case form
        case settings
    }
    
    // MARK: Table
    
    let title = "Example"
    var sections: [Section] = [
        General()
    ]
    
    // MARK: Sections
    
    struct General: Section {
        
        // MARK: Section
        
        var header: String?
        var footer: String?
        var items: [Item] = [
            Form(),
            Settings()
        ]
        
        // MARK: Items
        
        struct Form: Item {
            let identifier = ItemType.form.rawValue
            var data: ItemData? = BasicItemData(title: "Form", detail: "Static Table View Model")
            var table: Table? = FormTable()
        }
        
        struct Settings: Item {
            let identifier = ItemType.settings.rawValue
            var data: ItemData? = BasicItemData(title: "Settings", detail: "JSON Table View Model")
            var table: Table? = MappableTable.Settings
        }
        
    }
    
}