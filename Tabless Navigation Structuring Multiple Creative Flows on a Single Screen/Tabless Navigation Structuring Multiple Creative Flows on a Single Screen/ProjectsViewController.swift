//
//  ProjectsViewController.swift
//  Tabless Navigation Structuring Multiple Creative Flows on a Single Screen
//
//  Created by Stephano Portella on 03/05/25.
//
import UIKit

struct Project {
    let title: String
    let thumbnail: UIImage
}

class ProjectsViewController: UIViewController {

    // MARK: - Properties

    private lazy var projects: [Project] = {
        guard
            let a = UIImage(named: "thumbA"),
            let b = UIImage(named: "thumbB"),
            let c = UIImage(named: "thumbC")
        else {
            fatalError("Missing one of: thumbA, thumbB or thumbC in Assets.xcassets")
        }
        return [
            Project(title: "Project A", thumbnail: a),
            Project(title: "Project B", thumbnail: b),
            Project(title: "Project C", thumbnail: c)
        ]
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        return cv
    }()

    private let addButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("+", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 32, weight: .bold)
        btn.tintColor = .white
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        btn.layer.cornerRadius = 28
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 8
        return btn
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        title = "My Projects"
        view.backgroundColor = UIColor.black.withAlphaComponent(0.95)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProjectCell.self,
                                forCellWithReuseIdentifier: ProjectCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])

        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 56),
            addButton.heightAnchor.constraint(equalToConstant: 56),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
    }

    @objc private func didTapAdd() {
        let canvasVC = CanvasViewController()
        canvasVC.modalPresentationStyle = .overCurrentContext
        canvasVC.modalTransitionStyle = .crossDissolve
        present(canvasVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension ProjectsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProjectCell.identifier,
            for: indexPath
        ) as! ProjectCell
        cell.configure(with: projects[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ProjectsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        // Present the gallery page controller starting at the tapped index
        let gallery = GalleryViewController(
            projects: projects,
            initialIndex: indexPath.item
        )
        gallery.modalPresentationStyle = .overCurrentContext
        gallery.modalTransitionStyle = .crossDissolve
        present(gallery, animated: true)
    }
}

// MARK: - ProjectCell

class ProjectCell: UICollectionViewCell {
    static let identifier = "ProjectCell"

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.8)
        contentView.layer.cornerRadius = 16
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 8

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with project: Project) {
        imageView.image = project.thumbnail
        titleLabel.text = project.title
    }
}
