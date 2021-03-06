//
//  FormTable.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 6/3/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AEViewModel

struct FormTable: Table {
    
    // MARK: Types
    
    enum Cell: String {
        case username
        case password
        case accept
        case register
        
        var item: BasicItem {
            switch self {
            case .username:
                return BasicItem(identifier: rawValue, title: "Username")
            case .password:
                return BasicItem(identifier: rawValue, title: "Password")
            case .accept:
                return BasicItem(identifier: rawValue, title: "Accept Terms")
            case .register:
                return BasicItem(identifier: rawValue, title: "Register")
            }
        }
    }
    
    // MARK: Table
    
    var title = "Registration"
    var sections: [Section]
    
    init() {
        let credentials = BasicSection(items: [Cell.username.item, Cell.password.item], header: "Input")
        let actions = BasicSection(items: [Cell.accept.item, Cell.register.item], header: "Actions")
        sections = [credentials, actions]
    }
    
}
