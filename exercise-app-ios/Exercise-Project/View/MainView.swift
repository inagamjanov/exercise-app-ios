//
//  MainView.swift
//  Exercise-Project
//
//  Created by Inagamjanov on 29/10/24.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        NavigationStack {
            MainPage()
                .navigationTitle("Main")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainPage: View {
    var body: some View {
        List {
            Section {
                NavigationLink {
                    PersonalInformationView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Informations")
                } label: {
                    label(img: "person.and.background.dotted", name: "Personal information")
                }
                
                NavigationLink {
                    CountryView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Select Country")
                } label: {
                    label(img: "globe.europe.africa.fill", name: "Country")
                }
                
                NavigationLink {
                    AboutYou()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("About You")
                } label: {
                    label(img: "person.crop.circle.dashed", name: "About You")
                }
                
                NavigationLink {
                    StreamView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Stream")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarColorScheme(.light, for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                } label: {
                   label(img: "camera.viewfinder", name: "Stream")
                }
            } header: {
                Text("Properties")
            } footer: {
                Text("Please fill or select the properties for more informations")
            }
        }
    }
    
    @ViewBuilder
    func label(img: String, name: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: img)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
            Text(name)
                .as_font(size: .callout, weight: .medium, color: .black, line_limit: 1)
        }
    }
}
