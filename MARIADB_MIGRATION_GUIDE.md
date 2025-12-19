# MariaDB Migration Guide

## ✅ Status: Data Exported Successfully

Data dari SQLite telah berhasil diekspor! Berikut langkah-langkah untuk migrasi ke MariaDB:

## 📁 Generated Files

1. **exported-data.json** - Data lengkap dari SQLite
2. **migration-script.sql** - SQL script untuk MariaDB
3. **schema-mysql.prisma** - Skema Prisma untuk MariaDB

## 🛠️ Migration Steps

### Step 1: Update Database Configuration

Ganti DATABASE_URL di file `.env`:

```bash
# Dari SQLite:
DATABASE_URL=file:/home/z/my-project/db/custom.db

# Ke MariaDB:
DATABASE_URL="mysql://username:password@localhost:3306/database_name"
```

### Step 2: Update Prisma Schema

Ganti nama file schema:

```bash
# Backup schema lama
mv prisma/schema.prisma prisma/schema-sqlite.prisma

# Gunakan schema MySQL
mv prisma/schema-mysql.prisma prisma/schema.prisma
```

### Step 3: Create MariaDB Database

```sql
-- Connect to MariaDB
mysql -u root -p

-- Create database
CREATE DATABASE booking_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create user (optional)
CREATE USER 'booking_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON booking_system.* TO 'booking_user'@'localhost';
FLUSH PRIVILEGES;
```

### Step 4: Push Schema to MariaDB

```bash
# Generate Prisma client
bun run db:generate

# Push schema to MariaDB
bun run db:push
```

### Step 5: Import Data

```bash
# Execute migration script
mysql -u username -p database_name < migration-script.sql
```

## 📊 Exported Data Summary

- **Users**: 2 records
- **Services**: 8 records  
- **Bookings**: 1 record
- **Payments**: 1 record
- **Invoices**: 2 records

## 🔧 Configuration Files

### .env example for MariaDB:
```env
DATABASE_URL="mysql://booking_user:password@localhost:3306/booking_system"
```

### Alternative .env formats:
```env
# Format 1
DATABASE_URL="mysql://user:password@host:port/database"

# Format 2  
DATABASE_URL="mysql://user:password@host:port/database?schema=public"

# Format 3 (with SSL)
DATABASE_URL="mysql://user:password@host:port/database?sslmode=require"
```

## 🚀 Quick Start Commands

```bash
# 1. Update .env file
nano .env

# 2. Update schema
mv prisma/schema.prisma prisma/schema-sqlite.prisma
mv prisma/schema-mysql.prisma prisma/schema.prisma

# 3. Create database (in MariaDB)
mysql -u root -p -e "CREATE DATABASE booking_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# 4. Push schema
bun run db:push

# 5. Import data
mysql -u username -p booking_system < migration-script.sql

# 6. Test application
bun run dev
```

## 🔍 Verification Commands

```sql
-- Check data in MariaDB
USE booking_system;

-- Count records
SELECT 'Users' as table_name, COUNT(*) as count FROM User
UNION ALL
SELECT 'Services', COUNT(*) FROM Service
UNION ALL  
SELECT 'Bookings', COUNT(*) FROM Booking
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payment
UNION ALL
SELECT 'Invoices', COUNT(*) FROM Invoice;

-- Check users
SELECT id, username, email, role FROM User;

-- Check services
SELECT id, name, price FROM Service;
```

## 🛡️ Security Notes

1. **Password Security**: Gunakan password yang kuat untuk database user
2. **Environment Variables**: Jangan commit .env file ke version control
3. **Database Permissions**: Berikan permission yang tepat untuk user aplikasi
4. **SSL**: Gunakan SSL untuk koneksi production

## 🔄 Rollback Plan

Jika perlu kembali ke SQLite:

```bash
# Restore SQLite schema
mv prisma/schema.prisma prisma/schema-mysql.prisma
mv prisma/schema-sqlite.prisma prisma/schema.prisma

# Restore .env
echo "DATABASE_URL=file:/home/z/my-project/db/custom.db" > .env

# Regenerate client
bun run db:generate
```

## 📞 Troubleshooting

### Common Issues:

1. **Connection Error**: Pastikan MariaDB server berjalan
2. **Permission Error**: Pastikan user memiliki permission yang cukup
3. **Character Set**: Gunakan utf8mb4 untuk support emoji/unicode
4. **Timezone**: Pastikan timezone MariaDB sesuai dengan aplikasi

### Error Solutions:

```bash
# Check MariaDB status
sudo systemctl status mariadb

# Check connection
mysql -u username -p -h localhost database_name

# Check logs
sudo tail -f /var/log/mysql/error.log
```

## ✅ Migration Complete!

Setelah mengikuti langkah-langkah di atas, aplikasi Anda akan berjalan dengan MariaDB database!