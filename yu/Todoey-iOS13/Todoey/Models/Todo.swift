import Foundation
import RealmSwift

class Todo: Object {
    @Persisted var title: String = ""
    @Persisted var done: Bool = false
    var parentCategory = LinkingObjects(fromType: TodoCategory.self, property: "todos")
}
