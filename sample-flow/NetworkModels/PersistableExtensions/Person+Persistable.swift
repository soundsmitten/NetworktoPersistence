//Created 2020

struct PersonMetaData: PersistableMetadata {
    let someRandomMetaValue: Int
}

extension Person: Persistable {
    init?(managedObject: PersonModel) {
        guard managedObject.id != 0 else {
            assertionFailure("Invalid id")
            return nil
        }

        id = managedObject.id
        firstName = managedObject.firstName
        lastName = managedObject.lastName
        dob = managedObject.birthDate
        geography = Geography(name: managedObject.locationName,
                              address: managedObject.address,
                              city: managedObject.city,
                              state: managedObject.state,
                              zip: managedObject.zip,
                              lat: managedObject.latitude,
                              lon: managedObject.longitude)
    }

    func managedObject(meta: PersistableMetadata?) -> PersonModel? {
        // if we want to require properties, unwrap them and throw an error if missing.
        // Before I tried reflection, and listing out KeyPaths,
        // but it wasn't worth fighting Swift.
        guard
            let meta = meta as? PersonMetaData,
            let firstName = firstName,
            let lastName = lastName,
            let dob = dob,
            let geography = geography,
            let address = geography.address,
            let city = geography.city,
            let state = geography.state,
            let zip = geography.zip,
            let latitude = geography.lat,
            let longitude = geography.lon else {
            assertionFailure("\(Person.self) is missing required values")
            return nil
        }

        let person = PersonModel()
        person.id = id
        person.firstName = firstName
        person.lastName = lastName
        person.birthDate = dob

        // location name is optional property
        person.locationName = geography.name

        person.address = address
        person.city = city
        person.state = state
        person.latitude = latitude
        person.longitude = longitude

        person.someRandomMetaValue = meta.someRandomMetaValue

        return person
    }

    typealias ManagedObject = PersonModel
}

