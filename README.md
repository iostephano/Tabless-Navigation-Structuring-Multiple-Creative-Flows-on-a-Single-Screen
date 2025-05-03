# Tabless Navigation Structuring Multiple Creative Flows on a Single Screen

This project explores how to structure creative workflows without using a TabBar, delivering a fluid, uninterrupted navigation experience. Inspired by tools like Procreate, it showcases how multiple content flows can coexist on a single screen through custom modal transitions and native UIKit components.

The current implementation (Model 4) includes a scrollable preview gallery using `UIPageViewController`, where users can navigate between projects and return to the canvas without breaking context.

---

## Project Structure

TablessNavigation/
├── AppDelegate.swift
├── SceneDelegate.swift
├── ProjectsViewController.swift // Main project grid UI
├── ProjectCell.swift // Custom UICollectionViewCell
├── CanvasViewController.swift // Blank drawing canvas (placeholder)
├── GalleryViewController.swift // Horizontal scrollable gallery
└── Assets.xcassets/ // Image thumbnails for each project

---

## How It Works

1. `ProjectsViewController` displays a grid of projects using `UICollectionView`.
2. Tapping a project opens a full-screen modal gallery (`GalleryViewController`).
3. The modal uses `UIPageViewController` to enable horizontal swiping between projects.
4. A blur background (`UIVisualEffectView`) and custom fade/zoom animations enhance immersion.
5. Users can tap anywhere on the preview to dismiss and return to the grid view.
6. The “+” floating button opens a placeholder canvas (`CanvasViewController`) to simulate new project creation.

All transitions are modal-based, maintaining the feeling of a single continuous screen.

---

## Ideas for Extension

- Add a **layered editing panel** within the canvas modal.
- Enable **drawing or annotation** directly on the canvas using `CAShapeLayer`.
- Integrate **drag-and-drop thumbnails** for reordering.
- Implement **state persistence** using Core Data or FileManager.
- Add **gesture-based transitions** between canvas and gallery.
- Expand the modal system to support **color pickers**, **toolbars**, or **asset browsers**.

---

## Technologies Used

- **Language:** Swift
- **UI Framework:** UIKit (no SwiftUI)
- **Navigation:** UIPageViewController, UIViewController transitions
- **UI Components:** UICollectionView, UIButton, UIImageView
- **Effects:** UIVisualEffectView (dark blur), Alpha layers
- **Drawing Support:** CAShapeLayer, UIPanGestureRecognizer
- **Dark Mode:** Fully supported via adaptive colors

---
## License

MIT License. Feel free to use and modify.
