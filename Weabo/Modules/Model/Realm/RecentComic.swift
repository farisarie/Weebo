//
//  RecentComic.swift
//  Weabo
//
//  Created by yoga arie on 25/11/22.
//

import Foundation
import RealmSwift

class RecentComic: Object {
    @Persisted(primaryKey: true) var _id = ObjectId()
    @Persisted var Url = ""
    @Persisted var chapter = ""
    @Persisted var title = ""
    @Persisted var imgUrl = ""
    @Persisted var userid = ""
    var parentCategory = LinkingObjects(fromType: User.self, property: "recentComics")
}
