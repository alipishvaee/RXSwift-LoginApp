//
//  LoginViewModel.swift
//  RXSwift-LoginApp
//
//  Created by Ali Pishvaee on 2/2/21.
//

import Foundation
import RxSwift

class LoginViewModel {
    let userNameTextPublished = PublishSubject<String>()
    let passwordTextPublished = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(userNameTextPublished.asObservable().startWith(""), passwordTextPublished.asObservable().startWith("")).map { userName, password in
            return userName.count > 4 && password.count > 7
        }.startWith(false)
    }
}
