import argparse
import pandas as pd
from prophet import Prophet

parser = argparse.ArgumentParser(description='Prophet forecasting script')
parser.add_argument('--product_id', type=int, help='Product ID for forecasting')
args = parser.parse_args()
selected_product_id = args.product_id


data = (
    pd.read_csv("data.csv")
    .query(f"product_id == {selected_product_id}")
    .rename(columns={"nb_order": "y", "order_date": "ds"})
    .sort_values(by="ds")
)

m = Prophet()
m.fit(data)

future = m.make_future_dataframe(periods=5)
forecast = m.predict(future)

forecast.to_csv("forecast.csv", index=False)
data.to_csv("historic.csv", index=False)
print(data)
print(forecast)