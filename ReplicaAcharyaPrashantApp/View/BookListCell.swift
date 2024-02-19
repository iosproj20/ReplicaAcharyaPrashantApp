//
//  BookListCell.swift
//  ReplicaAcharyaPrashantApp
//
//  Created by Apple on 19/02/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookListCell: View {
    var model:BookListResponseModelElement
    
    var body: some View {
        VStack{
            HStack{
                WebImage(url: URL(string:  model.coverImage ?? ""))
                    .resizable()
                    .indicator(.activity(style: .large))
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                Spacer()
            }
            VStack{
                HStack{
                    Text(model.title ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(Color.black)
                    Spacer()
                }
                HStack{
                    Text(model.subtitle ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(Color.black)
                    Spacer()
                }
                HStack{
                    Text("Avaliable For Free")
                        .font(.system(size: 12))
                        .foregroundColor(Color.black)
                    Spacer()
                }
            }
        }
    }
}

