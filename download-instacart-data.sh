#!/usr/bin/env bash

curl -L -o initdb/instacart-data.zip \
https://www.kaggle.com/api/v1/datasets/download/psparks/instacart-market-basket-analysis
unzip -o initdb/instacart-data.zip -d initdb/
rm initdb/*.zip
