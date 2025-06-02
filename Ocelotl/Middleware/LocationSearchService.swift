//
//  LocationSearchService.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 02/06/2025.
//

import MapKit
import Combine

class LocationSearchService: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var queryFragment = ""
    @Published var results: [MKLocalSearchCompletion] = []
    
    private var completer: MKLocalSearchCompleter
    
    override init() {
        self.completer = MKLocalSearchCompleter()
        super.init()
        self.completer.delegate = self
        self.completer.resultTypes = .address
        
        $queryFragment
            .receive(on: DispatchQueue.main)
            .sink { [weak self] fragment in
                self?.completer.queryFragment = fragment
            }
            .store(in: &cancellables)
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
    
    private var cancellables: Set<AnyCancellable> = []
}
