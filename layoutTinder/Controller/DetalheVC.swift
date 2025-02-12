//
//  DetalheVC.swift
//  layoutTinder
//
//  Created by Jean Ramalho on 10/02/25.
//
import Foundation
import UIKit

class HeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attribute) in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                
                guard let collectionView = collectionView else {return}
                
                let contentOffSetY = collectionView.contentOffset.y
                
                attribute.frame = CGRect(
                    x: 0,
                    y: contentOffSetY,
                    width: collectionView.bounds.width,
                    height: attribute.bounds.height - contentOffSetY)
            }
        })
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

class DetalheVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var usuario: Usuario? {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    enum Acao {
        case like
        case deslike
    }
    
    let cellId = "cellId"
    let headerId = "headerId"
    let perfilId = "perfilId"
    let fotosId = "fotosId"
    
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
    
    lazy var voltarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icone-down"), for: .normal)
        button.backgroundColor = UIColor(red: 232/255, green: 88/255, blue: 54/255, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 24
        return button
    }()
    
    var callback: ((Usuario?, Acao) -> Void)?
    
    init() {
        super.init(collectionViewLayout: HeaderLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(DetalheHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(DetalhePerfilCell.self, forCellWithReuseIdentifier: perfilId)
        collectionView.register(DetalhesFotoCell.self, forCellWithReuseIdentifier: fotosId)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 134, right: 0)
        
        deslikeButton.addTarget(self, action: #selector(deslikeClique), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeClique), for: .touchUpInside)
        voltarButton.addTarget(self, action: #selector(voltarClique), for: .touchUpInside)
            
        setHirearchy()
        setConstraints()
    }
    
    private func setHirearchy(){
        self.view.addSubview(footerStackView)
        self.view.addSubview(voltarButton)
        
        footerStackView.addArrangedSubview(UIView())
        footerStackView.addArrangedSubview(deslikeButton)
        footerStackView.addArrangedSubview(likeButton)
        footerStackView.addArrangedSubview(UIView())
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            footerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
            footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            deslikeButton.heightAnchor.constraint(equalToConstant: 64),
            deslikeButton.widthAnchor.constraint(equalToConstant: 64),
            
            likeButton.heightAnchor.constraint(equalToConstant: 64),
            likeButton.widthAnchor.constraint(equalToConstant: 64),
            
            voltarButton.heightAnchor.constraint(equalToConstant: 48),
            voltarButton.widthAnchor.constraint(equalToConstant: 48),
            voltarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            voltarButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 140),
        ])

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DetalheHeaderView
        header.usuario = self.usuario
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: perfilId, for: indexPath) as! DetalhePerfilCell
            cell.usuario = self.usuario
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fotosId, for: indexPath) as! DetalhesFotoCell

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width: CGFloat = UIScreen.main.bounds.width
        var height: CGFloat = UIScreen.main.bounds.width * 0.66
        
        if indexPath.item == 0 {
            let cell = DetalhePerfilCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.usuario = self.usuario
            cell.layoutIfNeeded()
            
            let estimativaTamanho = cell.systemLayoutSizeFitting(CGSize(width: width, height: 1000))
            height = estimativaTamanho.height
        }
        
       
        
        return .init(width: width, height: height)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let originY = view.bounds.height * 0.7 - 24
        
        if scrollView.contentOffset.y > 0 {
            self.voltarButton.frame.origin.y = originY - scrollView.contentOffset.y
        } else {
            self.voltarButton.frame.origin.y = originY + scrollView.contentOffset.y * -1
        }
    }
    
    @objc func voltarClique(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deslikeClique(){
        self.callback?(self.usuario, Acao.deslike)
        self.voltarClique()
    }
    
    @objc func likeClique(){
        self.callback?(self.usuario, Acao.like)
        self.voltarClique()
    }
    
}
