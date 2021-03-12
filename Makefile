
build: requirements.txt
	@echo "--CREATING--  virtual enviroment .venv"
	python -m venv .venv
	@echo "--INSTALLING-- from requirements.txt"
	@. .venv/bin/activate
	@pip install -qr requirements.txt

run:
	@echo "--RUNNING--  scraper.py"
	@. .venv/bin/activate
	python app/scraper.py

clean:
	@echo "--DELETING-- venv and pycache"
	@rm -r .venv; find . | grep -E "(.cache|debug.log|.csv)" | xargs rm -rf
	@find . | grep -E "(__pycache__|.pytest_cache)" | xargs rm -rf