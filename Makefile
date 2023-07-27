update:
	/opt/homebrew/bin/bash update.sh
	git add .
	git commit -m "Update"
	git pull --rebase
