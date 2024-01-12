from fastapi import FastAPI, Query
from pydantic import BaseModel

app = FastAPI()


@app.get("/is_fraud/")
async def is_fraud(
    id_number: int = Query(..., description="ID Number"),
    name: str = Query(..., description="Name"),
    lastname: str = Query(..., description="Lastname"),
    address: str = Query(..., description="Address"),
):
    input_data = {
        "id_number": id_number,
        "name": name,
        "lastname": lastname,
        "address": address
    }
    print(input_data)
    return {"is_fraud": id_number % 2 == 0}


# curl -X 'GET' 'http://0.0.0.0:8082/is_fraud' -H "Content-Type: application/json" -d '{"id_number": 3, "name": "John", "lastname": "Doe", "address": "1 stree"}'
