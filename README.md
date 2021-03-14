## Background

 As part of the [Hack The Artic's](https://hackthearctic.com/) hackathon, the team developed an **end-to-end containerized pipeline and developed a dashboard** that tracks snow depth at varying levels of granualirty: the entire Vanager region, among the 3 localities, and among the 6 sections. It is also interactive and supports features such as hovering, zooming and data drill down.

 Link to our submission [here!](https://app.hackjunction.com/projects/hack-the-arctic/view/604d5c7e8e2b090043be2fbe)

---

## Workflow
This is the diagram which illustrates the systems design and workflow
![workflow.png](./images/workflow.png)
## Setup
- `cd` to this directory
- Open a terminal, create a Python virtual environment using:


```
Windows
> python -m virtualenv .venv

Mac/Linux
$ make build

```
then activate it by executing 

```
Windows:
> .venv\Scripts\activate.bat
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
> python app\etl.py

Mac/Linux
$ make run
```


