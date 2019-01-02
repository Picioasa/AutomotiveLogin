//
//  ViewController.swift
//  AutomotiveLogin
//
//  Created by Vlad Gachi on 25/12/2018.
//  Copyright © 2018 Vlad Gachi. All rights reserved.
//

import UIKit

class AutomotiveController: UIViewController {
  
  // MARK: - Properties
  private let carView = CarView()
  private let gearView = GearView()
  private let formsView = FormsView()

  
  // MARK: - Controller Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.1254901961, blue: 0.1254901961, alpha: 1)
    setupViews()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  // MARK: - Private Methods
  private func setupViews() {
    view.addSubview(carView)
    view.addSubview(gearView)
    view.addSubview(formsView)
    
    formsView.delegate = self
    
    NSLayoutConstraint.activate([
      carView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
      carView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
      carView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
      carView.heightAnchor.constraint(equalToConstant: 160),
      
      gearView.centerYAnchor.constraint(equalTo: formsView.centerYAnchor, constant: -30),
      gearView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
      gearView.widthAnchor.constraint(equalToConstant: 140),
      gearView.heightAnchor.constraint(equalToConstant: 140),
      
      formsView.topAnchor.constraint(equalTo: carView.bottomAnchor, constant: 16),
      formsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
      formsView.widthAnchor.constraint(equalToConstant: 200),
      formsView.heightAnchor.constraint(equalToConstant: 250),
      ])
  }
  
}


// MARK: - FormsViewDelegate
extension AutomotiveController: FormsViewDelegate {
  
  func didChangedTo(gear: Int) {
    gearView.shiftTo(gear: gear)
  }
  
}










