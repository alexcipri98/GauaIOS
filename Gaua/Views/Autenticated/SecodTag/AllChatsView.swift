//
//  MessageView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 25/7/23.
//

import SwiftUI


struct AllChatsView: View {
    @StateObject var viewModel = AllChatsViewModel()

    var body: some View{
        if viewModel.isLoading{
            //LoadingView()
        } else {
            ScrollView {
                ForEach(0..<viewModel.matches.count, id: \.self) { num in
                    if let otherPerson = viewModel.matches[num].otherPerson {
                        NavigationLink(
                            destination: ChatView(forDocument: viewModel.matches[num].id, otherPerson: otherPerson)
                        ) {
                            VStack {
                                HStack(spacing: 16) {
                                    Image(uiImage: otherPerson.image!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle().stroke(Color(.label), lineWidth: 1)
                                        )
                                    
                                    VStack(alignment: .leading) {
                                        Text(otherPerson.name)
                                            .font(.system(size: 16, weight: .bold))
                                        Text("En línea")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(.green))
                                    }
                                    Spacer()
                                    
                                    Text("22d")
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                Divider()
                                    .padding(.vertical, 8)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
}
