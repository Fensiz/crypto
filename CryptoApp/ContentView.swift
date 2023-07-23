//
//  ContentView.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 17.06.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
			ZStack {
				Color.theme.background
					.ignoresSafeArea()
				VStack {
					Text("Accent Color")
						.foregroundColor(Color.theme.accent)
					Text("Secondary Text Color")
						.foregroundColor(Color.theme.secondaryText)
					Text("Red Color")
						.foregroundColor(Color.theme.red)
					Text("Green Color")
						.foregroundColor(Color.theme.green)
				}
			}
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
