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
    
    enum Acao {
        case like
        case superLike
        case deslike
    }
    
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
        
        let loading = Loading(frame: view.frame)
        view.insertSubview(loading, at: 0)
        
        buscaUsuarios()
        adicionarHeaderFooter()
    }
    
    func buscaUsuarios(){
//        self.usuarios = UsuarioService.shared.buscaUsuarios()
//        self.adicionarCards()
        
        UsuarioService.shared.buscaUsuarios {(usuarios, err) in
            if let usuarios = usuarios {
                DispatchQueue.main.async {
                    self.usuarios = usuarios
                    self.adicionarCards()
                }
            }
        }
    }

}


extension CombineVC {
    func adicionarHeaderFooter(){
        setHierarchy()
        setConstraints()
        
        deslikeButton.addTarget(self, action: #selector(deslikeClique), for: .touchUpInside)
        superLikeButton.addTarget(self, action: #selector(superLikeClique), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeCliquqe), for: .touchUpInside)
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
                
                card.calback = {(data) in
                    self.verificarDetalhe(usuario: data)
                }
               
               let gesture = UIPanGestureRecognizer()
               gesture.addTarget(self, action: #selector(handlerCard))
               card.addGestureRecognizer(gesture)
           
                view.insertSubview(card, at: 1)
       }
   }
    
    func removerCard(card: UIView){
        card.removeFromSuperview()
        
        self.usuarios = self.usuarios.filter({ (usuario) -> Bool in
            return usuario.id != card.tag
        })
    }
    
    func verificarMatch(usuario: Usuario){
        if usuario.match {
            print("Match")
            
            let matchVC = MatchVC()
            matchVC.usuario = usuario
            matchVC.modalPresentationStyle = .fullScreen
            
            self.present(matchVC, animated: true, completion: nil)
            
        }
    }
    
    func verificarDetalhe(usuario: Usuario) {
        let detalheVC = DetalheVC()
        detalheVC.modalPresentationStyle = .fullScreen
        
        self.present(detalheVC, animated: true, completion: nil)
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
                //pega a ação de arrastar o card para direita ou para esquerda
                if card.center.x > self.view.bounds.width + 50{
                    self.animarCard(rotationAngle: rotationAngle, acao: .like)
                    return
                }
                if card.center.x < -50 {
                    self.animarCard(rotationAngle: rotationAngle, acao: .deslike)
                    return
                }
                
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
    
    //funções que implementam ação de like, deslike e superlike nos botões
    @objc func deslikeClique(){
        self.animarCard(rotationAngle: -0.4, acao: .deslike)
    }
    
    @objc func likeCliquqe(){
        self.animarCard(rotationAngle: 0.4, acao: .like)
    }
    
    @objc func superLikeClique(){
        self.animarCard(rotationAngle: 0, acao: .superLike)
    }
    
    func animarCard(rotationAngle: CGFloat, acao: Acao){
        if let usuario = self.usuarios.first {
            for view in self.view.subviews {
                if view.tag == usuario.id {
                    if let card = view as? CombineCardView {
                        let center: CGPoint
                        var like: Bool
                        
                        switch acao {
                        case .deslike:
                            center = CGPoint(x: card.center.x - self.view.bounds.width, y: card.center.y + 50)
                            like = false
                        case .superLike:
                            center = CGPoint(x: card.center.x, y: card.center.y - self.view.bounds.height)
                            like = true
                        case .like:
                            center =  CGPoint(x: card.center.x + self.view.bounds.width, y: card.center.y + 50)
                            like = true
                        }
                        UIView.animate(withDuration: 0.2, animations: {
                            card.center = center
                            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
                            
                            card.deslikeImageView.alpha = like == false ? 1 : 0
                            card.likeImageView.alpha = like == true ? 1 : 0
                        }) { (_) in
                            
                            if like {
                                self.verificarMatch(usuario: usuario)
                            }
                            
                            self.removerCard(card: card)
                        }
                    }
                }
            }
        }
    }
}
