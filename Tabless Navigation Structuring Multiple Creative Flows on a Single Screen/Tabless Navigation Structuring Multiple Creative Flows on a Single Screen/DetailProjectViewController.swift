//
//  DetailProjectViewController.swift
//  Tabless Navigation Structuring Multiple Creative Flows on a Single Screen
//
//  Created by Stephano Portella on 03/05/25.
//
import UIKit

class DetailProjectViewController: UIViewController {

    private let project: Project

    /// Dark blur effect over background
    private let blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemThickMaterialDark)
        let view = UIVisualEffectView(effect: effect)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// Semi-opaque container for image
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.9)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView = UIImageView()
    private let closeButton = UIButton(type: .system)

    init(project: Project) {
        self.project = project
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        // Add blur and container
        view.addSubview(blurView)
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])

        setupContent()
        animateIn()
    }

    private func setupContent() {
        // Configure image view
        imageView.image = project.thumbnail
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)

        // Tap to dismiss and select another
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        imageView.addGestureRecognizer(tap)

        // Close button below image
        closeButton.setTitle("Close", for: .normal)
        closeButton.tintColor = .white
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        containerView.addSubview(closeButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -16),

            closeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }

    private func animateIn() {
        containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5,
            options: []
        ) {
            self.blurView.alpha = 1
            self.containerView.transform = .identity
        }
    }

    @objc private func dismissSelf() {
        UIView.animate(withDuration: 0.3, animations: {
            self.blurView.alpha = 0
            self.containerView.alpha = 0
        }) { _ in
            self.dismiss(animated: false)
        }
    }
}
