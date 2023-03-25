update:
	bash update.sh
	git add .
	git commit -m "Update"
	git pull --rebase
	git push
