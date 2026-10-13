#!/bin/sh

set -eu

INT_FILE="card.csv"
INPUT="$1"
SKIP_ROWS="${2-0}"

duckdb -c "INSTALL excel;
	LOAD excel;
	COPY (SELECT * FROM read_xlsx('$INPUT'))
	TO '$INT_FILE' (HEADER, DELIMITER ',');
	COPY (SELECT data_operazione AS date, importo AS amount, descrizione AS description
		FROM read_csv('$INT_FILE', normalize_names=true, skip=$SKIP_ROWS)
		WHERE stato_operazione = 'contabilizzato' AND circuito = 'MASTERCARD'
		ORDER BY date ASC)
	TO '/dev/stdout'
	WITH (FORMAT CSV, HEADER);"

rm --force "$INT_FILE"
