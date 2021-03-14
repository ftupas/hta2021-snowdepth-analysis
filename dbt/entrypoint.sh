#!/bin/bash
dbt init snowdepth &&
rm -rf /dbt/snowdepth/models/example &&
cp -r /snowdepth/snowdepth/. /dbt/snowdepth &&
cp -r /data /dbt/snowdepth/data &&
cp /snowdepth/snowdepth/profiles.yml /root/.dbt/profiles.yml &&
cp /snowdepth/snowdepth/dbt_project.yml \ 
   /dbt/snowdepth/dbt_project.yml &&
cd /dbt/snowdepth &&
dbt debug &&
dbt deps &&
dbt seed &&
dbt run &&
dbt test &&
dbt docs generate &&
dbt docs serve