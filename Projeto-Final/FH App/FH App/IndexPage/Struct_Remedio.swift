//
//  Struct_Remedio.swift
//  IndexPage
//
//  Created by Turma02-1 on 28/07/25.
//

import Foundation

struct coordenada:Codable, Identifiable {
    var id:Int
    var latitude:Double
    var longitude:Double
    var nome_farmacia:String
}
