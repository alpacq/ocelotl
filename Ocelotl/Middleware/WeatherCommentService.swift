//
//  WeatherCommentService.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 04/06/2025.
//

import Foundation

class WeatherCommentService {
    // 🔁 Podmień na swój endpoint Workera!
    private let endpoint = URL(string: "https://openai-proxy.ocelotl.workers.dev")!
    
    func generateComment(
        droneName: String,
        windSpeed: Double,
        windGust: Double,
        precipitation: Double,
        weatherSymbol: String,
        completion: @escaping (String?) -> Void
    ) {
        // Budujemy JSON
        let payload: [String: Any] = [
            "droneName": droneName,
            "windSpeed": windSpeed,
            "windGust": windGust,
            "precipitation": precipitation,
            "weatherSymbol": weatherSymbol
        ]
        
        // Tworzymy żądanie
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            print("⚠️ JSON encode error: \(error)")
            completion(nil)
            return
        }
        
        // Wysyłamy request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("🌐 Request error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data,
                  let result = try? JSONDecoder().decode(CommentResponse.self, from: data) else {
                print("⚠️ Could not decode response")
                completion(nil)
                return
            }
            
            completion(result.comment)
        }.resume()
    }
    
    // Response format: { "comment": "Text..." }
    private struct CommentResponse: Decodable {
        let comment: String
    }
}
