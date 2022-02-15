//
//  ValidaFormulario.swift
//  App de Ingressos
//
//  Created by Jefferson Oliveira de Araujo on 06/02/22.
//

import UIKit
import CPF_CNPJ_Validator
import CreditCardValidator

enum TiposTextField: Int {
    case nomeCompleto = 1
    case email = 2
    case cpf = 3
    case cep = 4
    case endereco = 5
    case bairro = 6
    case numeroCartao = 7
    case mesVencimento = 8
    case anoVencimento = 9
    case codigoSeguranca = 10
    case numeroParcelas = 11
}

class ValidaFormulario: NSObject {
    
    func verificaPreenchimento(_ textFields: [UITextField]) -> Bool {
        for textField in textFields {
            if textField.text == "" {
                return false
            }
        }
        return true
    }
    
    func verificaTipoTextField(_ listaTextFields: [UITextField]) -> Bool {
        var dicionarioTextFields: [TiposTextField: UITextField] = [:]
        
        for textField in listaTextFields {
            if let tiposTextField = TiposTextField(rawValue: textField.tag) {
                dicionarioTextFields[tiposTextField] = textField
            }
        }
        guard let cpf = dicionarioTextFields[.cpf], BooleanValidator().validate(cpf: cpf.text!) else { return false }
        guard let email = dicionarioTextFields[.email], self.verificaEmail(email.text!) else { return false }
        guard let numeroCartao = dicionarioTextFields[.numeroCartao], CreditCardValidator(numeroCartao.text!).isValid else { return false }
        
        return true
    }
    
    func verificaEmail(_ email: String) -> Bool {
        let emailRegex = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    func exibeNotificacao(title: String, msg: String) -> UIAlertController {
        let notificacao = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let button = UIAlertAction(title: "Ok", style: .default, handler: nil)
        notificacao.addAction(button)
        
        return notificacao
    }
}
