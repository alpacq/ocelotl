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
    let imageName: String // name in Assets
}

let availableDrones: [Drone] = [
    Drone(name: "DJI Mavic Air 2", imageName: "mavic_air2"),
    Drone(name: "DJI Mavic 2", imageName: "mavic2"),
    Drone(name: "DJI Mavic 3", imageName: "mavic3"),
    Drone(name: "DJI Mavic 4 Pro", imageName: "mavic4_pro"),
    
    Drone(name: "DJI Mini SE", imageName: "mini_se"),
    Drone(name: "DJI Mini 2", imageName: "mini2"),
    Drone(name: "DJI Mini 2 SE", imageName: "mini2_se"),
    Drone(name: "DJI Mini 3", imageName: "mini3"),
    Drone(name: "DJI Mini 3 Pro", imageName: "mini3_pro"),
    Drone(name: "DJI Mini 4 Pro", imageName: "mini4_pro"),
    Drone(name: "DJI Mini 4K", imageName: "mini4k"),
    Drone(name: "DJI Mini 5 Pro", imageName: "mini5_pro"),
    
    Drone(name: "DJI Air 2S", imageName: "air2s"),
    Drone(name: "DJI Air 3", imageName: "air3"),
    Drone(name: "DJI Air 3S", imageName: "air3s"),
    
    Drone(name: "DJI Inspire 1", imageName: "inspire1"),
    Drone(name: "DJI Inspire 2", imageName: "inspire2"),
    Drone(name: "DJI Inspire 3", imageName: "inspire3"),
    
    Drone(name: "DJI Matrice 300", imageName: "matrice300_rtk"),
    Drone(name: "DJI Matrice 30", imageName: "matrice30"),
    Drone(name: "DJI Matrice 350 RTK", imageName: "matrice350_rtk"),
    
    Drone(name: "DJI FPV", imageName: "fpv"),
    Drone(name: "DJI Avata", imageName: "avata"),
    Drone(name: "DJI Avata 2", imageName: "avata2"),
    Drone(name: "DJI Avata 3", imageName: "avata3"),
    
    Drone(name: "DJI Neo", imageName: "neo"),
    Drone(name: "DJI Flip", imageName: "flip"),
    Drone(name: "DJI Neo 2", imageName: "neo2")
]
