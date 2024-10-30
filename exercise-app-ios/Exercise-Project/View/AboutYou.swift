//
//  AboutYou.swift
//  Exercise-Project
//
//  Created by Inagamjanov on 30/10/24.
//

import Drops
import SwiftUI


struct AboutYou: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user_mvvm: UserMVVM
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 25) {
                // Relationship
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 5) {
                        Text("Relationship Goals")
                            .as_font(size: .headline, weight: .semibold, color: .black)
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        TypeRow(name: "Friendship", is_selected: user_mvvm.user.relationship == .Friendship) {
                            user_mvvm.user.relationship = .Friendship
                        }
                        Divider()
                        TypeRow(name: "Dating", is_selected: user_mvvm.user.relationship == .Dating) {
                            user_mvvm.user.relationship = .Dating
                        }
                        Divider()
                        TypeRow(name: "Networking", is_selected: user_mvvm.user.relationship == .Networking) {
                            user_mvvm.user.relationship = .Networking
                        }
                    }
                    .background(.white)
                    .cornerRadius(10)
                }

                // Personality
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 5) {
                        Text("Personality Type")
                            .as_font(size: .headline, weight: .semibold, color: .black)
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        TypeRow(name: "Introverted", is_selected: user_mvvm.user.personality == .Introverted) {
                            user_mvvm.user.personality = .Introverted
                        }
                        Divider()
                        TypeRow(name: "Extroverted", is_selected: user_mvvm.user.personality == .Extroverted) {
                            user_mvvm.user.personality = .Extroverted
                        }
                    }
                    .background(.white)
                    .cornerRadius(10)
                }
                
                // Save
                Button {
                    dismiss()
                    Haptic(haptic_type: .success)
                    Drops.show(Drop(title: "Success", subtitle: "Information was saved", icon: checkmark, action: Drop.Action{Drops.hideAll()}, position: .top, duration: 2.0))
                } label: {
                    LazyVStack {
                        Text("Save")
                            .as_font(size: .headline, weight: .semibold, color: .white)
                    }
                    .padding(15)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    .padding(.vertical, 20)
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
        }
        .background(Color(.secondarySystemBackground))
    }
    
    @ViewBuilder
    func TypeRow(name: String, is_selected: Bool, on_tap: @escaping () -> Void) -> some View {
        Button {
            withAnimation {
                on_tap()
            }
        } label: {
            HStack(alignment: .center, spacing: 7) {
                Image(systemName: is_selected ? "circle.inset.filled" : "circle")
                    .as_font(size: .body, weight: .medium, color: is_selected ? Color(.systemBlue) : .black)
                
                Text(name)
                    .as_font(size: .body, weight: .medium, color: .black)
                
                Spacer(minLength: 0)
            }
            .padding(12)
        }
    }
}
