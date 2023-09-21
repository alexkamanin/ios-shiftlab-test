PROJECT_NAME = ShiftlabGenerated
PROJECT_EXTENSION = .xcodeproj

generate: prepare
	./BuildTools/Binaries/XcodeGen/bin/xcodegen generate --spec ./project.yml

prepare:
	chmod u+x ./BuildTools/Scripts/SwiftLint/swiftlint.sh

open:
	open $(PROJECT_NAME)$(PROJECT_EXTENSION)

distclean: clean
	rm -rf ~/Library/Developer/Xcode/DerivedData/$(PROJECT_NAME)-*

clean:
	rm -rfv $(PROJECT_NAME)$(PROJECT_EXTENSION)
	find . -path '*/Generated/.*' -prune -o -path '*/Generated/*' -print -delete

lintfix:
	./BuildTools/Binaries/SwiftLint/bin/swiftlint --config ./BuildTools/Scripts/SwiftLint/swiftlint.yml --fix