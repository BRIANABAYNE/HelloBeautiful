//
//  CrudFunctions.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import Foundation


// MARK: - Propeties
var userDetails: UserDetails?

func userDetails(zodiacSign: String, cycleLength:String, lastCycle: String, completion: @escaping(Result<String, Error>) -> Void) {
    let userDetails = UserDetails(zodiacSign: zodiacSign, cycleLength: cycleLength, lastCycle: lastCycle, collectionType: Constants.UserDetails.userDetailsCollectionPath)
    
        }


















//var user: User?
//
//
//func create(firstName: String, lastName: String, email: String, password: String, lastCycle: String, periodLength: Int, zodiacSign: String, completion: @escaping(Result<String,FirebaseError>) -> Void) {
//    let user = User(firstName: firstName, lastName: lastName, email: email, password: password, zodiacSign: zodiacSign, lastCycle: lastCycle , collectionType: Constants.User.userCollectionPath)
//}
//
//func updateUser() {
//
//}
//
//
//
//func update(user: User) {
//    if let documentID = user.id {
//        let ref = Firestore.firestore()
//        let docRef = ref.collection(Constants.User.userCollectionPath).document(documentID)
//
//        do {
//            try docRef.setData(from: user)
//        } catch {
//            print(error)
//        }
//    }
//
//
//    func save() {
//
//    }
//
//    func fetchAllUsers() {
//
//    }
//
//    func deleteUser() {
//
//    }
//}
