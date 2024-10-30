//
//  Exercise_ProjectApp.swift
//  Exercise-Project
//
//  Created by Inagamjanov on 29/10/24.
//

import SwiftUI

@main
struct Exercise_ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            TabView()
                .environmentObject(UserMVVM())
        }
    }
}
