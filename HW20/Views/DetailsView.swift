import UIKit
import SnapKit

protocol DetailsViewDelegate: AnyObject {
    func editButtonTapped()
    func saveButtonTapped(newName: String, newGender: String?, dob: String)
}

final class DetailsView: UIView {

    weak var delegate: DetailsViewDelegate?
    
    lazy var personIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.crop.circle"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var nameLabel: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var genderLabel: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.2.fill"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var dobLabel: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "calendar.circle.fill"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    lazy var genderTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.isUserInteractionEnabled = false
        textField.placeholder = "Gender"
        return textField
    }()

    lazy var dobTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Date of Birth"
        textField.inputView = datePicker
        textField.isUserInteractionEnabled = false
        return textField
    }()


    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return datePicker
    }()

    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        toggleEditMode(isEditing: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(personIcon)
        addSubview(nameLabel)
        addSubview(genderLabel)
        addSubview(dobLabel)
        addSubview(nameTextField)
        addSubview(genderTextField)
        addSubview(dobTextField)
        addSubview(editButton)
        addSubview(saveButton)
    }

    private func setupConstraints() {
        personIcon.snp.makeConstraints { make in
            make.bottom.equalTo(nameLabel.snp.top).offset(-80)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
        }

        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
        }

        dobLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
        }

        nameTextField.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }

        genderTextField.snp.makeConstraints { make in
            make.centerY.equalTo(genderLabel)
            make.leading.equalTo(genderLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }

        dobTextField.snp.makeConstraints { make in
            make.centerY.equalTo(dobLabel)
            make.leading.equalTo(dobLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }

        editButton.snp.makeConstraints { make in
            make.top.equalTo(personIcon.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        }

        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(editButton.snp.centerY)
            make.centerX.equalToSuperview()
        }

    }

    func toggleEditMode(isEditing: Bool) {
        nameTextField.isUserInteractionEnabled = isEditing
        genderTextField.isUserInteractionEnabled = isEditing
        dobTextField.isUserInteractionEnabled = isEditing
        editButton.isHidden = isEditing
        saveButton.isHidden = !isEditing
    }

    @objc private func editButtonTapped() {
        delegate?.editButtonTapped()
    }

    @objc private func saveButtonTapped() {
        let newName = nameTextField.text ?? ""
        let newGender = genderTextField.text ?? ""
        let newDOB = dobTextField.text ?? ""
        delegate?.saveButtonTapped(newName: newName, newGender: newGender, dob: newDOB)
    }

    @objc private func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dobTextField.text = dateFormatter.string(from: datePicker.date)
    }
}
