//
//  Item.swift
//  ToDo
//
//  Created by pavan Kovurru on 1/26/20.
//  Copyright © 2020 pavan Kovurru. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
   
  //properties
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?


 // relationship with category , property is the name of relation ship in category class
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
