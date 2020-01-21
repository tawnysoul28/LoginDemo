typealias FactVerbose = (Int) -> String

final class Fact {

    private let factClosure: FactVerbose

    init(factClosure: @escaping FactVerbose) {
        self.factClosure = factClosure
    }

    func title(for age: Int) -> String {
        return self.factClosure(age)
    }

}
