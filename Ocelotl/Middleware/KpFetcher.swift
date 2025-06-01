//
//  KpFetcher.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 31/05/2025.
//

import Foundation

class KpFetcher: ObservableObject {
    @Published var currentKpIndex: Double?
    
    func fetchKpIndex() {
        guard let url = URL(string: "https://services.swpc.noaa.gov/json/planetary_k_index_1m.json") else {
            print("Invalid Kp URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Kp fetch error: \(error?.localizedDescription ?? "unknown")")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode([KpIndexEntry].self, from: data)
                if let latest = decoded.last {
                    DispatchQueue.main.async {
                        self.currentKpIndex = latest.kp_index
                    }
                }
            } catch {
                print("Kp decode error: \(error)")
            }
        }.resume()
    }
}
