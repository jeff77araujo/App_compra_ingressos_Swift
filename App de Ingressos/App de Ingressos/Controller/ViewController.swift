//
//  ViewController.swift
//  App de Ingressos
//
//  Created by Jefferson Oliveira de Araujo on 06/02/22.
//

import UIKit

class ViewController: UIViewController, PickerViewMesDelegate, PickerViewAnoDelegate, PickerViewParcelaDelegate {

    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var scrollViewMain: UIScrollView!
    @IBOutlet weak var valorParcelasLabel: UILabel!
    
    var pickerViewMes = PickerViewMes()
    var pickerViewAno = PickerViewAno()
    var pickerViewParcela = PickerViewParcela()
    var valorIngresso = 199.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStyle()
        pickerViewMes.delegate = self
        pickerViewAno.delegate = self
        pickerViewParcela.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(aumentaScrollView(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    func buttonStyle() {
        imageBanner.layer.cornerRadius = 10
        imageBanner.layer.masksToBounds = true
    }
    
    @objc func aumentaScrollView(notification: Notification) {
        self.scrollViewMain.contentSize = CGSize(width: self.scrollViewMain.frame.width, height: self.scrollViewMain.frame.height + 550)
    }
    
    // MARK: PickerViewDelegate
    
    func mesSelecionado(mes: String) {
        self.buscaTextField(.mesVencimento) { (mesTextField) in
            mesTextField.text = mes
        }
    }
    
    func anoSelecionado(ano: String) {
        self.buscaTextField(.anoVencimento) { (anoTextField) in
            anoTextField.text = ano
        }
    }
        
    func parcelaSelecionado(parcela: String) {
        self.buscaTextField(.numeroParcelas) { (parcelaTextField) in
            parcelaTextField.text = "\(parcela) vezes"
            let calculoParcela = "\(valorIngresso/Double(parcela)!)"
                        
            self.valorParcelasLabel.text = String(format: "%@x R$%@ (ou 199,00 à vista)", parcela, calculoParcela)
        }
    }
    
    func buscaTextField(_ tipoTextField: TiposTextField, completion: (_ textFieldSolicitado: UITextField) -> Void) {
        for textField in textFields {
            if let textFieldAtual = TiposTextField(rawValue: textField.tag) {
                if textFieldAtual == tipoTextField {
                    completion(textField)
                }
            }
        }
    }
    
    @IBAction func buttonBuy(_ sender: UIButton) {
        let verificaPreenchimento = ValidaFormulario().verificaPreenchimento(textFields)
        let textFieldValidos = ValidaFormulario().verificaTipoTextField(textFields)
        
        if verificaPreenchimento && textFieldValidos {
            let alerta = ValidaFormulario().exibeNotificacao(title: "Parabéns", msg: "Compra realizada com sucesso")
            present(alerta, animated: true)
        } else {
            let alerta = ValidaFormulario().exibeNotificacao(title: "Atenção", msg: "Preencha corretamente todos os campos")
            present(alerta, animated: true)

        }
    }
    
    @IBAction func cepTextField(_ sender: UITextField) {
        guard let cep = sender.text else { return }
        LocalizacaoConsultaAPI().consultaViaCepAPI(cep) { (localizacao) in
            
            self.buscaTextField(.endereco) { (enderecoTextField) in
                enderecoTextField.text = localizacao.logradouro
            }
            
            self.buscaTextField(.bairro) { (bairroTextField) in
                bairroTextField.text = localizacao.bairro
            }
            
        } failure: { (error) in
            print(error)
        }
    }
    
    @IBAction func mesTextFieldFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewMes
        pickerView.dataSource = pickerViewMes
        sender.inputView = pickerView
    }
    
    @IBAction func anoTextField(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewAno
        pickerView.dataSource = pickerViewAno
        sender.inputView = pickerView
    }
    
    @IBAction func codSegTextField(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        if text.count > 3 {
            let codigo = text.suffix(3)
            self.buscaTextField(.codigoSeguranca) { (codSegTextField) in
                codSegTextField.text = String(codigo)
            }
        } else {
            self.buscaTextField(.codigoSeguranca) { (codSegTextField) in
                codSegTextField.text = text
            }
        }
    }
    
    @IBAction func parcelasTextField(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewParcela
        pickerView.dataSource = pickerViewParcela
        sender.inputView = pickerView
    }
}

