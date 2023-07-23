//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 18.06.2023.
//

import SwiftUI

struct CircleButtonView: View {
	
	enum ButtonIcons: String {
		case info
		case chevron = "chevron.right"
		case plus
	}
	
	let icon: ButtonIcons
	
    var body: some View {
		Image(systemName: icon.rawValue)
			.font(.headline)
			.foregroundColor(Color.theme.accent)
			.frame(width: 50, height: 50)
			.background(
				Circle()
					.foregroundColor(Color.theme.background)
			)
			.shadow(
				color: Color.theme.accent.opacity(0.5),
				radius: 10)
			.padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
		CircleButtonView(icon: .info)
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.light)
		CircleButtonView(icon: .chevron)
			.previewLayout(.sizeThatFits)
			.preferredColorScheme(.dark)
    }
}
