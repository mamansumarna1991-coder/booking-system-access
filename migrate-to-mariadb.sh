#!/bin/bash

# MariaDB Migration Script
# Usage: ./migrate-to-mariadb.sh [mysql_user] [mysql_password] [mysql_host] [database_name]

set -e

# Default values
MYSQL_USER=${1:-"root"}
MYSQL_PASSWORD=${2:-""}
MYSQL_HOST=${3:-"localhost"}
DATABASE_NAME=${4:-"booking_system"}

echo "🚀 Starting MariaDB Migration..."
echo "================================"

# Check if MariaDB is running
if ! command -v mysql &> /dev/null; then
    echo "❌ MySQL/MariaDB client not found. Please install MySQL client."
    exit 1
fi

# Test connection
echo "🔍 Testing MariaDB connection..."
if ! mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -h"$MYSQL_HOST" -e "SELECT 1;" &> /dev/null; then
    echo "❌ Cannot connect to MariaDB. Please check credentials."
    exit 1
fi
echo "✅ Connection successful!"

# Create database
echo "📦 Creating database..."
mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -h"$MYSQL_HOST" -e "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
echo "✅ Database '$DATABASE_NAME' created!"

# Update .env file
echo "📝 Updating .env file..."
DATABASE_URL="mysql://$MYSQL_USER:$MYSQL_PASSWORD@$MYSQL_HOST:3306/$DATABASE_NAME"
echo "DATABASE_URL=\"$DATABASE_URL\"" > .env
echo "✅ .env file updated!"

# Backup current schema
echo "💾 Backing up current schema..."
if [ -f "prisma/schema.prisma" ]; then
    cp prisma/schema.prisma prisma/schema-sqlite-backup.prisma
    echo "✅ Schema backed up!"
fi

# Use MySQL schema
echo "🔄 Switching to MySQL schema..."
if [ -f "prisma/schema-mysql.prisma" ]; then
    mv prisma/schema-mysql.prisma prisma/schema.prisma
    echo "✅ Using MySQL schema!"
else
    echo "❌ MySQL schema file not found!"
    exit 1
fi

# Generate Prisma client
echo "🔧 Generating Prisma client..."
bun run db:generate
echo "✅ Prisma client generated!"

# Push schema to MariaDB
echo "📤 Pushing schema to MariaDB..."
bun run db:push
echo "✅ Schema pushed to MariaDB!"

# Import data
if [ -f "migration-script.sql" ]; then
    echo "📥 Importing data to MariaDB..."
    mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -h"$MYSQL_HOST" "$DATABASE_NAME" < migration-script.sql
    echo "✅ Data imported successfully!"
else
    echo "⚠️  Migration script not found. Skipping data import."
fi

# Verify data
echo "🔍 Verifying imported data..."
mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -h"$MYSQL_HOST" "$DATABASE_NAME" -e "
SELECT 'Users' as table_name, COUNT(*) as count FROM User
UNION ALL
SELECT 'Services', COUNT(*) FROM Service
UNION ALL  
SELECT 'Bookings', COUNT(*) FROM Booking
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payment
UNION ALL
SELECT 'Invoices', COUNT(*) FROM Invoice;
"

echo ""
echo "🎉 Migration completed successfully!"
echo "================================"
echo "📋 Summary:"
echo "   - Database: $DATABASE_NAME"
echo "   - Host: $MYSQL_HOST"
echo "   - User: $MYSQL_USER"
echo ""
echo "🚀 Next steps:"
echo "   1. Test application: bun run dev"
echo "   2. Verify all features work correctly"
echo "   3. Update production configuration"
echo ""
echo "📁 Important files:"
echo "   - .env (updated with MariaDB connection)"
echo "   - prisma/schema.prisma (MySQL schema)"
echo "   - migration-script.sql (SQL backup)"
echo "   - exported-data.json (JSON backup)"