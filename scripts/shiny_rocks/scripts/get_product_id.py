import pandas as pd
from kestra import Kestra

data = pd.read_csv("data.csv")
product_id = [int(x) for x in list(data.product_id.unique())]
print(product_id)
Kestra.outputs({"product_id": product_id})