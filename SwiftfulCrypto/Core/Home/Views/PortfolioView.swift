//
//  PortfolioView.swift
//  SwiftfulCrypto
//
//  Created by Giorgi Meqvabishvili on 10.04.23.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showChecmark: Bool = false

    var body: some View {
        NavigationView {
            
            ScrollView{
                VStack(alignment: .leading) {
                    SearchBarView(searchText: $vm.searchText)
                coinLogoList
                    
                    if selectedCoin != nil {
                   portfolioINputSection
                    }

                }            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
              trailingNavBarButtons
                }
            })
            .onChange(of: vm.searchText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
        }
        .onChange(of: vm.searchText) { value in
            if value == "" {
                removeSelectedCoin()
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView().environmentObject(dev.homeVM)
    }
}
//

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.id == coin.id ?  Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .frame(height: 100)
            .padding(.leading)
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioINputSection: some View {
        VStack(spacing: 20) {
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()

                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount Holding")
                Spacer()

                TextField("EX: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            .padding(.trailing, -50)
            Divider()
            HStack {
                Text("Current Value")
                    Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
    }
    
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showChecmark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())

            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings !=  Double(quantityText)) ? 1.0 : 0.0
            )

        }
        .font(.headline)
    }
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
        let amount = Double(quantityText)
        else { return }
        
        //save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        
        //show checkmark
        withAnimation(.easeIn) {
            showChecmark = true
        }
        
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmarkt
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showChecmark = false
                removeSelectedCoin()
            }
        }
    }
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
}
