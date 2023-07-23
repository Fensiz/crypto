//
//  HeaderView.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 18.06.2023.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
		HStack {
			Spacer()
			Image(systemName: "plus")
				.resizable()
				.scaledToFit()
				.foregroundColor(Color.theme.accent)
				.frame(width: 15, height: 15)
//			Text("+")
//				.foregroundColor(Color.theme.accent)
//				.font(.title)
				.background(
					Circle()
//						.offset(x: -1, y: 1.5)
						.foregroundColor(Color.theme.background)
						.frame(width: 45, height: 45)
						.shadow(color: Color.theme.accent.opacity(0.8), radius: 5)
//						.overlay(
//							Circle()
//								.stroke()
//								.foregroundColor(Color.theme.accent)
//								.offset(y: 1)
//								.frame(width: 30, height: 30)
//						)
				)
			Spacer()
			Spacer()
			Text("Title")
				.foregroundColor(Color.theme.accent)
			Spacer()
			Spacer()
			Text("+")
				.foregroundColor(Color.theme.accent)
				.background(
					Circle()
						.offset(y: 1)
						.foregroundColor(Color.theme.background)
						.frame(width: 40, height: 40)
						.shadow(color: Color.theme.accent.opacity(0.8), radius: 5)
					)
			Spacer()
		}
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
