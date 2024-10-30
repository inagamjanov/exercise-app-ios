//
//  CountryView.swift
//  Exercise-Project
//
//  Created by Inagamjanov on 30/10/24.
//

import Drops
import SwiftUI


// MARK: - Region
struct Country: Identifiable {
    var id: String
    var name: String
    var flag: String
}


// MARK: - Get Regions
func get_regions() -> Array<Country> {
    var regions: Array<Country> = []
    let locale_regions = Locale.Region.isoRegions
    
    for each_region in locale_regions[29...] {
        regions.append(Country(id: each_region.identifier,
                               name: Locale.current.localizedString(forRegionCode: each_region.identifier) ?? "Unknown",
                               flag: String(String.UnicodeScalarView(each_region.identifier.unicodeScalars.compactMap({UnicodeScalar(127397 + $0.value)})))))
    }
    
    return regions.sorted { $0.name.lowercased() < $1.name.lowercased() }
}
func region_pp(_ country_code: String) -> String {
    let name = Locale.current.localizedString(forRegionCode: country_code.uppercased()) ?? "Unknown"
    let flag = String(String.UnicodeScalarView(country_code.uppercased().unicodeScalars.compactMap({UnicodeScalar(127397 + $0.value)})))
    return "\(flag) \(name)"
}


struct CountryView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var user_mvvm: UserMVVM
    
    @State var search_text: String = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 7) {
                Text(search_text.isEmpty ? "All countries" : "Results for '\(search_text)'")
                    .as_font(weight: .semibold)
                    .padding(.horizontal, 10)
                
                VStack(spacing: 10) {
                    let search_result = local_search()
                    
                    if search_result.isEmpty {
                        HStack(spacing: 10) {
                            Text("Region not found")
                                .as_font(weight: .medium)
                            Spacer()
                        }
                    }
                    else {
                        ForEach(Array(zip(search_result.indices, search_result)), id: \.0) { idx, region in
                            let is_selected = (user_mvvm.user.country?.uppercased() == region.id.uppercased())
                            
                            Button {
                                user_mvvm.user.country = region.id.uppercased()
                            } label: {
                                HStack(spacing: 10) {
                                    Image(systemName: is_selected ? "circle.inset.filled" : "circle")
                                        .foregroundColor(is_selected ? Color(.systemBlue) : .primary)
                                    Text(region_pp(region.id))
                                        .as_font()
                                    Spacer()
                                    Text("\(region.id.uppercased())")
                                        .as_font(color: .gray)
                                }
                                .background(.white)
                            }
                            
                            if (idx+1) != search_result.count {
                                Divider()
                            }
                        }
                    }
                }
                .padding(10)
                .background(.white)
                .cornerRadius(10)
            }
            .padding(20)
        }
        .background(Color(.secondarySystemBackground))
        .toolbar {
            ToolbarItem {
                Button {
                    dismiss()
                    Haptic(haptic_type: .success)
                    Drops.show(Drop(title: "Success", subtitle: "Country was saved", icon: checkmark, action: Drop.Action{Drops.hideAll()}, position: .top, duration: 2.0))
                } label: {
                    Text("Save")
                }
            }
        }
        .searchable(text: $search_text, prompt: "Search"){}
    }

    func local_search() -> Array<Country> {
        if search_text.isEmpty {
            return all_region
        } else {
            var output: Array<Country> = []
            for region in all_region {
                let v1 = region.name.lowercased().contains(search_text.lowercased())
                let v2 = region.id.lowercased().contains(search_text.lowercased())
                if v1 || v2 {
                    output.append(region)
                }
            }
            return output
        }
    }
}
