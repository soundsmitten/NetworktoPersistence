//Created 2020

import RealmSwift

@objcMembers
class PersonModel: Object {
    dynamic var id: Int = 0
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var birthDate: Date?
    dynamic var locationName: String?
    dynamic var address: String = ""
    dynamic var city: String = ""
    dynamic var state: String = ""
    dynamic var zip: String = ""
    dynamic var latitude: Double = 0
    dynamic var longitude: Double = 0

    // See Persistable `meta` param.
    dynamic var someRandomMetaValue: Int = 0
}

// utility stuff
extension PersonModel {
    var fullName: String {
        return "\(firstName) \(lastName)"
    }

    var formattedAddress: String {
        var text = ""

        if let locationName = locationName {
            text += "\(locationName)\n"
        }

        text += """
                \(address)
                \(city), \(state) \(zip)
                """

        return text
    }
}
