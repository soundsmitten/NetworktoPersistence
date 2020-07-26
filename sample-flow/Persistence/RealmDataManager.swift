//Created 2020

import RealmSwift

extension Object: Managed {}
extension Results: Managed{}

class RealmDataManager: DataManager {
    private let realm: Realm?

    init(_ realm: Realm) {
        self.realm = realm
    }

    func create<T>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws where T: Managed {
        guard let realm = realm else {
            throw DataManagerError.invalidStore(message: "Realm does not exist.")
        }

        guard let model = model as? Object.Type else {
            throw DataManagerError.invalidModel(message: "\(T.self) is not a Realm Object")
        }

        try realm.write {
            guard let object = realm.create(model, value: [], update: .all) as? T else {
                throw DataManagerError.invalidModel(message: "Can't create object: \(T.self)")
            }

            completion(object)
        }
    }

    func save(object: Managed) throws {
        guard let realm = realm else {
            throw DataManagerError.invalidStore(message: "Realm does not exist.")
        }

        guard let object = object as? Object else {
            throw DataManagerError.invalidModel(message: "Not a Realm Object")
        }

        try realm.write {
            realm.add(object)
        }
    }

    func update(object: Managed) throws {
        guard let realm = realm else {
            throw DataManagerError.invalidStore(message: "Realm does not exist.")
        }

        guard let object = object as? Object else {
            throw DataManagerError.invalidModel(message: "Not a Realm Object")
        }

        try realm.write {
            realm.add(object, update: .modified)
        }
    }

    func delete(object: Managed) throws {
        guard let realm = realm else {
            throw DataManagerError.invalidStore(message: "Realm does not exist.")
        }

        guard let object = object as? Object else {
            throw DataManagerError.invalidModel(message: "Not a Realm Object")
        }

        try realm.write {
            realm.delete(object)
        }
    }

    func deleteAll<T>(_ model: T.Type) throws where T: Managed {
        guard let realm = realm else {
            throw DataManagerError.invalidStore(message: "Realm does not exist.")
        }

        guard let model = model as? Object.Type else {
            throw DataManagerError.invalidModel(message: "\(T.self) is not a Realm Object")
        }

        try realm.write {
            let objects = realm.objects(model)
            for object in objects {
                realm.delete(object)
            }
        }
    }

    func fetch<T: Managed>(_ model: T.Type,
                           predicate: NSPredicate?,
                           sortOptions: SortOptions?,
                           completion: ((Managed) -> ())) {
        guard let realm = realm else {
            assertionFailure("Realm does not exist")
            return
        }

        guard let model = model as? Object.Type else {
            assertionFailure("\(T.self) is not a Realm object")
            return
        }

        var objects = realm.objects(model)
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }

        if let sortOptions = sortOptions {
            objects = objects.sorted(byKeyPath: sortOptions.keyPath,
                                     ascending: sortOptions.ascending)
        }

        completion(objects)
    }

    func nuke() {
        guard let realm = realm else {
            assertionFailure("Realm does not exist")
            return
        }

        realm.deleteAll()
    }
}

struct SortOptions {
    let keyPath: String
    let ascending: Bool
}
