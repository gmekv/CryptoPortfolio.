//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Giorgi Meqvabishvili on 05.04.23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false //animate right part
    @State private var showPortfolioView: Bool = false //show new sheet
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            // content layer
            VStack {
               
      homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitles

                
                if !showPortfolio {
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinList.transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }


    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    private var homeHeader: some View {
        
        HStack {
            CircleButtonView(iconName:showPortfolio ? "plus" :"info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
            
                .background(CircleButtonAnimationView(animate: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "Portfolio " : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .frame(width: 50, height: 50) // add a fixed size
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()

                    }
                }
        }

        .padding(.horizontal)
        .background(Color.theme.background)

    }
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins)  { coin in
                CoinRowView(coin: coin, showHoldingsColun: false)
                    .listRowInsets(.init(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)))
            }
        }
        .listStyle(PlainListStyle())

    }
    private var portfolioCoinList: some View {
        List {
            ForEach(vm.portfolioCoins)  { coin in
                CoinRowView(coin: coin, showHoldingsColun: true)
                    .listRowInsets(.init(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)))
            }
        }
        .listStyle(PlainListStyle())

    }
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
