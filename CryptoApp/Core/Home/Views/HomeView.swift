//
//  HomeView.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 18.06.2023.
//

import SwiftUI

struct HomeView: View {
	
	@State private var showPortfolio: Bool = false
	@State private var showPortfolioView: Bool = false
	@EnvironmentObject private var vm: HomeViewModel
	
    var body: some View {
		ZStack {
			Color.theme.background
				.ignoresSafeArea()
				.sheet(isPresented: $showPortfolioView) {
					PortfolioView()
						.environmentObject(vm)
				}
			VStack {
				homeHeader
				
				HomeStatView(showPortfolio: $showPortfolio)
				
				SearchBarView(searchText: $vm.searchText)
				
				columnTitles
				
				if !showPortfolio {
					allCoinsList
						.transition(.move(edge: .leading))
				} else {
					portfolioCoinsList
						.transition(.move(edge: .trailing))
				}
				Spacer(minLength: 0)
			}
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
			.environmentObject(DeveloperPreview.instance.homeVM)
    }
}

extension HomeView {
	private var homeHeader: some View {
		VStack {
			HStack {
				CircleButtonView(icon: showPortfolio ? .plus : .info)
					.animation(.none, value: showPortfolio)
					.background(
						CircleButtonAnimationView(animate: $showPortfolio)
					)
					.onTapGesture {
						if showPortfolio {
							showPortfolioView = true
						}
					}
				Spacer()
				Text(showPortfolio ? "Portfolio" : "Live Prices")
					.font(.headline)
					.fontWeight(.heavy)
					.foregroundColor(Color.theme.accent)
					.animation(.none, value: showPortfolio)
				Spacer()

				CircleButtonView(icon: .chevron)
					.rotationEffect(.degrees(showPortfolio ? 180 : 0))
					.onTapGesture {
						withAnimation(.spring()) {
							showPortfolio.toggle()
						}
					}
			}
			.padding(.horizontal)
		}
	}
	private var allCoinsList: some View {
		List {
			ForEach(vm.allCoins) { coin in
				CoinRowView(coin: coin, showHoldingsColumn: true)
					.listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
			}
		}
		.listStyle(.plain)
	}
	private var portfolioCoinsList: some View {
		List {
			ForEach(vm.portfolioCoins) { coin in
				CoinRowView(coin: coin, showHoldingsColumn: true)
					.listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
			}
		}
		.listStyle(.plain)
	}
	private var columnTitles: some View {
		HStack {
			Text("Coin")
			Spacer()
			if showPortfolio {
				Text("Holdings")
			}
			Text("Price")
				.frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
		}
		.font(.caption)
		.foregroundColor(Color.theme.secondaryText)
		.padding(.horizontal)
//		.padding(.leading, 40)
	}
}
