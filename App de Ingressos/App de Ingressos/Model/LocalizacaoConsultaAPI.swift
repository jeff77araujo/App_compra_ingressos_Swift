//
//  LocalizacaoConsultaAPI.swift
//  App de Ingressos
//
//  Created by Jefferson Oliveira de Araujo on 07/02/22.
//

import UIKit
import Alamofire

class LocalizacaoConsultaAPI: NSObject {
    
    func consultaViaCepAPI(_ cep: String, success:@escaping(_ localizacao: Localizacao) -> Void, failure:@escaping(_ error: Error) -> Void) {
        AF.request("https://viacep.com.br/ws/\(cep)/json/", method: .get).validate().responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success:
                if let resultado = response.value as? [String:String] {
                    let localizacao = Localizacao(resultado)
                    success(localizacao)
                }
                break
            case .failure:
                failure(response.error as! Error)
                break
            }
        })
    }

}
