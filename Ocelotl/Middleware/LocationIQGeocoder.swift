//
//  LocationIQGeocoder.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 02/06/2025.
//

import CoreLocation
import Foundation

class LocationIQGeocoder {
    let apiKey = "pk.f78f5ec563563372599b9ddee97fd233" // ← tu wstaw swój klucz
    
    func geocode(_ query: String, completion: @escaping (CLLocationCoordinate2D?, String?) -> Void) {
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://us1.locationiq.com/v1/search.php?key=\(apiKey)&q=\(encoded)&format=json") else {
            completion(nil, nil); return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let result = try? JSONDecoder().decode([LocationIQResult].self, from: data),
                  let first = result.first,
                  let lat = Double(first.lat),
                  let lon = Double(first.lon)
            else {
                completion(nil, nil)
                return
            }
            
            completion(CLLocationCoordinate2D(latitude: lat, longitude: lon), first.display_name)
        }.resume()
    }
    
    func reverse(lat: Double, lon: Double, completion: @escaping (String?) -> Void) {
        let urlString = "https://us1.locationiq.com/v1/reverse.php?key=\(apiKey)&lat=\(lat)&lon=\(lon)&format=json"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let result = try? JSONDecoder().decode(LocationIQReverseResult.self, from: data)
            else {
                completion(nil)
                return
            }
            
            let cleanName = result.display_name.components(separatedBy: ",").first ?? result.display_name
            completion(cleanName)
        }.resume()
    }

}
