//
//  UserMVVM.swift
//  Exercise-Project
//
//  Created by Inagamjanov on 30/10/24.
//

import Foundation


struct UserScheme: Codable, Hashable, Identifiable {
    var id: String = UUID().uuidString
    
    var hobbies: Array<HobyScheme> = []
    
    var gender: Gender? = nil
    var age_range: ClosedRange = 18...28
    
    var country: String? = nil
    
    var relationship: Relationship? = nil
    var personality: Personality? = nil
}


struct HobyScheme: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString
    
    var name: String
    var img: String
}


enum Gender: Int, Codable {
    case Male, Female
}


enum Relationship: Int, Codable {
    case Friendship, Dating, Networking
}


enum Personality: Int, Codable {
    case Introverted, Extroverted
}


let hobbies: Array<HobyScheme> = [
    HobyScheme(name: "Football", img: "square.3.layers.3d"),
    HobyScheme(name: "Basketball", img: "square.3.layers.3d"),
    HobyScheme(name: "Swim", img: "square.3.layers.3d"),
    HobyScheme(name: "Handball", img: "square.3.layers.3d"),
    HobyScheme(name: "Golf", img: "square.3.layers.3d"),
    HobyScheme(name: "Run", img: "square.3.layers.3d"),
    HobyScheme(name: "Hockey", img: "square.3.layers.3d"),
    HobyScheme(name: "Read", img: "square.3.layers.3d"),
    HobyScheme(name: "Coding", img: "square.3.layers.3d"),
    HobyScheme(name: "Walk", img: "square.3.layers.3d"),
    HobyScheme(name: "Travel", img: "square.3.layers.3d"),
    HobyScheme(name: "Work", img: "square.3.layers.3d"),
    HobyScheme(name: "Chess", img: "square.3.layers.3d"),
    HobyScheme(name: "Shopping", img: "square.3.layers.3d"),
    HobyScheme(name: "Other", img: "square.3.layers.3d")
]


class UserMVVM: ObservableObject {
    
    @Published var user: UserScheme = UserScheme()
    
}
