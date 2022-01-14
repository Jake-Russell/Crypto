//
//  CoinDataService.swift
//  Cryptocurrency
//
//  Created by Russell, Jake 01 on 23/12/2021.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=GBP&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=1h%2C24h%2C7d%2C14d%2C30d%2C1y") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
