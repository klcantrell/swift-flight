import Foundation
import RealmSwift

class Todo: Object {
    @Persisted var title: String = ""
    @Persisted var done: Bool = false
    @Persisted var dateCreated: Date = Date()
    @Persisted(originProperty: "todos") var parentCategory: LinkingObjects<TodoCategory>
}
