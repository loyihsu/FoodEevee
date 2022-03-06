//
//  ViewController.swift
//  FoodEevee
//
//  Created by Yu-Sung Loyi Hsu on 2022/3/6.
//

import UIKit
import SnapKit
import Kingfisher
import Combine
import RxSwift

class FoodViewController: UIViewController {
    let viewModel = FoodViewModel()

    let disposeBag = DisposeBag()

    let scrollView = UIScrollView()

    let stackViewWithLoading: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        return view
    }()

    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        return view
    }()

    let loadingView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.startAnimating()
        return activity
    }()

    var viewList: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBinding()
        setupUI()
        viewModel.fetchData()
    }

    func setupBinding() {
        viewModel.products
            .subscribe(onNext: { receivedValue in
                self.loadingView.isHidden = true
                self.viewList = receivedValue.map {
                    let view = ItemCardView()
                    view.nameLabel.text = $0.name
                    view.priceLabel.text = "$\($0.price)"
                    let url = URL(string: $0.image)!
                    view.imageView.kf.setImage(with: url)
                    return view
                }
                self.updateStackView()
            })
            .disposed(by: disposeBag)
        scrollView.delegate = self
    }

    func setupUI() {
        view.backgroundColor = .white
        title = "FoodEevee"
        navigationController?.navigationBar.prefersLargeTitles = true

        stackViewWithLoading.addArrangedSubview(stackView)
        stackViewWithLoading.addArrangedSubview(loadingView)
        scrollView.addSubview(stackViewWithLoading)
        view.addSubview(scrollView)

        stackViewWithLoading.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
        }

        scrollView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        loadingView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 0, left: 15, bottom:0, right: 15))
        }

        updateStackView()
    }

    private func updateStackView() {
        stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        viewList.forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.subviews.forEach { subview in
            subview.snp.makeConstraints {
                $0.left.right.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
                $0.height.equalTo(250)
            }
        }
    }
}

extension FoodViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottom = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottom >= scrollView.contentSize.height {
            self.loadingView.isHidden = false
            viewModel.fetchData()
        }
    }
}
