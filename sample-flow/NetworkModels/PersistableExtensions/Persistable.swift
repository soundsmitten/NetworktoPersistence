//Created 2020
// https://stackoverflow.com/questions/35060391/how-to-save-a-struct-to-realm-in-swift with modifications.

import RealmSwift

typealias Persistable = PersistableEncodable & PersistableDecodable

// I feel that throwing an error on these bridging methods
// seems to be more elegant than returning optionals?
protocol PersistableEncodable {
    associatedtype Managed: Object

    init?(managedObject: Managed)

    // meta param allows for some custom options/props to be passed in.
    func managedObject(meta: PersistableMetadata?) -> Managed?
}

protocol PersistableDecodable {
    associatedtype Managed: Object

    init?(managedObject: Managed)
}

typealias PersistableMetadata = Codable
