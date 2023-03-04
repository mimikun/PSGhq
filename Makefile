today = $(shell date "+%Y%m%d")
product_name = PSGhq

.PHONY : install
install :
	echo "TODO"

.PHONY : patch
patch : clean diff-patch patch-copy2win

.PHONY : diff-patch
diff-patch :
	git diff origin/master > $(product_name).$(today).patch

.PHONY : patch-branch
patch-branch :
	git switch -c patch-$(today)

.PHONY : clean
clean :
	rm -f *.patch

.PHONY : patch-copy2win
patch-copy2win :
	cp ./*.patch $$WIN_HOME/Downloads/
