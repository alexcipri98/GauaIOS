//
//  PhoneNumberRequestView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 24/9/23.
//

import SwiftUI

struct PhoneNumberRequestView: View {
    @State var prefix: String = "ES +34"
    @State var phoneNumber: String = "Número de teléfono"
    var body: some View {
        ZStack{
            Image("RegisterStep1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding(.bottom)
            GeometryReader { geometry in
                
                VStack(alignment: .leading) {
                    Text("¿Nos das tu \n móvil? ;)")
                        .bold()
                        .font(.system(size: 40))
                        .frame(width: geometry.size.width - 120)
                        .foregroundColor(Color.white)
                        .padding(.top, 270)
                    HStack {
                        TextField("", text: $prefix)
                            .font(.system(size: 20))
                            .frame(width: 90, height: 60, alignment: .center)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .padding(.leading, 20)
                        
                        TextField("", text: $phoneNumber)
                            .font(.system(size: 20))
                            .frame(height: 60, alignment: .center)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .padding([.leading, .trailing], 20)
                    }.padding().frame(width: geometry.size.width)
                    HStack{
                        Image(systemName: "lock")
                            .resizable()
                            .frame(width: 16, height: 24)
                            .padding(.leading, 28)
                        Text("Tu información privada está segura con nosotros. No la compartiremos con ningún usuario.")
                            .font(.system(size: 14))
                            .padding(.trailing, 20)
                    }.frame(width: geometry.size.width - 20)
                        .foregroundColor(Color.white)
                        
                        Button(action: {
                            print("")
                        }) {
                            Text("Siguiente")
                                .bold()
                                .font(.system(size:20))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                        }
                        .background(Color("ButtonColor"))
                        .cornerRadius(10)
                        .frame(width: geometry.size.width - 80)
                        .padding(.horizontal, 40)
                        .padding(.top, 50)
                }
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct PhoneNumberRequestView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberRequestView()
    }
}
