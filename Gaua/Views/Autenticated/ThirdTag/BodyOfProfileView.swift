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
        // Añade más tags aquí
    ]

    @State private var selectedTags = Set<UUID>()
    var body: some View {
        if let user = UserSession.shared.currentUser {
            Text("Nombre:")
                .font(.headline)
                .foregroundColor(.secondary)
            Text(user.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)

            Text("Descripción:")
                .font(.headline)
                .foregroundColor(.secondary)
            Text("Esto es una prueba de descripción de usuario bastante larga, quiero saber hasta donde puede llegar el texto sin qeu se superpongan las vistas, aún no he llegado al máximo asique sigo escribiendo, esto no acaba no se como no se revientan los márgenes.")
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.primary)

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
