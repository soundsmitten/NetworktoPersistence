//Created 2020
// Modified from https://medium.com/@aliakhtar_16369/lightweight-persistence-layer-with-realm-realmswift-part-5-7f5a707e35e8

import Foundation

enum DataManagerError: Error {
    case invalidModel(message: String)
    case invalidStore(message: String)
}

public protocol Managed {}

protocol DataManager {
    func create<T: Managed>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws
    func save(object: Managed) throws
    func update(object: Managed) throws
    func delete(object: Managed) throws
    func deleteAll<T: Managed>(_ model: T.Type) throws
    func fetch<T: Managed>(_ model: T.Type, predicate: NSPredicate?, sortOptions: SortOptions?, completion: (([T]) -> ())) throws
    func nuke() throws
}
