//
//  CombineVC.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 15/01/25.
//
import Foundation
import UIKit

class CombineVC: UIViewController {
    
    var usuarios: [Usuario] = []
    
    lazy var perfilButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icone-perfil"), for: .normal)
        return button
    }()
    
    lazy var chatButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icone-chat"), for: .normal)
        return button
    }()
    
    lazy var logoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icone-logo"), for: .normal)
        return button
    }()
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    lazy var deslikeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icone-deslike"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.masksToBounds = false
        return button
    }()
    
    lazy var superLikeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icone-superlike"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.masksToBounds = false
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icone-like"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.masksToBounds = false
        return button
    }()
    
    lazy var footerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        buscaUsuarios()
        adicionarHeaderFooter()
    }
    
    func buscaUsuarios(){
        self.usuarios = UsuarioService.shared.buscaUsuarios()
        self.adicionarCards()
    }

}


extension CombineVC {
    func adicionarHeaderFooter(){
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        view.addSubview(headerStackView)
        view.addSubview(footerStackView)
        
        
        footerStackView.addArrangedSubview(deslikeButton)
        footerStackView.addArrangedSubview(superLikeButton)
        footerStackView.addArrangedSubview(likeButton)
        
        headerStackView.addArrangedSubview(perfilButton)
        headerStackView.addArrangedSubview(logoButton)
        headerStackView.addArrangedSubview(chatButton)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            perfilButton.widthAnchor.constraint(equalToConstant: 32),
            perfilButton.heightAnchor.constraint(equalToConstant: 32),
            
            logoButton.widthAnchor.constraint(equalToConstant: 32),
            logoButton.heightAnchor.constraint(equalToConstant: 32),
            
            chatButton.widthAnchor.constraint(equalToConstant: 32),
            chatButton.heightAnchor.constraint(equalToConstant: 32),
            
            footerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
            footerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            footerStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            deslikeButton.heightAnchor.constraint(equalToConstant: 64),
            deslikeButton.widthAnchor.constraint(equalToConstant: 64),
            
            superLikeButton.heightAnchor.constraint(equalToConstant: 64),
            superLikeButton.widthAnchor.constraint(equalToConstant: 64),
            
            likeButton.heightAnchor.constraint(equalToConstant: 64),
            likeButton.widthAnchor.constraint(equalToConstant: 64),
            
        ])
    }
}

extension CombineVC {
   func adicionarCards(){

            for usuario in usuarios {
               let card = CombineCardView()
               card.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
               card.center = view.center
                card.usuario = usuario
                card.tag = usuario.id
               
               let gesture = UIPanGestureRecognizer()
               gesture.addTarget(self, action: #selector(handlerCard))
               card.addGestureRecognizer(gesture)
           
                view.insertSubview(card, at: 0)
       }
   }
}


extension CombineVC {
    @objc func handlerCard(_ gesture: UIPanGestureRecognizer){
        if let card = gesture.view as? CombineCardView{
            let point = gesture.translation(in: view)
            //implementa movimento de drag ou seja segurar e puchar o elemento na view
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            //pega angulo para rotação
            let rotationAngle = point.x / view.bounds.width * 0.4
            //condição para aparecer coração partido ou coração inteiro dependendo do lado para qual o card for arrastado
            if point.x > 0 {
                card.likeImageView.alpha = rotationAngle * 5
                card.deslikeImageView.alpha = 0
            } else {
                card.deslikeImageView.alpha = rotationAngle * 5 * -1
                card.likeImageView.alpha = 0
            }
            
            //implementa rotação no card para que quando for arrastado ele tenha efeito rotação
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            // retorna com o elemento para a posição anterior quando o usuário solta o elemento
            if gesture.state == .ended {
                //Implementa animação para retorno do card para a posição inicial
                UIView.animate(withDuration: 0.2) {
                    card.center = self.view.center
                    card.transform = .identity
                    // faz os corações sumirem quando o toque é finalizado
                    card.deslikeImageView.alpha = 0
                    card.likeImageView.alpha = 0
                }
            }
        }
    }
}
