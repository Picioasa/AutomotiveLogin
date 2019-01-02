//
//  FormsView.swift
//  AutomotiveLogin
//
//  Created by Vlad Gachi on 26/12/2018.
//  Copyright © 2018 Vlad Gachi. All rights reserved.
//

import UIKit

protocol FormsViewDelegate: class {
  func didChangedTo(gear: Int)
}

class FormsView: UIView {
  
  // MARK: - Properties
  weak var delegate: FormsViewDelegate?
  
  private var signUpButtonXConst: NSLayoutConstraint!
  private var mobileTFXConst: NSLayoutConstraint!
  private var emailTFXConst: NSLayoutConstraint!
  private var passwordTFXConst: NSLayoutConstraint!
  private var usernameTFXConst: NSLayoutConstraint!
  
  private var gear: Int = 0
  
  private var invalidateForm = false
  private var hasUsername = false
  private var hasPassword = false
  private var hasEmail = false
  private var hasMobile = false
  
  private let usernameTextField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.placeholder = "The Stig"
    tf.font = UIFont(name: "Copperplat", size: 20)
    tf.borderStyle = .roundedRect
    tf.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    tf.tintColor = #colorLiteral(red: 0.8156862745, green: 0.2862745098, blue: 0.3176470588, alpha: 1)
    tf.addTarget(self, action: #selector(handleInsertUsername), for: UIControl.Event.editingDidEnd)
    tf.addTarget(self, action: #selector(handleTextInputAllFields), for: UIControl.Event.editingChanged)
    return tf
  }()
  
  private let passwordTextField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.placeholder = "Strong Password"
    tf.font = UIFont(name: "Copperplat", size: 20)
    tf.isSecureTextEntry = true
    tf.borderStyle = .roundedRect
    tf.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    tf.tintColor = #colorLiteral(red: 0.8156862745, green: 0.2862745098, blue: 0.3176470588, alpha: 1)
    tf.addTarget(self, action: #selector(handleInsertPassword), for: UIControl.Event.editingDidEnd)
    tf.addTarget(self, action: #selector(handleTextInputAllFields), for: UIControl.Event.editingChanged)
    return tf
  }()
  
  private let emailTextField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.placeholder = "Stigno1@hotmail.com"
    tf.font = UIFont(name: "Copperplat", size: 20)
    tf.keyboardType = .emailAddress
    tf.borderStyle = .roundedRect
    tf.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    tf.tintColor = #colorLiteral(red: 0.8156862745, green: 0.2862745098, blue: 0.3176470588, alpha: 1)
    tf.addTarget(self, action: #selector(handleInsertEmail), for: UIControl.Event.editingDidEnd)
    tf.addTarget(self, action: #selector(handleTextInputAllFields), for: UIControl.Event.editingChanged)
    return tf
  }()
  
  private let mobileTextField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.placeholder = "0800-4567-Stig"
    tf.font = UIFont(name: "Copperplat", size: 20)
    tf.keyboardType = .numberPad
    tf.borderStyle = .roundedRect
    tf.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    tf.tintColor = #colorLiteral(red: 0.8156862745, green: 0.2862745098, blue: 0.3176470588, alpha: 1)
    tf.addTarget(self, action: #selector(handleInsertMobile), for: UIControl.Event.editingDidEnd)
    tf.addTarget(self, action: #selector(handleTextInputAllFields), for: UIControl.Event.editingChanged)
    return tf
  }()
  
  private let signUpButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("Sign Up", for: .normal)
    btn.titleLabel?.font = UIFont(name: "Copperplat-Bold", size: 18)
    btn.titleLabel?.textColor = .white
    btn.tintColor = #colorLiteral(red: 0.9833072077, green: 0.2862745098, blue: 0.3176470588, alpha: 1)
    btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    return btn
  }()
  
  
  // MARK: - Object Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    
    setupViews()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Private Methods
  private func setupViews() {
    addSubview(usernameTextField)
    addSubview(passwordTextField)
    addSubview(emailTextField)
    addSubview(mobileTextField)
    addSubview(signUpButton)
    
    usernameTextField.delegate = self
    passwordTextField.delegate = self
    emailTextField.delegate = self
    mobileTextField.delegate = self

    signUpButtonXConst = signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -400)
    mobileTFXConst = mobileTextField.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -400)
    emailTFXConst = emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -400)
    passwordTFXConst = passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -400)
    usernameTFXConst = usernameTextField.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -400)
    
    NSLayoutConstraint.activate([
      usernameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      usernameTextField.heightAnchor.constraint(equalToConstant: 35),
      usernameTextField.widthAnchor.constraint(equalToConstant: 200),
      usernameTFXConst,
      
      passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10),
      passwordTextField.heightAnchor.constraint(equalToConstant: 35),
      passwordTextField.widthAnchor.constraint(equalToConstant: 200),
      passwordTFXConst,
      
      emailTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
      emailTextField.heightAnchor.constraint(equalToConstant: 35),
      emailTextField.widthAnchor.constraint(equalToConstant: 200),
      emailTFXConst,
      
      mobileTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
      mobileTextField.heightAnchor.constraint(equalToConstant: 35),
      mobileTextField.widthAnchor.constraint(equalToConstant: 200),
      mobileTFXConst,
      
      signUpButton.topAnchor.constraint(equalTo: mobileTextField.bottomAnchor, constant: 10),
      signUpButton.heightAnchor.constraint(equalToConstant: 55),
      signUpButton.widthAnchor.constraint(equalToConstant: 200),
      signUpButtonXConst
      ])
    
    layoutIfNeeded()
    
    animateViewsIn()
  }
  
  private func animateViewsIn() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      guard let self = self else { return }
      
      UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
        self.signUpButtonXConst.constant += 400
        self.layoutIfNeeded()
      })

      UIView.animate(withDuration: 0.7, delay: 0.2, options: .curveEaseOut, animations: {
        self.mobileTFXConst.constant += 400
        self.layoutIfNeeded()
      })
      
      UIView.animate(withDuration: 0.6, delay: 0.35, options: .curveEaseOut, animations: {
        self.emailTFXConst.constant += 400
        self.layoutIfNeeded()
      })
      
      UIView.animate(withDuration: 0.5, delay: 0.4, options: .curveEaseOut, animations: {
        self.passwordTFXConst.constant += 400
        self.layoutIfNeeded()
      })
      
      UIView.animate(withDuration: 0.7, delay: 0.45, options: .curveEaseOut, animations: {
        self.usernameTFXConst.constant += 400
        self.layoutIfNeeded()
      })
    }
  }
  
  private func animateViewsOut() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      guard let self = self else { return }
      
      UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
        self.signUpButtonXConst.constant += 400
        self.layoutIfNeeded()
      }, completion: { _ in
        self.signUpButtonXConst.constant -= 800
        self.layoutIfNeeded()
      })
      
      UIView.animate(withDuration: 0.7, delay: 0.2, options: .curveEaseOut, animations: {
        self.mobileTFXConst.constant += 400
        self.layoutIfNeeded()
      }, completion: { _ in
        self.mobileTFXConst.constant -= 800
        self.layoutIfNeeded()
      })
      
      UIView.animate(withDuration: 0.6, delay: 0.35, options: .curveEaseOut, animations: {
        self.emailTFXConst.constant += 400
        self.layoutIfNeeded()
      }, completion: { _ in
        self.emailTFXConst.constant -= 800
        self.layoutIfNeeded()
      })
      
      UIView.animate(withDuration: 0.5, delay: 0.4, options: .curveEaseOut, animations: {
        self.passwordTFXConst.constant += 400
        self.layoutIfNeeded()
      }, completion: { _ in
        self.passwordTFXConst.constant -= 800
        self.layoutIfNeeded()
      })
      
      UIView.animate(withDuration: 0.7, delay: 0.45, options: .curveEaseOut, animations: {
        self.usernameTFXConst.constant += 400
        self.layoutIfNeeded()
      }, completion: { _ in
        self.usernameTFXConst.constant -= 800
        self.layoutIfNeeded()
      })
    }
    
  }
  
  private func shiftTo(gear: Int) {
    
    switch gear {
    case 1:
      delegate?.didChangedTo(gear: 1)
    case 2:
      delegate?.didChangedTo(gear: 2)
    case 3:
      delegate?.didChangedTo(gear: 3)
    case 4:
      delegate?.didChangedTo(gear: 4)
    case 5:
      delegate?.didChangedTo(gear: 5)

    case -1:
      delegate?.didChangedTo(gear: -1)
    case -2:
      delegate?.didChangedTo(gear: -2)
    case -3:
      delegate?.didChangedTo(gear: -3)
    case -4:
      delegate?.didChangedTo(gear: -4)
    case -5:
      delegate?.didChangedTo(gear: -5)

    default:
      delegate?.didChangedTo(gear: 99)
    }
    
  }

  @objc private func handleInsertUsername() {
    
    if usernameTextField.text?.count ?? 0 > 0 {
      if hasUsername { return }
      if gear == 4 { return }
      hasUsername = true
      gear += 1
      shiftTo(gear: gear)

    } else {
      if !hasUsername { return }
      if invalidateForm { invalidateForm = false; hasUsername = false; return }
      hasUsername = false
      
      if gear == 1 {
        shiftTo(gear: -1)
        gear -= 1
        return
      } else if gear == 2 {
        shiftTo(gear: -2)
        gear -= 1
        return
      } else if gear == 3 {
        shiftTo(gear: -3)
        gear -= 1
        return
      }
      
      shiftTo(gear: -gear)
      gear -= 1
    }
  }
  
  @objc private func handleInsertPassword() {

    if passwordTextField.text?.count ?? 0 > 0 {
      if hasPassword { return }
      hasPassword = true
      if gear == 4 { return }
      gear += 1
      shiftTo(gear: gear)
      
    } else {
      if !hasPassword { return }
      if invalidateForm { invalidateForm = false; hasPassword = false; return }
      hasPassword = false
      
      if gear == 1 {
        shiftTo(gear: -1)
        gear -= 1
        return
      } else if gear == 2 {
        shiftTo(gear: -2)
        gear -= 1
        return
      } else if gear == 3 {
        shiftTo(gear: -3)
        gear -= 1
        return
      }
      
      shiftTo(gear: -gear)
      gear -= 1
    }
  }
  
  @objc private func handleInsertEmail() {
    
    if emailTextField.text?.count ?? 0 > 0 {
      if hasEmail { return }
      if gear == 4 { return }
      hasEmail = true
      gear += 1
      shiftTo(gear: gear)
      
    } else {
      if !hasEmail { return }
      if invalidateForm { invalidateForm = false; hasEmail = false; return }
      hasEmail = false
      
      if gear == 1 {
        shiftTo(gear: -1)
        gear -= 1
        return
      } else if gear == 2 {
        shiftTo(gear: -2)
        gear -= 1
        return
      } else if gear == 3 {
        shiftTo(gear: -3)
        gear -= 1
        return
      }
      
      shiftTo(gear: -gear)
      gear -= 1
    }
  }

  
  @objc private func handleInsertMobile() {
    
    if mobileTextField.text?.count ?? 0 > 0 {
      if hasMobile { return }
      if gear == 4 { return }
      hasMobile = true
      gear += 1
      shiftTo(gear: gear)
      
    } else {
      if !hasMobile { return }
      if invalidateForm { invalidateForm = false; hasMobile = false; return }
      hasMobile = false
      
      if gear == 1 {
        shiftTo(gear: -1)
        gear -= 1
        return
      } else if gear == 2 {
        shiftTo(gear: -2)
        gear -= 1
        return
      } else if gear == 3 {
        shiftTo(gear: -3)
        gear -= 1
        return
      }
      
      shiftTo(gear: -gear)
      gear -= 1
    }
  }
  
  @objc private func handleTextInputAllFields() {
    let isFormValid = usernameTextField.text?.count ?? 0 > 0 &&
                      passwordTextField.text?.count ?? 0 > 0 &&
                      emailTextField.text?.count ?? 0 > 0 &&
                      mobileTextField.text?.count ?? 0 > 0
    
    if isFormValid && gear == 3 {
      gear += 1
      shiftTo(gear: 4)
    } else if !isFormValid && gear == 4 {
      invalidateForm = true
      hasUsername = true
      hasPassword = true
      hasEmail = true
      hasMobile = true
      gear -= 1
      shiftTo(gear: -4)
    }
    
  }
  
  @objc private func handleSignUp() {
    
    if gear == 4 {
      shiftTo(gear: 5)
      
      usernameTextField.resignFirstResponder()
      passwordTextField.resignFirstResponder()
      emailTextField.resignFirstResponder()
      mobileTextField.resignFirstResponder()
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        self.animateViewsOut()
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        self.shiftTo(gear: -5)
        self.animateViewsIn()
      }
      
      
    }
  }
  
}


// MARK: - UITextFieldDelegate
extension FormsView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Move onto the next textField upon pressing done button
    if textField == usernameTextField {
      usernameTextField.resignFirstResponder()
      passwordTextField.becomeFirstResponder()

    } else if textField == passwordTextField {
      passwordTextField.resignFirstResponder()
      emailTextField.becomeFirstResponder()

    } else if textField == emailTextField {
      emailTextField.resignFirstResponder()
      mobileTextField.becomeFirstResponder()

    } else if textField == mobileTextField {
      mobileTextField.resignFirstResponder()
      return true
    }

    return false
  }
}




















