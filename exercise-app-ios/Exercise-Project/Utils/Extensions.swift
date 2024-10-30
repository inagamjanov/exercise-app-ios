//
//  Extensions.swift
//  Exercise-Project
//
//  Created by Inagamjanov on 29/10/24.
//

import SwiftUI


extension View {
    
    func as_font(size: Font.TextStyle = .body, weight: Font.Weight = .regular, color: Color = .black, line_limit: Int = Int.max, align: TextAlignment = .leading, design: Font.Design? = .default) -> some View {
        self
            .font(.system(size, design: design).weight(weight))
            .foregroundColor(color)
            .lineLimit(line_limit)
            .multilineTextAlignment(align)
    }
}
