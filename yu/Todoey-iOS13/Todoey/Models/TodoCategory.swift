import Foundation
import RealmSwift

class TodoCategory: Object {
    @Persisted var name: String = ""
    @Persisted var todos = List<Todo>()
    @Persisted var rowColor: String = "5856D6"
}
