//
//  Colour.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColourTheme()
    static let launch = LaunchTheme()
}

struct ColourTheme {
    let accent = Color("AccentColour")
    let background = Color("BackgroundColour")
    let green = Color("GreenColour")
    let red = Color("RedColour")
    let secondaryText = Color("SecondaryTextColour")
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColour")
    let background = Color("LaunchBackgroundColour")
}
