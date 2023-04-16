//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Giorgi Meqvabishvili on 06.04.23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    
    @Published var  statistics: [StatisticModel] = []
        
    
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataSerice = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    
    init(){
        addSubscribers()
        
    }
    
    
    func addSubscribers() {
        //updates all coins
        
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self]  (returnedCoins) in
                self?.allCoins = returnedCoins
                
            }
            .store(in: &cancellables)
        
//        
        // updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataSerice.$savedEntities)
            .map(mapallCoinsToPortfolioCoins)
       
            .sink {[weak self] (returnedCoins) in
                
                guard let self = self else {return}
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        
        
        
        
        
        //updates Market Data
        marketDataService.$marketdata
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self](returnedStats)  in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
        
   
    }
    
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataSerice.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getdata()
        HapticManager.notifacation(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
 
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    
    
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowerCasedText = text.lowercased()
        return coins.filter {(coin) -> Bool in return coin.name.lowercased().contains(lowerCasedText) ||
            coin.symbol.lowercased().contains(lowerCasedText) || coin.id.lowercased().contains(lowerCasedText)
        }
        
    }
    
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel])  {
        switch sort {
        case.rank, .holdings:
              coins.sort { $0.rank < $1.rank }
        case.rankReversed:
              coins.sort   { $0.rank > $1.rank }
        case.price:
              coins.sort  { $0.currentPrice > $1.currentPrice }
        case.priceReversed:
              coins.sort  { $0.currentPrice < $1.currentPrice }
        default: break
            
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue} )
            
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue})
            
            
        default:
            return coins
        }}
    
    
    
    private func mapallCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
      
            allCoins.compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24 h volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
       
        
        let portfolioValue = portfolioCoins.map({$0.currentHoldingsValue})
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        stats.append(contentsOf: [
        marketCap,
        volume,
        btcDominance,
        portfolio
        ])
        return stats

    }
    
}
