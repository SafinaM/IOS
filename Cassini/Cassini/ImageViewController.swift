//
//  ImageViewController.swift
//  Cassini
//
//  Created by LinuxPlus on 12/16/17.
//  Copyright © 2017 MarinaS. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController
{
	var imageURL: URL? {
		didSet {
			image = nil
			if view.window != nil {
				fetchIMage()
			}
		}
	}
	
	@IBOutlet var spinner: UIActivityIndicatorView!
	private func fetchIMage() {
		if let url = imageURL {
			spinner.startAnimating()
			DispatchQueue.global(qos: .userInitiated).async { [weak self] in
				let urlContents = try? Data(contentsOf: url)
				if let imageData = urlContents, url == self?.imageURL {
					self?.image = UIImage(data: imageData)
				}
			}
		}
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if image == nil {
			fetchIMage()
		}
	}
	
	
	@IBOutlet var scrollView: UIScrollView! {
		didSet {
			scrollView.delegate = self
			scrollView.minimumZoomScale = 0.03
			scrollView.maximumZoomScale = 2.0
			scrollView.contentSize = imageView.frame.size
			scrollView.addSubview(imageView)
		}
	}
	fileprivate var imageView = UIImageView()
	
	private var image: UIImage? {
		get {
			return imageView.image
		}
		set {
			imageView.image = newValue
			imageView.sizeToFit()
			scrollView?.contentSize = imageView.frame.size
			spinner?.stopAnimating()
		}
	}
	
}

extension ImageViewController : UIScrollViewDelegate
{
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
}
