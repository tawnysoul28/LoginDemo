import Foundation
final class RetirementPresenter {
    
    private var facts: [Fact] = [
        Fact { String(format: "К этому времени у вас будет %d дополнительных рублей, если сегодня вы начнете экономить 100 рублей каждый день. Плюс около %d рублей, если вы бросите курить.", 100 * 365 * $0, 29869 * $0) },
        Fact { String(format: "К этому времени вы прочтете %d новых книг, если начнете читать одну книгу в месяц с сегодняшнего дня.", 12 * $0) },
        Fact { String(format: "%d новых людей появятся в вашей жизни, если сегодня вы начнете знакомиться с одним человеком в неделю.", 54 * $0) }
    ]
    
    private var counter: Int = 0
    
    func nextFact() -> Fact {
        let index = self.counter % self.facts.count
        guard let fact = self.facts.item(at: index) else {
            assertionFailure("Something wrong")
            return Fact { _ in "" }
        }
        
        self.counter = self.counter.advanced(by: 1)
        return fact
    }
    
}

//Экстеншен, чтоб заработало:
extension Array {
    
    func item(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    
}
