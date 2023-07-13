//
//  LinkView.swift
//  Blurred
//
//  Created by phucld on 3/17/20.
//  Copyright © 2020 Dwarves Foundation. All rights reserved.
//

import SwiftUI

struct LinkView: View {

    var imageName: String
    var title: String
    var link: String
    var body: some View {
        HStack {
            Button {
                if let url = URL(string: self.link) {
                    NSWorkspace.shared.open(url)
                }
            } label: {
                HStack {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16)
                        .foregroundColor(.primary)

                    Text(title.localized)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
            }
            .buttonStyle(LinkButtonStyle())
        }
    }
}

// MARK: - PreviewProvider
struct LinkView_Previews: PreviewProvider {

    static var previews: some View {
        LinkView(imageName: "ico_compass", title: "Know more about us", link: "https://dwarves.foundation/apps")
    }
}
