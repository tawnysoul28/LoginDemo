extension DateFormatter {
    
    static var short: DateFormatter = {
        let result = DateFormatter()
        result.dateStyle = .short
        return result
    }()
    
    static var medium: DateFormatter = {
        let result = DateFormatter()
        result.timeStyle = .medium
        result.dateStyle = .medium
        return result
    }()
    
    static var long: DateFormatter = {
        let result = DateFormatter()
        result.timeStyle = .long
        result.dateStyle = .long
        return result
    }()
    
}
