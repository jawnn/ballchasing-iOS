import UIKit

class NewUserViewController: UIViewController {

    let defaults = UserDefaults.standard

    private weak var textField: UITextField!
    private weak var submitButton: UIButton!

    override func loadView() {
        super.loadView()

        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false

        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubviews(textField, button)

        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 44),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -16),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])

        self.textField = textField
        self.submitButton = button
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        textField.delegate = self

        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.backgroundColor = .secondarySystemBackground
        textField.textColor = .label
        textField.placeholder = "Steam Id"

        submitButton.layer.borderWidth = 2
        submitButton.layer.cornerRadius = 8
        submitButton.backgroundColor = .secondarySystemBackground
        submitButton.layer.borderColor = UIColor.gray.cgColor
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.label, for: .normal)
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
    }

    @objc func didTapSubmitButton() {
        guard let input = textField.text, !input.isEmpty else {
            let ac = UIAlertController(title: "Steam Id cannot be empty", message: "", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
            return
        }
        defaults.setValue(input, forKey: "steamId")
    }

}

extension NewUserViewController: UITextFieldDelegate {

}
