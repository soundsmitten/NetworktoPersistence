//Created 2020

import RealmSwift

class RealmManagedObserver: ManagedObserver {
    var notificationToken: NotificationToken?

    func subscribe(to results: Managed, completion: @escaping (_ changes: ChangeSet) -> ()) {
        guard let results = results as? Results<Object> else {
            return
        }

        let notificationToken = results.observe { change in
            switch change {
            case .initial:
                completion(.initial)
            case let .update(results, deletions, insertions, modifications):
                completion(.diff(insertions: insertions, deletions: deletions, modifications: modifications))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
