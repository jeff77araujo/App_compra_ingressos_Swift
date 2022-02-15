//
//  PickerViewAno.swift
//  App de Ingressos
//
//  Created by Jefferson Oliveira de Araujo on 09/02/22.
//

import UIKit

protocol PickerViewAnoDelegate {
    func anoSelecionado(ano: String)
}

class PickerViewAno: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: PickerViewAnoDelegate?
    let listaDeAnos = ["2022","2023","2024","2025","2026"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaDeAnos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let anoAtual = listaDeAnos[row]
        return anoAtual
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.anoSelecionado(ano: listaDeAnos[row])
//            if listaDeAnos[row] == "2022" {
//
//            }
        }
    }
    

}
