import UIKit
import CoreData

final class CoreDataHelper {
    static let shared = CoreDataHelper()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "User")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()

    func saveData(currentName: String, currentGender: String?, currentDOB: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        guard let nameObject = NSEntityDescription.entity(forEntityName: "User", in: context) else { return }

        let user = User(entity: nameObject, insertInto: context)
        user.name = currentName
        user.gender = currentGender
        user.dateOfBirth = currentDOB

        do {
            try context.save()
            print("Data has been saved")
        } catch {
            print("Error has been occurred during saving: \(error)")
        }
    }

    func updateData(newName: String, gender: String?, dob: String?, currentUser: User?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return }
        currentUser?.name = newName
        currentUser?.gender = gender
        currentUser?.dateOfBirth = dob

        do {
            try context.save()
            print("Data has been updated")
        } catch {
            print("Error has been occurred during updating: \(error)")
        }
    }

    func fetchData() -> [User] {
        var currentData = [User]()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { fatalError() }

        let fetchRequest: NSFetchRequest<User> = NSFetchRequest(entityName: "User")

        do {
            currentData = try context.fetch(fetchRequest)
        } catch {
            print("Error occurred during fetching data")
        }

        return currentData
    }

    func deleteData(userEntity: User) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { fatalError() }
        context.delete(userEntity)

        do {
            try context.save()
            print("Data has been deleted")
        } catch {
            print("Error has been occurred during deleting: \(error)")
        }
    }
}
