import UIKit

final class DetailsController: UIViewController {

    private let user: User
    private lazy var detailsView = DetailsView()

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureDetailsView()
    }

    private func configureDetailsView() {
        detailsView.delegate = self
        detailsView.nameTextField.text = user.name
        detailsView.genderTextField.text = user.gender
        detailsView.dobTextField.text = user.dateOfBirth ?? "dd.mm.yyyy"
    }
}

extension DetailsController: DetailsViewDelegate {

    func editButtonTapped() {
        detailsView.toggleEditMode(isEditing: true)
    }

    func saveButtonTapped(newName: String, newGender: String?, dob: String) {
        CoreDataHelper.shared.updateData(newName: newName, gender: newGender, dob: dob, currentUser: user)
        navigationController?.popViewController(animated: true)
    }
}
