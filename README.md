# Praktikum Basis Data: ACID dan High Concurrency dengan PostgreSQL

Praktikum ini bertujuan untuk memahami konsep ACID (Atomicity, Consistency, Isolation, Durability) dan High Concurrency pada database PostgreSQL melalui empat skenario praktis.

## Deskripsi Praktikum

Praktikum ini terdiri dari empat modul yang saling berkaitan:

1. **Implementasi Indexing**: Mempelajari cara mengoptimalkan performa query dengan index dan mengukur dampaknya pada konkurensi tinggi.

2. **Implementasi Transaction**: Mempelajari konsep ACID, tingkat isolasi transaksi, dan menangani konkurensi tinggi dengan benar.

3. **Implementasi Partitioning**: Mempelajari cara membagi tabel besar menjadi bagian yang lebih kecil dan dampaknya terhadap performa.

4. **Backup dan Recovery**: Mempelajari strategi backup dan recovery untuk menjamin ketersediaan dan integritas data.

## Struktur Repositori

```
postgres-praktikum/
├── docker-compose.yml            # Konfigurasi Docker Compose
├── init/                         # Script inisialisasi database
│   ├── 01-schema.sql             # Struktur tabel
│   └── 02-functions.sql          # Function dan procedure
├── data/                         # Data CSV untuk diimpor
│   ├── products.csv              # Data produk
│   ├── customers.csv             # Data pelanggan
│   ├── orders.csv                # Data pesanan
│   └── order_items.csv           # Data item pesanan
├── scripts/                      # Script utilitas
│   ├── generate_data.py          # Script Python untuk generate data
│   ├── import_data.sh            # Script untuk import data CSV
│   ├── benchmark.sh              # Script untuk benchmark performa
│   └── README.md                 # Dokumentasi script
└── praktikum/                    # Modul praktikum
    ├── praktikum1_indexing/      # Modul praktikum indexing
    ├── praktikum2_transaction/   # Modul praktikum transaction
    ├── praktikum3_partitioning/  # Modul praktikum partitioning
    └── praktikum4_backup/        # Modul praktikum backup & recovery
```

## Persiapan Environment

### Menggunakan Docker

1. Install Docker dan Docker Compose di komputer Anda
2. Clone repositori ini
3. Jalankan container dengan perintah:

```bash
docker-compose up -d
```

4. Generate data dummy:

```bash
cd scripts
pip install faker
python generate_data.py
```

5. Import data ke PostgreSQL:

```bash
cd scripts
bash import_data.sh
```

6. Akses pgAdmin di browser:
   - URL: http://localhost:5050
   - Email: admin@example.com
   - Password: p4ssw0rd

7. Tambahkan server di pgAdmin:
   - Name: PostgreSQL Praktikum
   - Host: postgres
   - Port: 5432
   - Username: praktikan
   - Password: p4ssw0rd

## Cara Menggunakan Modul Praktikum

Setiap modul praktikum memiliki:
- README.md dengan penjelasan konsep dan langkah-langkah
- File SQL dengan query untuk latihan
- Tugas dan pertanyaan diskusi

Ikuti langkah-langkah dalam README.md setiap modul praktikum secara berurutan.

## Petunjuk Pengerjaan

1. Praktikum dikerjakan dalam kelompok (4 orang per kelompok)
2. Setiap kelompok mengerjakan semua modul praktikum
3. Asisten praktikum akan mengawasi dan membantu selama praktikum
4. Setiap kelompok membuat laporan akhir berisi:
   - Jawaban tugas dari setiap modul
   - Analisis dan kesimpulan

## Tentang Data

Dataset yang digunakan adalah data e-commerce dummy yang berisi:
- 10.000 produk
- 5.000 pelanggan
- 20.000 pesanan
- 50.000 item pesanan

Data ini memungkinkan pengujian performa dan konkurensi yang realistis.

## Referensi

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [PostgreSQL Concurrency](https://www.postgresql.org/docs/current/mvcc.html)
- [PostgreSQL Indexing](https://www.postgresql.org/docs/current/indexes.html)
- [PostgreSQL Partitioning](https://www.postgresql.org/docs/current/ddl-partitioning.html)
- [PostgreSQL Backup and Restore](https://www.postgresql.org/docs/current/backup.html)

## Modul Author
Arta Kusuma Hernanda

## Asisten praktikum
<details>
  <summary>2025/2024 Genap</summary>

5024211001 - Reza Ali Nirwansyah
5024211004 - Kenanya Keandra Adriel Prasetyo
5024211005 - Sulthan Daffa Arif Mahmudi
5024211013 - Annafi Nur Jayani
5024221001 - Rezky Dwisantika Pujiastuti
5024221011 - Farrell Rafee Sudjatmiko
5024221023 - Hendrich Ardthian Breshman Panjaitan
5024221052 - Pranaditya Tri Jyotista Vavitram Putra Sudana
5024221058 - Rigel Ramadhani Waloni
5024221064 - Ahmad Wildan Syahputra
5024221066 - Imanuel Daulat Satrio Utomo Siahaan
5024221067 - Adhitya Raufarhan Sukmana

</details>