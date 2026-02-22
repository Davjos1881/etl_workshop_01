import pandas as pd
from tabulate import tabulate
from log import log_progress
from extract import extract_candidates
from transform import transform_data
from load import save_dimensions_to_csv, load_to_dw

log_file = r'C:\Users\btigr\Documents\UAO\5\ETL\ETL_2026_1\workshop_1\etl_workshop_01\logs\log_file.txt'
target_file = r'C:\Users\btigr\Documents\UAO\5\ETL\ETL_2026_1\workshop_1\etl_workshop_01\transformed'
data_path = r'C:\Users\btigr\Documents\UAO\5\ETL\ETL_2026_1\workshop_1\etl_workshop_01\raw\candidates.csv'

def main():
    # ETL process
    log_progress('Starting ETL process', log_file)

    # Extract
    log_progress('Extract phase started', log_file)

    df_candidates = extract_candidates(data_path)
    print(tabulate(df_candidates.head(), headers='keys', tablefmt='psql'))

    log_progress("Extract phase complete", log_file)

    # Transform
    log_progress('Transform phase started', log_file)

    df_candidates_transform = transform_data(df_candidates)

    print("\nDIM_DATE")
    print(tabulate(df_candidates_transform["dim_date"].head(), headers='keys', tablefmt='psql'))

    print("\nDIM_COUNTRY")
    print(tabulate(df_candidates_transform["dim_country"].head(), headers='keys', tablefmt='psql'))

    print("\nDIM_SENIORITY")
    print(tabulate(df_candidates_transform["dim_seniority"].head(), headers='keys', tablefmt='psql'))

    print("\nDIM_TECHNOLOGY")
    print(tabulate(df_candidates_transform["dim_technology"].head(), headers='keys', tablefmt='psql'))

    print("\nDIM_CANDIDATE")
    print(tabulate(df_candidates_transform["dim_candidate"].head(), headers='keys', tablefmt='psql'))

    print("\nFACT_APPLICATION")
    print(tabulate(df_candidates_transform["fact_application"].head(), headers='keys', tablefmt='psql'))

    log_progress('Transform phase complete', log_file)

    # Load
    log_progress('Load phase started', log_file)

    save_dimensions_to_csv(
        target_file,
        dim_date=df_candidates_transform["dim_date"],
        dim_country=df_candidates_transform["dim_country"],
        dim_seniority=df_candidates_transform["dim_seniority"],
        dim_technology=df_candidates_transform["dim_technology"],
        dim_candidate=df_candidates_transform["dim_candidate"],
        fact_application=df_candidates_transform["fact_application"]
    )

    load_to_dw(df_candidates_transform)
    log_progress('Load phase complete', log_file)


    # ETL process
    log_progress('ETL process finished successfully', log_file)


if __name__ == "__main__":
    main()