//
//  RetirementPresenter.swift
//  LoginDemo
//
//  Created by Bob on 29/11/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation
final class RetirementPresenter {
    
    private var strings: [String] = [
        "the very first string with %d",
        "the second string with %d",
        "the trird string with %d",
        
//        "К этому времени у вас будет %d дополнительных рублей, если сегодня вы начнете экономить 100 рублей каждый день. Плюс около %d рублей, если вы бросите курить.",
//        "К этому времени вы прочтете %d новых книг, если начнете читать одну книгу в месяц с сегодняшнего дня.",
//        "%d новых людей появятся в вашей жизни, если сегодня вы начнете знакомиться с одним человеком в неделю."
    ]
    
    private var counter: Int = 0
    
    func nextString() -> (string: String, index: Int) {
        let index = self.counter % strings.count
        guard let string = self.strings.item(at: index) else {
            assertionFailure("Something wrong")
            return ("", 0)
        }
        
        self.counter = self.counter.advanced(by: 1)
        return (string, index)
    }
    
}

//Экстеншен, чтоб заработало:
extension Array {
    
    func item(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    
}

//Пользоваться так:
final class AClass {
    
//    private let label = UILabel()
//    private let stringsService = RetirementPresenter()
//    
//    func didTapButton() {
//        let tuple = self.stringsService.nextString()
//        self.label.text = String(format: tuple.string, tuple.index)
//    }
    
}
