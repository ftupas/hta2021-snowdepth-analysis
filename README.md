## Setup
- `cd` to this directory
- Open a terminal, create a Python virtual environment using:


```
Windows
> python -m venv venv

Mac/Linux
$ make build

```
then activate it by executing 

```
Windows:
> venv\Scripts\activate.bat
```
(For Windows) Install dependencies using:
```
> python -m pip install -r requirements.txt
```

## Get [COAT](https://data.coat.no/) data
Download snowdepth zip file and extract to `data` folder with this command
```
Windows
> python app\scraper.py

Mac/Linux
$ make run
```