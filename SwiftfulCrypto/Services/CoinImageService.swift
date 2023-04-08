//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Giorgi Meqvabishvili on 08.04.23.
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
    private let imageName: String
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    
    private func getCoinImage() {
        if let savedimage =  fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = savedimage
            print("Retrieved image from File Manager!")
        } else {
            DownloadCoinImage()
            print("Download image now")
        }
    }
    
    private func DownloadCoinImage() {
        guard let url = URL(string: coin.image)
      else {return}
      
      imageSubscription = NetworkingManager.download(url: url)
          .tryMap({ (data) -> UIImage? in
              return UIImage(data: data)
          })
          .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnImage) in
              guard let self = self, let downloadedImage = returnImage else { return }
              self.image = downloadedImage
              self.imageSubscription?.cancel()
              self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
          })
    }
    
    
}
