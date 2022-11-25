//
//  RecentComic.swift
//  Weabo
//
//  Created by yoga arie on 25/11/22.
//

import Foundation
import RealmSwift

class RecentComic: Object, Codable {
    @objc dynamic var Url = ""
    @objc dynamic var chapter = ""
    @objc dynamic var title = ""
    @objc dynamic var imgUrl = ""
}
