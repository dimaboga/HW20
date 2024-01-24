import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {

}

extension User {
    @NSManaged public var name: String?
    @NSManaged public var dateOfBirth: String?
    @NSManaged public var gender: String?

}

extension User : Identifiable {

}
