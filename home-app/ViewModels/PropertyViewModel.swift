//
//  PropertyViewModel.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import Foundation

struct PropertyViewModel: Identifiable {
    let id: UUID = UUID()
    let title: String
    let address: String
    let price: String
    let imageURL: URL?
}
