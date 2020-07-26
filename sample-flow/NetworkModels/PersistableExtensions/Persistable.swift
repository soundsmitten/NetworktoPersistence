//Created 2020
// https://stackoverflow.com/questions/35060391/how-to-save-a-struct-to-realm-in-swift with modifications.

import RealmSwift

enum PersistableEncodingError: Error {
    case error(message: String)
}

enum ModelDecodingError: Error {
    case error(message: String)
}

// I feel that throwing an error on these bridging methods
// seems to be more elegant than returning optionals?
protocol Persistable {
    associatedtype ManagedObject: Object

    init(managedObject: ManagedObject) throws

    // meta param allows for some custom options/props to be passed in.
    func managedObject(meta: PersistableMetadata?) throws -> ManagedObject
}

extension Persistable {
    init(managedObject: ManagedObject) {}
}

typealias PersistableMetadata = Codable
