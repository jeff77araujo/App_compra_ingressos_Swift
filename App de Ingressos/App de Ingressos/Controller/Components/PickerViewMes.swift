//
//  PickerViewMes.swift
//  App de Ingressos
//
//  Created by Jefferson Oliveira de Araujo on 08/02/22.
//

import UIKit

protocol PickerViewMesDelegate {
    func mesSelecionado(mes: String)
}

class PickerViewMes: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: PickerViewMesDelegate?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            if row == 9 || row == 10 || row == 11 {
                delegate?.mesSelecionado(mes: "\(row + 1)")
            } else {
                delegate?.mesSelecionado(mes: "0\(row + 1)")
            }
        }
    }
}
