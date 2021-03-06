import Foundation

let fm = FileManager.default
let path = URL(fileURLWithPath: Bundle.main.resourcePath!)

let formatter = DateFormatter()
formatter.dateFormat = "YYYY"

let files = try! fm.contentsOfDirectory(at: path, 
                    includingPropertiesForKeys: [.nameKey, .creationDateKey, .isDirectoryKey], 
                    options: .skipsHiddenFiles)

for file in files {
    let fileAttributes = try! file.resourceValues(forKeys: [.nameKey, .creationDateKey, .isDirectoryKey])

    guard !fileAttributes.isDirectory! else { continue }
    guard file.path != URL(fileURLWithPath: CommandLine.arguments[0]).path else { continue }

    let formattedDate = fileAttributes.creationDate.map { formatter.string(from: $0) }
        ?? "unknown-date"

    let pathToCreate = path.appendingPathComponent(formattedDate, isDirectory: true)

    if !fm.fileExists(atPath: pathToCreate.path) {
        print("\(pathToCreate.path) does not exist")
        print("Creating directory for \(formattedDate)")
        try! fm.createDirectory(
            at: pathToCreate, 
            withIntermediateDirectories: false
        )
    }  

    print("Moving \(file.path) to \(pathToCreate.path)")
    try! fm.moveItem(
        at: file, 
        to: pathToCreate.appendingPathComponent(file.lastPathComponent)
    )
}
