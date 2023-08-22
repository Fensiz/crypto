//
//  Test1.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 26.07.2023.
//

import SwiftUI

struct DismissButton: View {
	
	@Environment(\.dismiss) private var dismiss
	
	var body: some View {
		Button("Dismiss Me") {
			dismiss()
		}
	}
}

struct DismissingView2: View {

	var body: some View {
		NavigationStack {
//		NavigationView {
			ScrollView {
				VStack {
					DismissButton()
				}
			}
		}
	}
}

struct Test1: View {
	@State private var showingDetail = false

	var body: some View {
		Button("Show Detail") {
			showingDetail = true
		}
		.sheet(isPresented: $showingDetail) {
			DismissingView2()
		}
	}
}

struct Test1_Previews: PreviewProvider {
    static var previews: some View {
        Test1()
    }
}
