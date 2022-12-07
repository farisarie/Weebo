//
//  User.swift
//  Weabo
//
//  Created by yoga arie on 07/12/22.
//
import FirebaseAuth
import Foundation
import RealmSwift

class User: Object {
    @Persisted var username: String = ""
    @Persisted var email: String = ""
    @Persisted(primaryKey: true) var userid: String = ""
  var recentComics = List<RecentComic>()
    
    override static func primaryKey() -> String? {
        return "userId"
      }
      
      class func saveUserData() {
        let user = Auth.auth().currentUser
        
        let userData = User()
        userData.userid = user?.uid ?? ""
        userData.username = user?.displayName ?? ""
        userData.email = user?.email ?? ""
        
        let realm = try! Realm()
        try! realm.write {
          realm.add(userData, update: .modified)
        }
      }
    }




