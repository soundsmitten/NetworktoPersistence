//Created 2020

enum ChangeSet {
    case initial
    case diff(insertions: [Int], deletions: [Int], modifications: [Int])
    case error(Error)
}

protocol ManagedObserver {
    func subscribe(to results: Managed, completion: @escaping (_ changes: ChangeSet) -> ())
}
