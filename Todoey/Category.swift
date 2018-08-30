//
//  Category.swift
//  Todoey
//
//  Created by Gourav Nayyar on 24/08/18.
//  Copyright © 2018 Gourav Nayyar. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
