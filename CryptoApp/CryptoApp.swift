//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 17.06.2023.
//

import SwiftUI

@main
struct CryptoApp: App {
	
	@StateObject var vm = HomeViewModel()
	
	init() {
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
	}
	
    var body: some Scene {
        WindowGroup {
			NavigationView {
				HomeView()
					.environmentObject(vm)
					.toolbar(.hidden)
			}
        }
    }
}
