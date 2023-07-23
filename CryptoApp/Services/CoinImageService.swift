//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 09.07.2023.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService {
	
	@Published var image: UIImage? = nil
	
	private var imageSubscription: AnyCancellable?
	private let coin: CoinModel
	private let fileManager = LocalFileManager.instance
	private let folderName = "coin_images"
	
	init(coin: CoinModel) {
		self.coin = coin
		getCoinImage()
	}
	
	private func getCoinImage() {
		if let image = fileManager.getImage(imageName: coin.id, folderName: folderName) {
			self.image = image
			print("Retrieved image from FileManager")
		} else {
			downloadImage()
			print("Retrieved image from NetworkingManager")
		}
		
	}
	
	private func downloadImage() {
		
		print("Downloading image now")
		guard let url = URL(string: coin.image) else { return }
		
		imageSubscription = NetworkingManager.download(url: url)
			.tryMap({UIImage(data: $0)})
			.sink(receiveCompletion: NetworkingManager.handleCompetion, receiveValue: { [weak self] image in
				guard
					let self = self,
					let image = image
				else { return }
				self.image = image
				self.imageSubscription?.cancel()
				self.fileManager.saveImage(image: image, imageName: coin.id, folderName: self.folderName)
			})

	}
}
