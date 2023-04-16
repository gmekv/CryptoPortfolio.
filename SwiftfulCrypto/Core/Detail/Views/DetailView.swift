//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by Giorgi Meqvabishvili on 15.04.23.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    var body: some View {
        ZStack {
            if let coin = coin {
DetailView(coin: coin)
                
                
            }
        }
    }
}


struct DetailView: View {
    @StateObject var vm : DetailViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    var body: some View {
        
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                 overViewTitle
                    Divider()
                    overviewGrid
                    additionalTitle
                    Divider()
               additionalGrid
                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
            navigationBarTrailingItems
            }
        }
    }}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView {
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
            .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overViewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        
    }
    private var overviewGrid: some View {
        LazyVGrid(columns: columns , alignment: .center, pinnedViews: []) {
            ForEach(vm.overViewStatisticsl) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    private var additionalGrid: some View {
        LazyVGrid(columns: columns, alignment: .center, pinnedViews: []) {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
}
