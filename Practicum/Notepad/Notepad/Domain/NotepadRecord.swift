import Foundation

protocol NotepadRecord {
    var title: String { get }
    var body: String { get }
}

struct Record: NotepadRecord {
    let title: String
    let body: String
}
