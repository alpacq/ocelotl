//
//  Drone.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 02/06/2025.
//

import Foundation

struct Drone: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let family: String // name in Assets
}

let availableDrones: [Drone] = [
    Drone(name: "DJI Mavic Air 2", family: "Mavic"),
    Drone(name: "DJI Mavic 2", family: "Mavic"),
    Drone(name: "DJI Mavic 3", family: "Mavic"),
    Drone(name: "DJI Mavic 4 Pro", family: "Mavic"),
    
    Drone(name: "DJI Mini SE", family: "Mini"),
    Drone(name: "DJI Mini 2", family: "Mini"),
    Drone(name: "DJI Mini 2 SE", family: "Mini"),
    Drone(name: "DJI Mini 3", family: "Mini"),
    Drone(name: "DJI Mini 3 Pro", family: "Mini"),
    Drone(name: "DJI Mini 4 Pro", family: "Mini"),
    Drone(name: "DJI Mini 4K", family: "Mini"),
    Drone(name: "DJI Mini 5 Pro", family: "Mini"),
    
    Drone(name: "DJI Air 2S", family: "Air"),
    Drone(name: "DJI Air 3", family: "Air"),
    Drone(name: "DJI Air 3S", family: "Air"),
    
    Drone(name: "DJI Inspire 1", family: "Inspire"),
    Drone(name: "DJI Inspire 2", family: "Inspire"),
    Drone(name: "DJI Inspire 3", family: "Inspire"),
    
    Drone(name: "DJI Matrice 300", family: "Matrice"),
    Drone(name: "DJI Matrice 30", family: "Matrice"),
    Drone(name: "DJI Matrice 350 RTK", family: "Matrice"),
    
    Drone(name: "DJI FPV", family: "FPV"),
    Drone(name: "DJI Avata", family: "Avata"),
    Drone(name: "DJI Avata 2", family: "Avata"),
    Drone(name: "DJI Avata 3", family: "Avata"),
    
    Drone(name: "DJI Neo", family: "Neo"),
    Drone(name: "DJI Flip", family: "Flip"),
    Drone(name: "DJI Neo 2", family: "Neo")
]
