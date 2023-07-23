//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 16.07.2023.
//

import Foundation
import SwiftUI

extension UIApplication {
	func endEditing() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
