const { PrismaClient } = require('@prisma/client')
const fs = require('fs')
const path = require('path')

// SQLite client with correct path
const sqliteClient = new PrismaClient({
  datasources: {
    db: {
      url: 'file:/home/z/my-project/db/custom.db'
    }
  }
})

async function exportData() {
  console.log('📤 Exporting data from SQLite...')
  
  try {
    // Export Users
    const users = await sqliteClient.user.findMany()
    console.log(`✅ Exported ${users.length} users`)
    
    // Export Services
    const services = await sqliteClient.service.findMany()
    console.log(`✅ Exported ${services.length} services`)
    
    // Export Bookings
    const bookings = await sqliteClient.booking.findMany()
    console.log(`✅ Exported ${bookings.length} bookings`)
    
    // Export Payments
    const payments = await sqliteClient.payment.findMany()
    console.log(`✅ Exported ${payments.length} payments`)
    
    // Export Invoices
    const invoices = await sqliteClient.invoice.findMany()
    console.log(`✅ Exported ${invoices.length} invoices`)
    
    const exportData = {
      users,
      services,
      bookings,
      payments,
      invoices
    }
    
    // Save to JSON file
    fs.writeFileSync('./exported-data.json', JSON.stringify(exportData, null, 2))
    console.log('💾 Data exported to exported-data.json')
    
    return exportData
    
  } catch (error) {
    console.error('❌ Export error:', error)
    throw error
  } finally {
    await sqliteClient.$disconnect()
  }
}

async function generateSQL(data) {
  console.log('🔧 Generating SQL script...')
  
  let sql = '-- Booking System Database Migration Script\n'
  sql += '-- Generated from SQLite to MariaDB\n\n'
  
  sql += '-- Disable foreign key checks\n'
  sql += 'SET FOREIGN_KEY_CHECKS = 0;\n\n'
  
  // Insert Users
  if (data.users.length > 0) {
    sql += '-- Insert Users\n'
    data.users.forEach(user => {
      sql += `INSERT INTO User (id, username, email, name, password, role, createdAt, updatedAt) VALUES ('${user.id}', '${user.username}', '${user.email}', '${user.name}', '${user.password}', '${user.role}', '${user.createdAt.toISOString().slice(0, 19).replace('T', ' ')}', '${user.updatedAt.toISOString().slice(0, 19).replace('T', ' ')}');\n`
    })
    sql += '\n'
  }
  
  // Insert Services
  if (data.services.length > 0) {
    sql += '-- Insert Services\n'
    data.services.forEach(service => {
      const price = service.price || 0
      sql += `INSERT INTO Service (id, name, description, price, duration, isActive, createdAt, updatedAt) VALUES ('${service.id}', '${service.name.replace(/'/g, "\\'")}', '${service.description ? service.description.replace(/'/g, "\\'") : ''}', ${price}, ${service.duration || 'NULL'}, ${service.isActive}, '${service.createdAt.toISOString().slice(0, 19).replace('T', ' ')}', '${service.updatedAt.toISOString().slice(0, 19).replace('T', ' ')}');\n`
    })
    sql += '\n'
  }
  
  // Insert Bookings
  if (data.bookings.length > 0) {
    sql += '-- Insert Bookings\n'
    data.bookings.forEach(booking => {
      const price = booking.price || 0
      sql += `INSERT INTO Booking (id, userId, serviceId, serviceName, bookingDate, bookingTime, customerName, customerEmail, customerPhone, address, notes, status, price, createdAt, updatedAt) VALUES ('${booking.id}', '${booking.userId}', '${booking.serviceId}', '${booking.serviceName.replace(/'/g, "\\'")}', '${booking.bookingDate.toISOString().slice(0, 19).replace('T', ' ')}', '${booking.bookingTime}', '${booking.customerName.replace(/'/g, "\\'")}', '${booking.customerEmail}', '${booking.customerPhone}', '${booking.address.replace(/'/g, "\\'")}', '${booking.notes ? booking.notes.replace(/'/g, "\\'") : ''}', '${booking.status}', ${price}, '${booking.createdAt.toISOString().slice(0, 19).replace('T', ' ')}', '${booking.updatedAt.toISOString().slice(0, 19).replace('T', ' ')}');\n`
    })
    sql += '\n'
  }
  
  // Insert Payments
  if (data.payments.length > 0) {
    sql += '-- Insert Payments\n'
    data.payments.forEach(payment => {
      const paymentDate = payment.paymentDate ? `'${payment.paymentDate.toISOString().slice(0, 19).replace('T', ' ')}'` : 'NULL'
      sql += `INSERT INTO Payment (id, bookingId, amount, method, status, paymentDate, proofUrl, notes, createdAt, updatedAt) VALUES ('${payment.id}', '${payment.bookingId}', ${payment.amount}, '${payment.method}', '${payment.status}', ${paymentDate}, '${payment.proofUrl ? payment.proofUrl.replace(/'/g, "\\'") : ''}', '${payment.notes ? payment.notes.replace(/'/g, "\\'") : ''}', '${payment.createdAt.toISOString().slice(0, 19).replace('T', ' ')}', '${payment.updatedAt.toISOString().slice(0, 19).replace('T', ' ')}');\n`
    })
    sql += '\n'
  }
  
  // Insert Invoices
  if (data.invoices.length > 0) {
    sql += '-- Insert Invoices\n'
    data.invoices.forEach(invoice => {
      sql += `INSERT INTO Invoice (id, invoiceNumber, bookingId, amount, dueDate, status, createdAt, updatedAt) VALUES ('${invoice.id}', '${invoice.invoiceNumber}', '${invoice.bookingId}', ${invoice.amount}, '${invoice.dueDate.toISOString().slice(0, 19).replace('T', ' ')}', '${invoice.status}', '${invoice.createdAt.toISOString().slice(0, 19).replace('T', ' ')}', '${invoice.updatedAt.toISOString().slice(0, 19).replace('T', ' ')}');\n`
    })
    sql += '\n'
  }
  
  sql += '-- Re-enable foreign key checks\n'
  sql += 'SET FOREIGN_KEY_CHECKS = 1;\n'
  
  // Save SQL file
  fs.writeFileSync('./migration-script.sql', sql)
  console.log('💾 SQL script generated: migration-script.sql')
  
  return sql
}

async function main() {
  try {
    console.log('🚀 Starting SQLite to MariaDB migration...')
    
    // Export data from SQLite
    const data = await exportData()
    
    // Generate SQL script
    await generateSQL(data)
    
    console.log('✅ Migration completed successfully!')
    console.log('📁 Files generated:')
    console.log('   - exported-data.json (raw data)')
    console.log('   - migration-script.sql (SQL script)')
    console.log('\n📋 Next steps:')
    console.log('1. Update your DATABASE_URL to point to MariaDB')
    console.log('2. Run: bun run db:push (with MySQL schema)')
    console.log('3. Execute migration-script.sql in your MariaDB')
    
  } catch (error) {
    console.error('❌ Migration failed:', error)
    process.exit(1)
  }
}

main()