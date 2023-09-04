//
//  BodyOfProfileView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 5/8/23.
//

import SwiftUI
struct Tag: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
}
struct BodyOfProfileView: View {
    let availableTags = [
        Tag(name: "Musica", iconName: "music.note"),
        Tag(name: "Cine", iconName: "film"),
        Tag(name: "Atrevido", iconName: "flame"),
        Tag(name: "Lanzado", iconName: "paperplane")
    ]

    @State private var selectedTags = Set<UUID>()
    @State private var isEditingName = false
    @State private var isEditingDescription = false
    @State private var name: String = UserSession.shared.currentUser?.name ?? ""
    @State private var description: String = UserSession.shared.currentUser?.description ?? ""
    var body: some View {
        if let user = UserSession.shared.currentUser {
            Text("Nombre:")
                .font(.headline)
                .foregroundColor(.secondary)
            if isEditingName {
                HStack {
                  TextField("Nombre", text: $name)
                      .font(.title)
                      .fontWeight(.bold)
                      .foregroundColor(.primary)
                  Button(action: {
                      withAnimation {
                          isEditingName.toggle()
                          #warning("Falta confirmar los cambios para el usuario en firebase")
                      }
                  }) {
                      Image(systemName: "checkmark").foregroundColor(Color.green)
                  }
                }
            } else {
                HStack {
                  Text(user.name)
                      .font(.title)
                      .fontWeight(.bold)
                      .foregroundColor(.primary)
                  Button(action: {
                      withAnimation {
                          isEditingName.toggle()
                      }
                  }) {
                      Image(systemName: "pencil")
                  }
                }
            }

            Text("Descripción:")
                .font(.headline)
                .foregroundColor(.secondary)
            
            if isEditingDescription {
              HStack {
                  TextField("Descripción", text: $description)
                      .font(.body)
                      .fixedSize(horizontal: false, vertical: true)
                      .foregroundColor(.primary)
                  Button(action: {
                      withAnimation {
                          isEditingDescription.toggle()
                          #warning("Falta confirmar los cambios para el usuario en firebase")
                      }
                  }) {
                      Image(systemName: "checkmark").foregroundColor(Color.green)
                  }
              }
            } else {
              HStack {
                  Text(user.description)
                      .font(.body)
                      .fixedSize(horizontal: false, vertical: true)
                      .foregroundColor(.primary)
                  Button(action: {
                      withAnimation {
                          isEditingDescription.toggle()
                      }
                  }) {
                      Image(systemName: "pencil")
                  }
              }
            }
            

            Text("Año de nacimiento:")
                .font(.headline)
                .foregroundColor(.secondary)
            Text(String(user.yearOfBorn))
                .font(.body)
                .foregroundColor(.primary)
            
            Text("Tags:")
                .font(.headline)
                .foregroundColor(.secondary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(availableTags) { tag in
                        Button(action: {
                            if selectedTags.contains(tag.id) {
                                selectedTags.remove(tag.id)
                            } else {
                                selectedTags.insert(tag.id)
                            }
                        }) {
                            HStack {
                                Image(systemName: tag.iconName)
                                Text(tag.name)
                                    .font(.footnote)
                            }
                            .padding()
                            .background(selectedTags.contains(tag.id) ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .transition(.scale)
                        }
                    }
                }
            }
        } else {
            #warning("falta implementación")
        }
    }
}

struct BodyOfProfileView_Previews: PreviewProvider {
    static var previews: some View {
        BodyOfProfileView()
    }
}
