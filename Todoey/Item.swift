//
//  Item.swift
//  Todoey
//
//  Created by Gourav Nayyar on 24/08/18.
//  Copyright © 2018 Gourav Nayyar. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {

    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()

    // Create an inverse relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
