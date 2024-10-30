//
//  PersonalInformationView.swift
//  Exercise-Project
//
//  Created by Inagamjanov on 29/10/24.
//


import Drops
import Sliders
import SwiftUI

struct PersonalInformationView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user_mvvm: UserMVVM
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                // Hobby
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 10) {
                        Text("Hobbies")
                            .as_font(size: .headline, weight: .semibold, color: .black)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            HStack(alignment: .center, spacing: 3) {
                                Text("All")
                                    .as_font(size: .callout, weight: .regular, color: .secondary)
                                
                                Image(systemName: "chevron.right")
                                    .as_font(size: .caption, weight: .regular, color: .secondary)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 8) {
                            ForEach(hobbies, id: \.self) { each in
                                HobbyCard(each)
                            }
                        }
                    }
                    
                    HStack(alignment: .center, spacing: 5) {
                        Spacer()
                        
                        Text("\(user_mvvm.user.hobbies.count)/\(hobbies.count)")
                            .as_font(size: .caption, weight: .regular, color: .secondary)
                    }
                    .padding(.horizontal, 20)
                }
                
                // Gender
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 5) {
                        Text("Gender")
                            .as_font(size: .headline, weight: .semibold, color: .black)
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Button {
                            withAnimation {
                                user_mvvm.user.gender = .Male
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 7) {
                                Image(systemName: user_mvvm.user.gender == .Male ? "circle.inset.filled" : "circle")
                                    .as_font(size: .body, weight: .medium, color: user_mvvm.user.gender == .Male ? Color(.systemBlue) : .black)
                                
                                Text("Male")
                                    .as_font(size: .body, weight: .medium, color: .black)
                                
                                Spacer(minLength: 0)
                            }
                            .padding(12)
                        }
                        
                        Divider()
                        
                        Button {
                            withAnimation {
                                user_mvvm.user.gender = .Female
                            }
                        } label: {
                            HStack(alignment: .center, spacing: 7) {
                                Image(systemName: user_mvvm.user.gender == .Female ? "circle.inset.filled" : "circle")
                                    .as_font(size: .body, weight: .medium, color: user_mvvm.user.gender == .Female ? Color(.systemBlue) : .black)
                                
                                Text("Female")
                                    .as_font(size: .body, weight: .medium, color: .black)
                                
                                Spacer(minLength: 0)
                            }
                            .padding(12)
                        }
                    }
                    .background(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                
                // Age
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 5) {
                        Text("Age")
                            .as_font(size: .headline, weight: .semibold, color: .black)
                        
                        Spacer()
                        
                        Text("Between \(user_mvvm.user.age_range.first ?? 0) and \(user_mvvm.user.age_range.last ?? 0)")
                            .as_font(size: .caption, weight: .regular, color: .secondary)
                    }
                    
                    HStack {
                        RangeSlider(range: $user_mvvm.user.age_range, in: 10...100, step: 1)
                            .rangeSliderStyle(
                                HorizontalRangeSliderStyle(
                                    track:
                                        HorizontalRangeTrack(
                                            view: Capsule().foregroundColor(Color(.systemBlue))
                                        )
                                        .background(Capsule().foregroundColor(Color(.systemBlue).opacity(0.25)))
                                        .frame(height: 4),
                                    lowerThumb: Circle().foregroundColor(Color(.systemBlue)),
                                    upperThumb: Circle().foregroundColor(Color(.systemBlue)),
                                    lowerThumbSize: CGSize(width: 20, height: 20),
                                    upperThumbSize: CGSize(width: 20, height: 20),
                                    options: .forceAdjacentValue
                                )
                            )
                    }
                    .padding(10)
                    .background(.white)
                    .cornerRadius(15)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
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
                    .padding(20)
                }
            }
            .padding(.vertical, 15)
        }
        .background(Color(.secondarySystemBackground))
    }
    
    @ViewBuilder
    func HobbyCard(_ item: HobyScheme) -> some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: item.img)
                .font(.largeTitle)
                .padding(15)
                .background {
                    Circle()
                        .stroke(Color.black, lineWidth: 2)
                }
            
            Text(item.name)
                .as_font(size: .body, weight: .medium, color: .black, line_limit: 1)
            
            Button {
                withAnimation {
                    if (user_mvvm.user.hobbies.contains(item)) {
                        user_mvvm.user.hobbies.removeAll { lhs in
                            lhs == item
                        }
                    } else {
                        user_mvvm.user.hobbies.append(item)
                    }
                }
            } label: {
                if (user_mvvm.user.hobbies.contains(item)) {
                    Text("Selected")
                        .as_font(size: .callout, weight: .medium, color: Color(.systemBlue), line_limit: 1)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemBlue), lineWidth: 2)
                        }
                } else {
                    Text("Select")
                        .as_font(size: .callout, weight: .medium, color: .white, line_limit: 1)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBlue))
                        }
                }
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 20)
        .background(.white)
        .cornerRadius(10)
        .padding(.leading, hobbies.first == item ? 20 : 0)
        .padding(.trailing, hobbies.last ?? nil == item ? 20 : 0)
    }
}
