//
//  HomeStatView.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 21.07.2023.
//

import SwiftUI

struct HomeStatView: View {
	
	@EnvironmentObject private var vm: HomeViewModel
	@Binding var showPortfolio: Bool

    var body: some View {
		HStack {
			ForEach(vm.statistics) { stat in
				StatisticView(stat: stat)
					.frame(width: UIScreen.main.bounds.width / 3)
			}
		}
		.frame(width: UIScreen.main.bounds.width,
			   alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatView_Previews: PreviewProvider {
    static var previews: some View {
		HomeStatView(showPortfolio: .constant(false))
			.environmentObject(dev.homeVM)
    }
}
