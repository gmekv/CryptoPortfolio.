//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by Giorgi Meqvabishvili on 10.04.23.
import Foundation
import Combine


class MarketDataService {
    @Published var marketdata: MarketDataModel? = nil
    var marketdatasubscription: AnyCancellable?
    
    init() {
        getdata()
    }
    
    
    private func getdata() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }

        marketdatasubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketdata = returnedGlobalData.data
                self?.marketdatasubscription?.cancel()
            })
    }

    }
