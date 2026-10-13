#!/bin/sh

duckdb -c "COPY (SELECT CAST(started_date AS DATE) AS date, amount - fee AS amount, CONCAT(_type, ' ', description) AS description FROM read_csv('/dev/stdin', normalize_names=true) WHERE State = 'COMPLETED' ORDER BY date ASC) TO '/dev/stdout' WITH (FORMAT CSV, HEADER);"
