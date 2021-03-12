#!/bin/bash
dbt init snowdepth
cd snowdepth
dbt seed
dbt run
dbt docs generate
dbt docs serve