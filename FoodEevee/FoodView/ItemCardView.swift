//
//  ItemCardView.swift
//  ImageJsonThing
//
//  Created by Yu-Sung Loyi Hsu on 2022/3/6.
//

import UIKit

class ItemCardView: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()

    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .gray

        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Name"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "$XX"
        label.font = .systemFont(ofSize: 14)
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    func setupView() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        addSubview(stackView)
    }

    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.left.right.height.equalTo(self)
                .inset(UIEdgeInsets(top: 0, left: 0, bottom: 55, right: 0))
        }
        stackView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(self)
        }
    }
}
