//
//  GearView.swift
//  AutomotiveLogin
//
//  Created by Vlad Gachi on 26/12/2018.
//  Copyright © 2018 Vlad Gachi. All rights reserved.
//

import UIKit

protocol GearViewDelegate: class {
  func didChangeGear()
}

class GearView: UIView {
  
  private enum Gear: Int {
    case neutral = 0, one, two, three, four, five
    case oneToNeutral = -1
    case twoToOne = -2
    case threeToTwo = -3
    case fourToThree = -4
    case fiveToFour = -5
  }
  
  
  // MARK: - Properties
  weak var delegate: GearViewDelegate?
  
  private var gear = 0

  private var gearKnobYConstraint: NSLayoutConstraint!
  private var gearKnobXConstraint: NSLayoutConstraint!
  
  private let gearImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.image = UIImage(named: "gear")
    return iv
  }()
  
  private let gearKnobImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.image = UIImage(named: "gearKnob")
    return iv
  }()
  
  
  // MARK: - View Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
        
    translatesAutoresizingMaskIntoConstraints = false
    alpha = 0

    setupViews()
    fadeIn()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Private Methods
  private func fadeIn() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      UIView.animate(withDuration: 1, animations: {
        self.alpha = 1
        self.layoutIfNeeded()
      })
    }
  }
  
  private func setupViews() {
    addSubview(gearImageView)
    addSubview(gearKnobImageView)
    
    gearKnobYConstraint = gearKnobImageView.centerYAnchor.constraint(equalTo: gearImageView.centerYAnchor, constant: 0)
    gearKnobXConstraint = gearKnobImageView.centerXAnchor.constraint(equalTo: gearImageView.centerXAnchor, constant: 0)
    
    NSLayoutConstraint.activate([
      gearImageView.topAnchor.constraint(equalTo: topAnchor),
      gearImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gearImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      gearImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      gearKnobXConstraint,
      gearKnobYConstraint,
      gearKnobImageView.widthAnchor.constraint(equalToConstant: 45),
      gearKnobImageView.heightAnchor.constraint(equalToConstant: 45),
      ])
    
    layoutIfNeeded()
  }
  
  private func shiftUp(gear: Gear, withDuration: Double) {
    self.gear = gear.rawValue
    
    var position = (0.0, 0.0, 0.0)
    
    switch gear {
    case .neutral:
      position = (45, -70, 0)
    case .one:
      position = (0, -35, -30)
    case .two:
      position = (57, 0, 0)
    case .three:
      position = (-30, 35, -30)
    case .four:
      position = (67, 0, 0)
    case .five:
      position = (-35, 35, -30)
    default:
      position = (0, 0, 0)
    }
    
    UIView.animateKeyframes(withDuration: withDuration, delay: 0, options: [], animations: {
      
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
        self.gearKnobYConstraint.constant += CGFloat(position.0)
        self.layoutIfNeeded()
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.4, animations: {
        self.gearKnobXConstraint.constant += CGFloat(position.1)
        self.layoutIfNeeded()
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
        self.gearKnobYConstraint.constant += CGFloat(position.2)
        self.layoutIfNeeded()
      })
      
    })
  }
  
  private func shiftDown(gear: Gear, withDuration: Double) {
    self.gear = gear.rawValue
    
    var position = (0.0, 0.0, 0.0)
    
    switch gear {
    case .neutral:
      position = (0, 0, 0)
    case .oneToNeutral:
      position = (32, 35, 0)
    case .twoToOne:
      position = (-60, 0, 0)
    case .threeToTwo:
      position = (30, -35, 30)
    case .fourToThree:
      position = (-67, 0, 0)
    case .fiveToFour:
      position = (35, -35, 30)
    default:
      position = (0, 0, 0)
    }
    
    UIView.animateKeyframes(withDuration: withDuration, delay: 0, options: [], animations: {
      
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
        self.gearKnobYConstraint.constant += CGFloat(position.0)
        self.layoutIfNeeded()
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.4, animations: {
        self.gearKnobXConstraint.constant += CGFloat(position.1)
        self.layoutIfNeeded()
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
        self.gearKnobYConstraint.constant += CGFloat(position.2)
        self.layoutIfNeeded()
      })
      
    })
  }
  
  
  // MARK: - Public Methods
  public func shiftTo(gear: Int) {

    switch gear {
    case 1:
      shiftUp(gear: .one, withDuration: 1)
    case 2:
      shiftUp(gear: .two, withDuration: 0.9)
    case 3:
      shiftUp(gear: .three, withDuration: 1.3)
    case 4:
      shiftUp(gear: .four, withDuration: 0.9)
    case 5:
      shiftUp(gear: .five, withDuration: 1.3)
      
    case -1:
      shiftDown(gear: .oneToNeutral, withDuration: 1)
    case -2:
      shiftDown(gear: .twoToOne, withDuration: 0.9)
    case -3:
      shiftDown(gear: .threeToTwo, withDuration: 1.3)
    case -4:
      shiftDown(gear: .fourToThree, withDuration: 0.9)
    case -5:
      shiftDown(gear: .fiveToFour, withDuration: 1.3)
      
    default:
      shiftUp(gear: .neutral, withDuration: 1)
    }
  }
  
}


























