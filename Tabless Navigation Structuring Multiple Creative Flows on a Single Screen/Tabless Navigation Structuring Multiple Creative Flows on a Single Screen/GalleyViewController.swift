//
//  GalleyViewController.swift
//  Tabless Navigation Structuring Multiple Creative Flows on a Single Screen
//
//  Created by Stephano Portella on 03/05/25.
//
import UIKit

/// A horizontally scrollable gallery of project previews
class GalleryViewController: UIPageViewController,
                            UIPageViewControllerDataSource,
                            UIPageViewControllerDelegate {

    // MARK: - Properties

    private let projects: [Project]
    private var currentIndex: Int

    private let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemThickMaterialDark)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initialization

    init(projects: [Project], initialIndex: Int) {
        self.projects = projects
        self.currentIndex = initialIndex
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        self.dataSource = self
        self.delegate   = self
        self.overrideUserInterfaceStyle = .dark
        self.modalPresentationStyle = .overCurrentContext
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // insert blur behind the page-view's scroll view
        view.insertSubview(blurEffectView, at: 0)
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        blurEffectView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 1
        }

        // set the initial preview page
        let initialVC = makePreviewController(at: currentIndex)
        setViewControllers([initialVC], direction: .forward, animated: false)
    }

    // MARK: - Helpers

    private func makePreviewController(at index: Int) -> PreviewViewController {
        let preview = PreviewViewController(project: projects[index], pageIndex: index)
        preview.dismissHandler = { [weak self] in
            self?.dismiss(animated: true)
        }
        return preview
    }

    // MARK: - UIPageViewControllerDataSource

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard
            let prev = (viewController as? PreviewViewController)?.pageIndex,
            prev > 0
        else { return nil }
        currentIndex = prev - 1
        return makePreviewController(at: currentIndex)
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard
            let idx = (viewController as? PreviewViewController)?.pageIndex,
            idx < projects.count - 1
        else { return nil }
        currentIndex = idx + 1
        return makePreviewController(at: currentIndex)
    }

    // MARK: - UIPageViewControllerDelegate

    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        // nothing special for now
    }
}


/// A single preview page showing one project's image
private class PreviewViewController: UIViewController {

    let project: Project
    let pageIndex: Int
    var dismissHandler: (() -> Void)?

    private let imageView = UIImageView()
    private let closeButton = UIButton(type: .system)

    init(project: Project, pageIndex: Int) {
        self.project = project
        self.pageIndex = pageIndex
        super.init(nibName: nil, bundle: nil)
        overrideUserInterfaceStyle = .dark
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear

        // configure image view
        imageView.image = project.thumbnail
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // tap image to dismiss
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        imageView.addGestureRecognizer(tap)

        // configure close button
        closeButton.setTitle("Close", for: .normal)
        closeButton.tintColor = .white
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self,
                              action: #selector(dismissSelf),
                              for: .touchUpInside)
        view.addSubview(closeButton)

        // layout constraints
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    @objc private func dismissSelf() {
        dismissHandler?()
    }
}
