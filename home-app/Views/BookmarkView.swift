//
//  BookmarkView.swift
//  home-app
//
//  Created by Stefano on 17.11.21.
//

import SDWebImageSwiftUI
import SwiftUI

struct BookmarkView: View {
    
    let image: URL?
    let title: String
    let address: String
    
    var body: some View {
        HStack {
            WebImage(url: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: .imageSize,
                    height: .imageSize
                )
            VStack(alignment: .leading, spacing: .spacing) {
                Text(title)
                Text(address)
            }
        }
    }
}

private extension CGFloat {
    
    static let spacing: CGFloat = 10
    static let imageSize: CGFloat = 75
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView(
            image: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQL-xdlN1G5iYo-v8iv21ylNY-Z19uEPJwrHyNg2OLXQVbLg9J3jYD9dPrask05xWltwt8&usqp=CAU"),
            title: "Erstebezug in Toplage",
            address: "Singerstrasse. 63, Zurich"
        )
    }
}
