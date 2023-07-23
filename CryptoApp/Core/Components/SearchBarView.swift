//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 16.07.2023.
//

import SwiftUI

struct SearchBarView: View {
	
	@Binding var searchText: String
	
    var body: some View {
		HStack {
			Image(systemName: "magnifyingglass")
				.foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
			TextField("Search by name or symbol...", text: $searchText)
				.autocorrectionDisabled(true)
				.foregroundColor(Color.theme.accent)
				.padding(.trailing, 25)
		}
		.overlay(alignment: .trailing) {
			if !searchText.isEmpty {
				Image(systemName: "xmark.circle.fill")
					.foregroundColor(Color.theme.accent)
					.onTapGesture {
						UIApplication.shared.endEditing()
						searchText = ""
					}
			}
		}
		.font(.headline)
		.padding ()
		.background(
			RoundedRectangle(cornerRadius: 25)
				.fill(Color.theme.background)
				.shadow(
					color: Color.theme.accent.opacity(0.15),
					radius: 10, x: 0, y: 0)
		)
		.padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
		SearchBarView(searchText: .constant(""))
    }
}
