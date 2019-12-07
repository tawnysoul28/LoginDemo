//
//  HomePresenter.swift
//  LoginDemo
//
//  Created by Bob on 12/11/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation

final class HomePresenter {
    
    private weak var view: (IHomeVC & IRouter)?
    private let authService: AuthService
    private let networkManager: NetworkManager
    
    init(view: (IHomeVC & IRouter), authService: AuthService) {
        self.view = view
        self.authService = authService
        self.networkManager = NetworkManager(sessionConfiguration: URLSessionConfiguration.default)
    }
    
    func onSignInTapEvent(login: String, password: String) {
        if self.authService.isAuthorized(user: login, with: password) {
            self.view?.pushVC("HomeVC")
        } else {
            self.view?.showAlert(title: "Warning!", message: "Login or password isn't matching")
        }
    }
    
    func onQouteButtonEvent() {
        self.networkManager.loadQuote() { [weak self] (result) in
            switch result {
            case let .success(textData):
                DispatchQueue.main.async {
                    print("Загрузка успешно завершена")
                    self?.view?.updateQuote(text: textData)
                }
                
            case .failure(_):
                DispatchQueue.main.async {
                    print("Загрузка завершена с ошибкой")
                }
            }
        }
    }
}
