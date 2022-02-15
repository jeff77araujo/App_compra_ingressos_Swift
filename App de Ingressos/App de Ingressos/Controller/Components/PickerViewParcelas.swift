//
//  PickerViewParcelas.swift
//  App de Ingressos
//
//  Created by Jefferson Oliveira de Araujo on 09/02/22.
//

import UIKit

protocol PickerViewParcelaDelegate {
    func parcelaSelecionado(parcela: String)
}

class PickerViewParcela: NSObject, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var delegate: PickerViewParcelaDelegate?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)x"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.parcelaSelecionado(parcela: "\(row + 1)")
        }
    }
    
}
