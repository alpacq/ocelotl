//
//  Shot.swift
//  Ocelotl
//
//  Created by Krzysztof Lam on 11/06/2025.
//

import Foundation
import SwiftData

@Model
class Shot {
    var id: UUID
    var shotDescription: String
    var fps: String
    var framing: String
    var scene: String
    var isCompleted: Bool
    
    @Relationship(inverse: \Shooting.shots) var shooting: Shooting?
    
    init(
        shotDescription: String = "",
        fps: String = "24 fps",
        framing: String = "medium",
        scene: String = "ujęcie w domu",
        isCompleted: Bool = false
    ) {
        self.id = UUID()
        self.shotDescription = shotDescription
        self.fps = fps
        self.framing = framing
        self.scene = scene
        self.isCompleted = isCompleted
    }
}
