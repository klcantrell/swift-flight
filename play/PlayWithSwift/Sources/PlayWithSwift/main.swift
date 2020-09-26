import Foundation

let fm = FileManager.default
let path = URL(fileURLWithPath: Bundle.main.resourcePath!)

let files = try! fm.contentsOfDirectory(at: path, 
                    includingPropertiesForKeys: [.nameKey, .creationDateKey], 
                    options: .skipsHiddenFiles)

for file in files {
    let fileAttributes = try! file.resourceValues(forKeys: [.nameKey, .creationDateKey])
    print("Found \(fileAttributes.name!), created at \(fileAttributes.creationDate!)")
}
