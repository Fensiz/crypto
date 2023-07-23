//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 16.07.2023.
//

import SwiftUI

struct StatisticView: View {
	
	let stat: StatisticModel
	
    var body: some View {
		VStack(alignment: .leading, spacing: 4) {
			Text(stat.title)
				.font(.caption)
				.foregroundColor(Color.theme.secondaryText)
			Text(stat.value)
				.font(.headline)
				.foregroundColor(Color.theme.accent)
			if let change = stat.percentageChange {
				HStack {
					Image(systemName: change == 0 ? "minus" : "triangle.fill")
						.font(.caption2)
						.rotationEffect(.degrees(change < 0 ? 180 : 0))
					Text(change.asPercentString())
						.font(.caption)
						.bold()
				}
				.foregroundColor(change == 0 ? Color.theme.accent : change < 0 ? .red : .green)
			}
		}
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
		StatisticView(stat: dev.stat1)
    }
}
