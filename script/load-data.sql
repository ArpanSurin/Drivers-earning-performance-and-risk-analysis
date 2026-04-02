copy driver_payouts from'C:/scratch/data-analysis/sql-da/ride-share-analytics/dataset/driver_payouts.csv'
with(Format csv, header true, delimiter ','); -- done

copy drivers from 'C:/scratch/data-analysis/sql-da/ride-share-analytics/dataset/drivers.csv'
with(Format csv, header true, delimiter ','); -- done

copy ratings from'C:/scratch/data-analysis/sql-da/ride-share-analytics/dataset/ratings.csv'
with(Format csv, header true, delimiter ','); -- done

copy riders from'C:/scratch/data-analysis/sql-da/ride-share-analytics/dataset/riders.csv'
with(Format csv, header true, delimiter ','); -- done

copy trips from'C:/scratch/data-analysis/sql-da/ride-share-analytics/dataset/trips.csv'
with(Format csv, header true, delimiter ','); -- done
