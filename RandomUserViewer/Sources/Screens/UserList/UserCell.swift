import UIKit
import RxSwift

final class UserCell: TableViewCell {

    // MARK: Properties

    private(set) var disposeBag = DisposeBag()

    private(set) lazy var userImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24

        return imageView
    }()

    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)

        return label
    }()

    private(set) lazy var emailLabel: UILabel = {
        let label = UILabel(frame: .zero)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)

        return label
    }()

    private(set) lazy var favouriteImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)

        imageView.image = UIImage(named: "favourite_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true

        return imageView
    }()


    // MARK: Overrides

    override func setupViewHierarchy() {
        super.setupViewHierarchy()

        [userImageView, nameLabel, emailLabel, favouriteImageView].forEach(contentView.addSubview)
    }

    override func setupLayoutConstraints() {
        super.setupLayoutConstraints()

        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 96),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor),
            userImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),

            nameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),

            favouriteImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            favouriteImageView.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor),
            favouriteImageView.widthAnchor.constraint(equalToConstant: 36),
            favouriteImageView.heightAnchor.constraint(equalTo: favouriteImageView.widthAnchor),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }
}
