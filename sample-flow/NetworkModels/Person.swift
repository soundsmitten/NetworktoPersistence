//Created 2020

import Foundation

struct Person: Decodable {
    let id: Int
    let firstName: String?
    let lastName: String?
    let dob: Date?
    let geography: Geography?
}
