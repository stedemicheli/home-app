//
//  PropertyView.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import SDWebImageSwiftUI
import SwiftUI

struct PropertyView: View {
    
    let image: URL?
    let title: String
    let address: String
    let price: String
    let onLike: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing) {
            ZStack {
                WebImage(url: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .imageHeight
                    )
                Image(systemName: "suit.heart.fill") // TODO: Make image fill when saved
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .imageSize, height: .imageSize)
                    .foregroundColor(.red)
                    .offset(x: .imageXOffset, y: .imageYOffset)
                    .onTapGesture(perform: onLike)
                HStack {
                    Text(price) // TODO: Handle formatting when too long
                        .lineLimit(1)
                        .frame(
                            minWidth: .priceWidth,
                            minHeight: .priceHeight
                        )
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .shadow(radius: 7)
                    Spacer()
                }
            }
            Text(title)
            HStack {
                Image(systemName: "mappin.and.ellipse")
                Text(address)
            }
        }
    }
}

private extension CGFloat {
    
    static let spacing: CGFloat = 10
    static let priceWidth: CGFloat = 80
    static let priceHeight: CGFloat = 30
    static let imageSize: CGFloat = 30
    static let imageXOffset: CGFloat = 100
    static let imageYOffset: CGFloat = -75
    static let imageHeight: CGFloat = 200
}

struct PropertyView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyView(
            image: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQL-xdlN1G5iYo-v8iv21ylNY-Z19uEPJwrHyNg2OLXQVbLg9J3jYD9dPrask05xWltwt8&usqp=CAU")!,
            title: "Erstebezug in Toplage",
            address: "Singerstrasse. 63, Zurich",
            price: "CHF 500",
            onLike: { }
        )
    }
}
