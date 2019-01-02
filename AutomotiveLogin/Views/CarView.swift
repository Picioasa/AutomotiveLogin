//
//  CarView.swift
//  AutomotiveLogin
//
//  Created by Vlad Gachi on 30/12/2018.
//  Copyright © 2018 Vlad Gachi. All rights reserved.
//

import UIKit

class CarView: UIView {
  
  // MARK: - Properties
  private var carIVXConst: NSLayoutConstraint!

  private let carImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(named: "car")
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    return iv
  }()
  
  private let automotiveLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Automotive"
    label.textAlignment = .center
    label.font = UIFont(name: "Copperplate-Bold", size: 28)
    label.textColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    label.alpha = 0
    return label
  }()
  
  
  // MARK: - View Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Private Methods
  private func setupViews() {
    addSubview(carImageView)
    addSubview(automotiveLabel)
    
    carIVXConst = carImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -300)
    
    NSLayoutConstraint.activate([
      carImageView.topAnchor.constraint(equalTo: topAnchor),
      carImageView.widthAnchor.constraint(equalToConstant: 220),
      carImageView.heightAnchor.constraint(equalToConstant: 100),
      carIVXConst,
      
      automotiveLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 0),
      automotiveLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
      automotiveLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
      automotiveLabel.heightAnchor.constraint(equalToConstant: 50)
      ])
    
    layoutIfNeeded()
    
    animateViews()
  }
  
  private func animateViews() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      guard let self = self else { return }
      UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
        self.carIVXConst.constant += 300
        self.layoutIfNeeded()
      }, completion: {_ in
        UIView.animate(withDuration: 0.8, animations: {
          self.automotiveLabel.alpha = 1
        })
      })
    }
  }
  
}


























