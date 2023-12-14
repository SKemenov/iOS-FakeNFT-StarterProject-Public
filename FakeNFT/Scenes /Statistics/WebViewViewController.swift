//
//  WebViewViewController.swift
//  FakeNFT
//
//  Created by Sergey Kemenov on 12.12.2023.
//

import UIKit
import WebKit

// MARK: - Class

final class WebViewViewController: UIViewController {
    // MARK: - Private properties

    private let customNavView: UIView = {
        let object = UIView()
        return object
    }()
    private let backButton: UIButton = {
        let object = UIButton()
        object.setImage(Statistics.SfSymbols.backward, for: .normal)
        return object
    }()
    private let webView = WKWebView()
    private var url: URL?

    // MARK: - Inits

    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life circle

   override func viewDidLoad() {
        super.viewDidLoad()

       configureUI()
       configureElementValues()
       if let url {
           webView.load(URLRequest(url: url))
       }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Private methods

private extension WebViewViewController {
    @objc func backButtonCLicked() {
        navigationController?.popViewController(animated: true)
    }

    func configureElementValues() {
        backButton.addTarget(self, action: #selector(backButtonCLicked), for: .touchUpInside)
    }

    // MARK: - Private methods to configure UI
    func configureUI() {
        view.backgroundColor = .systemBackground

        [customNavView, backButton, webView].forEach { object in
            object.translatesAutoresizingMaskIntoConstraints = false
            object.tintColor = .ypBlackDay
            view.addSubview(object)
        }

        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            customNavView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: .spacing16),
            customNavView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -.spacing16),
            customNavView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            customNavView.heightAnchor.constraint(equalToConstant: .navigationBarHeight),

            backButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: .spacing16),
            backButton.centerYAnchor.constraint(equalTo: customNavView.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: .backButtonSize),
            backButton.heightAnchor.constraint(equalToConstant: .backButtonSize),

            webView.topAnchor.constraint(equalTo: customNavView.bottomAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}