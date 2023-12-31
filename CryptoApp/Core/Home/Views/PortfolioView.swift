//
//  PortfolioViews.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 26.07.2023.
//

import SwiftUI

struct PortfolioView: View {
	
	@EnvironmentObject private var vm: HomeViewModel
	@State private var selectedCoin: CoinModel? = nil
	@State private var quantityText: String = ""
	@State private var showCheckmark: Bool = false
	
    var body: some View {
		NavigationStack {
			ScrollView {
				VStack {
					SearchBarView(searchText: $vm.searchText)
					coinLogoList
					if selectedCoin != nil {
						portfolioInputSection
					}
				}
			}
			.navigationTitle("Edit Portfolio")
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					XMarkButton()
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					trailingNavBarButtons
				}
			}
			.onChange(of: vm.searchText) { newValue in
				if newValue.isEmpty {
					removeSelectedCoin()
				}
			}
		}
	
    }
}

struct PortfolioViews_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}

extension PortfolioView {
	private var coinLogoList: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			LazyHStack(spacing: 20) {
				ForEach(vm.allCoins) { coin in
					CoinLogoView(coin: coin)
						.frame(width: 75)
						.padding(4)
						.onTapGesture {
							withAnimation(.easeIn) {
								selectedCoin = coin
							}
						}
						.background(
							RoundedRectangle(cornerRadius: 10)
								.stroke(selectedCoin?.id == coin.id ? Color.theme.green : .clear, lineWidth: 1)
						)
				}
			}
			.padding(.vertical, 4)
			.padding(.leading)
		}
	}
	
	private func getCurrentValue() -> Double {
		if let quantity = Double(quantityText) {
			return quantity * (selectedCoin?.currentPrice ?? 0)
		}
		return 0
	}
	
	private var portfolioInputSection: some View {
		VStack(spacing: 20) {
			HStack {
				Text("Current price of \(selectedCoin!.symbol.uppercased()):")
				Spacer()
				Text(selectedCoin!.currentPrice.asCurrencyWith6Decimals())
			}
			Divider()
			HStack {
				Text("Amount holding:")
				Spacer()
				TextField("Ex: 1.4", text: $quantityText)
					.multilineTextAlignment(.trailing)
					.keyboardType(.decimalPad)
			}
			Divider()
			HStack {
				Text("Current value:")
				Spacer()
				Text(getCurrentValue().asCurrencyWith2Decimals())
			}
		}
		.animation(.none)
		.padding()
		.font(.headline)
	}
	
	private var trailingNavBarButtons: some View {
		HStack(spacing: 10) {
			Image(systemName: "checkmark")
				.opacity(showCheckmark ? 1 : 0)
			Button {
				saveButtonPressed()
			} label: {
				Text("Save".uppercased())
			}
			.opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1 : 0)
			
		}
		.font(.headline)
	}
	
	private func saveButtonPressed() {
		guard let coin = selectedCoin else { return }
		
		withAnimation(.easeIn) {
			showCheckmark = true
			removeSelectedCoin()
		}
		
		UIApplication.shared.endEditing()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			withAnimation(.easeOut) {
				showCheckmark = false
			}
		}
	}
	private func removeSelectedCoin() {
		selectedCoin = nil
		vm.searchText = ""
	}
}
