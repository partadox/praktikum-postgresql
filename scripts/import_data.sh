#!/bin/bash
# Script untuk import data CSV ke PostgreSQL

# Variabel koneksi
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="ecommerce"
DB_USER="praktikan"
DB_PASS="p4ssw0rd"

# Direktori data
DATA_DIR="../data"

# Fungsi import CSV
import_csv() {
    local table=$1
    local file=$2
    echo "Importing $file to $table table..."
    
    # Gunakan COPY command untuk import data lebih cepat
    PGPASSWORD=$DB_PASS psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "\COPY $table FROM '$file' CSV HEADER;"
    
    if [ $? -eq 0 ]; then
        echo "Successfully imported $file"
    else
        echo "Failed to import $file"
        exit 1
    fi
}

# Import semua file CSV
echo "Starting data import..."

import_csv "products" "$DATA_DIR/products.csv"
import_csv "customers" "$DATA_DIR/customers.csv"
import_csv "orders" "$DATA_DIR/orders.csv"
import_csv "order_items" "$DATA_DIR/order_items.csv"
import_csv "bank_accounts" "$DATA_DIR/bank_accounts.csv"

echo "Data import completed successfully!"

# Analyze database untuk update statistik
echo "Analyzing database..."
PGPASSWORD=$DB_PASS psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "ANALYZE;"

echo "Database is ready for practical sessions!"
