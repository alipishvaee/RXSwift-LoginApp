//
//  ViewController.swift
//  RXSwift-LoginApp
//
//  Created by Ali Pishvaee on 1/17/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    private let disposeBag = DisposeBag()
    private let loginViewModel = LoginViewModel()
    
    @IBAction func tappedLoginButton(_ sender: UIButton) {
        print("Login Button Tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.becomeFirstResponder()
        usernameTextField.rx.text.map({ $0 ?? "" }).bind(to: loginViewModel.userNameTextPublished).disposed(by: disposeBag)
        passwordTextField.rx.text.map({ $0 ?? "" }).bind(to: loginViewModel.passwordTextPublished).disposed(by: disposeBag)
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map({ $0 ? 1 : 0.1 }).bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }
}

class LoginViewModel {
    let userNameTextPublished = PublishSubject<String>()
    let passwordTextPublished = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(userNameTextPublished.asObservable().startWith(""), passwordTextPublished.asObservable().startWith("")).map { userName, password in
            return userName.count > 4 && password.count > 7
        }.startWith(false)
    }
}

