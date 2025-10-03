//
//  CABAPlayer.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/16/25.
//

import Foundation

struct CABAPlayer: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var position: String
    var height: String
    var imageName: String
}
