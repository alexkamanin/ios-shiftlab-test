import SnapKit
import UIKit

final class UIContestTableViewCell: UITableViewCell {

    private final let twoLines = UITwoLines()
    private final var beautyDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm"
        return dateFormatter
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator

        self.setupSubviews()
        self.setupConstraints()
    }

    private func setupSubviews() {
        self.contentView.addSubview(self.twoLines)
    }

    private func setupConstraints() {
        self.twoLines.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }

    func setData(_ contest: Contest) {
        var startTime: String {
            if let time = contest.startTime {
                return beautyDateFormatter.string(from: time)
            } else {
                return l10n("CONTEST_TIME_NOT_SPECIFIED")
            }
        }
        var endTime: String {
            if let time = contest.endTime {
                return beautyDateFormatter.string(from: time)
            } else {
                return l10n("CONTEST_TIME_NOT_SPECIFIED")
            }
        }

        self.twoLines.topText = contest.name
        self.twoLines.bottomText = "\(startTime) - \(endTime)"
    }
}
