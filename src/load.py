from sqlalchemy import create_engine, text
import pandas as pd
import os

# Save to csv
def save_dimensions_to_csv(target_file, **dataframes):

    for name, df in dataframes.items():
        file_path = os.path.join(target_file, f"{name}.csv")
        df.to_csv(file_path, index=False)
        print(f"Saved: {file_path}")

# Load to de DW
def load_to_dw(dataframes):

    dim_candidate = dataframes["dim_candidate"]
    dim_country = dataframes["dim_country"]
    dim_technology = dataframes["dim_technology"]
    dim_seniority = dataframes["dim_seniority"]
    dim_date = dataframes["dim_date"]
    fact_application = dataframes["fact_application"]

    engine = create_engine(
        "mysql+pymysql://root:@localhost:3306/workshop1"
    )


    dim_date.to_sql("dim_date", engine, if_exists="append", index=False)
    dim_candidate.to_sql("dim_candidate", engine, if_exists="append", index=False)
    dim_country.to_sql("dim_country", engine, if_exists="append", index=False)
    dim_technology.to_sql("dim_technology", engine, if_exists="append", index=False)
    dim_seniority.to_sql("dim_seniority", engine, if_exists="append", index=False)

    fact_application.to_sql(
        "fact_application",
        engine,
        if_exists="append",
        index=False
    )

    print("Carga completada exitosamente")