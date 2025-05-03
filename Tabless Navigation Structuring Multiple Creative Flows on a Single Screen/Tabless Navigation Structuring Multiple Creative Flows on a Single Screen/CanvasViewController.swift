//
//  CanvasViewController.swift
//  Tabless Navigation Structuring Multiple Creative Flows on a Single Screen
//
//  Created by Stephano Portella on 03/05/25.
//
import UIKit

class CanvasViewController: UIViewController {

    private let shapeLayer = CAShapeLayer()
    private let path = UIBezierPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark

        // Semi-opaque black background in Dark Mode
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)

        setupDrawing()
    }

    private func setupDrawing() {
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.fillColor = nil
        view.layer.addSublayer(shapeLayer)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(pan)
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: view)
        if gesture.state == .began {
            path.move(to: point)
        } else if gesture.state == .changed {
            path.addLine(to: point)
            shapeLayer.path = path.cgPath
        }
    }
}
