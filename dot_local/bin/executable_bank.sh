#!/bin/sh

INT_FILE="bank.csv"
INPUT="$1"
SKIP_ROWS="${2-0}"

duckdb -c "INSTALL spatial;
	LOAD spatial;
	COPY (FROM st_read('$INPUT')) TO '$INT_FILE' (HEADER, DELIMITER ',');
	COPY (SELECT data_operazione AS date, IFNULL(entrate, 0) + IFNULL(uscite, 0) AS amount, descrizione_completa as description
		FROM read_csv('$INT_FILE', normalize_names=true, skip=$SKIP_ROWS) WHERE Stato = 'Contabilizzato' ORDER BY date ASC)
		TO '/dev/stdout' WITH (FORMAT CSV, HEADER);"

rm --force "$INT_FILE"
