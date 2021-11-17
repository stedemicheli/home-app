//
//  BookmarkViewModel.swift
//  home-app
//
//  Created by Stefano on 17.11.21.
//

import Foundation

struct BookmarkViewModel: Identifiable {
    let id: String
    let title: String
    let address: String
    let imageURL: URL?
}
