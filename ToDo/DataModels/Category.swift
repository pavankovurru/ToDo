//
//  File.swift
//  ToDo
//
//  Created by pavan Kovurru on 1/26/20.
//  Copyright © 2020 pavan Kovurru. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    //Property
    @objc dynamic var name : String = ""
    
    //one to many relationship
    let items = List<Item>()
    
    //NOTE : In realm inverse relation ship should be explicit, Item class should have inverse relationship
}
