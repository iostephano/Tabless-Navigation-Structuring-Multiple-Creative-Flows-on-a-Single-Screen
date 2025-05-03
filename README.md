# Tabless Navigation Structuring Multiple Creative Flows on a Single Screen

This project explores how to structure creative workflows without using a TabBar, delivering a fluid, uninterrupted navigation experience. Inspired by tools like Procreate, it showcases how multiple content flows can coexist on a single screen through custom modal transitions and native UIKit components.

The current implementation includes a scrollable preview gallery using `UIPageViewController`, where users can navigate between projects and return to the canvas without breaking context.

---

## Project Structure

TablessNavigation/
├── AppDelegate.swift            // App launch and scene lifecycle setup
├── SceneDelegate.swift          // Window and root view controller configuration
├── ProjectsViewController.swift // Main grid view with project thumbnails and add button
├── ProjectCell.swift            // Custom UICollectionViewCell for displaying project previews
├── CanvasViewController.swift   // Placeholder for drawing canvas with pan-based stroke preview
├── GalleryViewController.swift  // Modal gallery with horizontal scroll using UIPageViewController
├── Assets.xcassets              // Image assets: thumbA, thumbB, thumbC
└── Info.plist                   // App configuration and launch settings

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
- **UI Framework:** UIKit
- **Navigation:** UIPageViewController, UIViewController transitions
- **UI Components:** UICollectionView, UIButton, UIImageView
- **Effects:** UIVisualEffectView (dark blur), Alpha layers
- **Drawing Support:** CAShapeLayer, UIPanGestureRecognizer
- **Dark Mode:** Fully supported via adaptive colors

---
## License

MIT License. Feel free to use and modify.
