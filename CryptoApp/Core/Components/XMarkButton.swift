//
//  XMarkButton.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 26.07.2023.
//

import SwiftUI

struct XMarkButton: View {
	@Environment(\.dismiss) private var dismiss
	
    var body: some View {
		Button {
			dismiss()
		} label: {
			Image(systemName: "xmark")
				.padding(7)
				.background(Color.theme.secondaryText.opacity(0.3).cornerRadius(10))
		}
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
