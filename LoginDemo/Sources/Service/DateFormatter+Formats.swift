extension DateFormatter {
    
    static var medium: DateFormatter = {
        let result = DateFormatter()
        result.timeStyle = .medium
        result.dateStyle = .medium
        return result
    }()
    
}
