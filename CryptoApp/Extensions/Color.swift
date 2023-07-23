//
//  Color.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 18.06.2023.
//

import Foundation
import SwiftUI

extension Color {
	static let theme = ColorTheme()
}

struct ColorTheme {
	let accent = Color("AccentColor")
	let background = Color("Background")
	let green = Color("GreenColor")
	let red = Color("RedColor")
	let secondaryText = Color("SecondaryTextColor")
}
