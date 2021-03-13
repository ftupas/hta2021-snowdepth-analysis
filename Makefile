
build: requirements.txt
	@echo "--CREATING--  virtual enviroment .venv"
	python3 -m venv .venv
	@echo "--INSTALLING-- from requirements.txt"
	@. .venv/bin/activate
	@python3 -m pip install --upgrade pip -q
	@python3 -m pip install -qr requirements.txt

run:
	@echo "--RUNNING--  scraper.py"
	@. .venv/bin/activate
	python3 app/scraper.py && python3 app/etl.py

clean:
	@echo "--DELETING-- venv and pycache"
	@rm -r .venv; find . | grep -E "(.cache|debug.log)" | xargs rm -rf
	@find . | grep -E "(__pycache__|.pytest_cache)" | xargs rm -rf
