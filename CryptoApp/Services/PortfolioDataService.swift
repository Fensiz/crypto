//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 01.08.2023.
//

import Foundation
import CoreData

class PortfolioDataService {
	
	private let container: NSPersistentContainer
	private let containerName: String = "PortfolioContainer"
	private let entityName: String = "PortfolioEntity"
	
	@Published var savedEntities: [PortfolioEntity] = []
	
	init() {
		container = NSPersistentContainer(name: containerName)
		container.loadPersistentStores { _, error in
			if let error = error {
				print("Error loading CoreData: \(error.localizedDescription)")
			}
		}
	}
	
	private func getPortfolio() {
		let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
		do {
			savedEntities = try container.viewContext.fetch(request)
		} catch let error {
			print("Error fetching PortfolioEntity: \(error.localizedDescription)")
		}
	}
	
	private func add(coin: CoinModel, amount: Double) {
		let entity = PortfolioEntity(context: container.viewContext)
		entity.coinID = coin.id
		entity.amount = amount
	}
	
	private func save() {
		do {
			try container.viewContext.save()
		} catch let error {
			print("Error saving to CoreData: \(error.localizedDescription)")
		}
	}
	
	private func applyChanges() {
		save()
		getPortfolio()
	}
}
