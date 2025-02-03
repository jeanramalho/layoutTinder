//
//  MatchVC.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 31/01/25.
//
import Foundation
import UIKit

class MatchVC: UIViewController {
    
    var usuario: Usuario? {
        didSet{
            if let usuario = usuario {
                fotoImageView.image = UIImage(named: usuario.foto)
                mensagemLabel.text = "\(usuario.nome) curtiu você também!"
            }
        }
    }
    
    lazy var fotoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var likeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "icone-like")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var mensagemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 2.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.masksToBounds = false
        return label
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var mensagemTxt: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Diga algo legal..."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.textColor = .darkText
        textField.returnKeyType = .go
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 0))
        textField.rightViewMode = .always
        return textField
    }()
    
    lazy var mensagemEnviarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor(UIColor(red: 62/255, green: 163/255, blue: 255/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    lazy var voltarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Voltar para o Tinder", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor ,UIColor.black.cgColor]
        return gradient
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupUI(){
        setHierarchy()
        setConstraints()
        
        voltarButton.addTarget(self, action: #selector(voltarClique), for: .touchUpInside)
        
        
    
    }
    
    private func setHierarchy(){
        view.addSubview(fotoImageView)
        view.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(likeImageView)
        infoStackView.addArrangedSubview(mensagemLabel)
        infoStackView.addArrangedSubview(mensagemTxt)
        infoStackView.addArrangedSubview(voltarButton)
        
        mensagemTxt.addSubview(mensagemEnviarButton)
        
        fotoImageView.layer.addSublayer(gradient)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            fotoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            fotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fotoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fotoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            infoStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -46),
            
            likeImageView.heightAnchor.constraint(equalToConstant: 44),
            
            mensagemTxt.heightAnchor.constraint(equalToConstant: 44),
            
            mensagemEnviarButton.topAnchor.constraint(equalTo: mensagemTxt.topAnchor),
            mensagemEnviarButton.bottomAnchor.constraint(equalTo: mensagemTxt.bottomAnchor),
            mensagemEnviarButton.trailingAnchor.constraint(equalTo: mensagemTxt.trailingAnchor, constant: -16),
            
            
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func voltarClique(){
        self.dismiss(animated: true, completion: nil)
    }

    
    @objc func keyboardShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let duracao = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                UIView.animate(withDuration: duracao) {
                    self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height - keyboardSize.height)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @objc func keyboardHide(notification: NSNotification){
        
            if let duracao = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                UIView.animate(withDuration: duracao) {
                    self.view.frame = UIScreen.main.bounds
                    self.view.layoutIfNeeded()
                }
        }
    }
}
