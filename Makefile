today   = $(shell date "+%Y%m%d")
product_name = PSGhq

# patch
.PHONY : patch
patch : clean diff-patch patch-copy2win

.PHONY : diff-patch
diff-patch :
	git diff origin/master > $(product_name).$(today).patch

.PHONY : patch-branch
patch-branch :
	git switch -c patch-$(today)

.PHONY : switch-master
switch-master :
	git switch master

.PHONY : delete-branch
delete-branch : switch-master
	git branch --list "patch*" | xargs -n 1 git branch -D

.PHONY : patch-copy2win
patch-copy2win :
	cp ./*.patch $$WIN_HOME/Downloads/

# development
.PHONY : test
test : pwsh_test textlint typo_check

.PHONY : pwsh_test
pwsh_test :
	@echo "Run PowerShell ScriptAnalyzer"
	@pwsh -Command "& {Invoke-ScriptAnalyzer ./Set-GhqLocation.ps1}"

.PHONY : textlint
textlint :
	@echo "Run textlint"
	@-pnpm run lint

.PHONY : typo_check
typo_check :
	@echo "Run typo-cli"
	@typos ./

.PHONY : copy-to-win
copy-to-win : release
	cp ./PSGhq.zip $$WIN_HOME/Downloads/PSGhq.zip

.PHONY : release
release :
	zip -r PSGhq.zip \
	README.md \
	Set-GhqLocation.ps1

.PHONY : clean
clean :
	rm -f ./*.zip
	rm -f ./*.patch
