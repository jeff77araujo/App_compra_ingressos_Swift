//
//  Localizacao.swift
//  App de Ingressos
//
//  Created by Jefferson Oliveira de Araujo on 07/02/22.
//

import UIKit

class Localizacao: NSObject {
    
    var logradouro = ""
    var bairro = ""
    var cidade = ""
    var uf = ""
    
    init(_ dicionario: [String:String]) {
        self.logradouro = dicionario["logradouro"] ?? ""
        self.bairro = dicionario["bairro"] ?? ""
        self.cidade = dicionario["localidade"] ?? ""
        self.uf = dicionario["uf"] ?? ""
    }
}
