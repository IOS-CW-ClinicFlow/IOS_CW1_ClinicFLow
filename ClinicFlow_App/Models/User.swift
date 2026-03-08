import Foundation

/// Simple user model used during sign-up/login flows.
struct User {
    var fullName: String
    var email: String
    var phone: String

    static let example = User(fullName: "Saman Edirimuni",
                               email: "ABC@gmail.com",
                               phone: "760012123")
}
