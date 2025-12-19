# Booking System Documentation

## Overview

Aplikasi booking berbasis web modern yang dibangun dengan Next.js 15, TypeScript, dan Tailwind CSS. Aplikasi ini memiliki sistem role-based access control dengan dua role utama: Admin dan Maker.

## Features

### 🔐 Authentication
- Login system dengan JWT token
- Demo accounts untuk testing
- Session management
- Role-based access control

### 👥 User Roles

#### Admin Features:
- **Dashboard**: Statistik lengkap booking dan user
- **User Management**: Tambah, hapus user
- **Booking Management**: Lihat, edit, hapus, ubah status booking
- **Full Access**: Akses ke semua data booking

#### Maker Features:
- **Dashboard**: Statistik booking miliknya sendiri
- **Create Booking**: Form pembuatan booking baru
- **Manage Bookings**: Edit/hapus booking (hanya yang status Pending)
- **Limited Access**: Hanya bisa melihat booking miliknya sendiri

### 📊 Booking System
- Status otomatis: Pending → Approved/Rejected → Completed
- Form validation client & server side
- Real-time status updates
- Search dan filter functionality

## Tech Stack

- **Frontend**: Next.js 15, TypeScript, Tailwind CSS, shadcn/ui
- **Backend**: Next.js API Routes, Prisma ORM
- **Database**: SQLite
- **Authentication**: JWT with bcrypt password hashing
- **UI Components**: shadcn/ui dengan Lucide icons

## Installation & Setup

### Prerequisites
- Node.js 18+
- Bun package manager

### Installation
```bash
# Install dependencies
bun install

# Setup database
bun run db:push

# Create demo users
curl -X POST http://localhost:3000/api/init
```

### Running the Application
```bash
# Start development server
bun run dev

# Run linting
bun run lint
```

## Demo Accounts

### Admin Account
- **Username**: admin
- **Password**: admin123
- **Access**: Full admin privileges

### Maker Account
- **Username**: maker
- **Password**: maker123
- **Access**: Limited to own bookings

## URL Structure

### Public Routes
- `/` - Redirect berdasarkan role
- `/login` - Login page

### Admin Routes
- `/admin/dashboard` - Admin dashboard
- `/admin/bookings` - Manajemen booking
- `/admin/users` - Manajemen user

### Maker Routes
- `/maker/dashboard` - Maker dashboard
- `/maker/bookings` - Daftar booking miliknya
- `/maker/bookings/new` - Form booking baru

### API Routes
- `/api/auth/login` - Authentication
- `/api/auth/register` - User registration
- `/api/init` - Create demo users
- `/api/admin/*` - Admin endpoints
- `/api/maker/*` - Maker endpoints

## Database Schema

### Users Table
```sql
- id (String, Primary Key)
- username (String, Unique)
- email (String, Unique)
- name (String)
- password (String, Hashed)
- role (Enum: ADMIN, MAKER)
- createdAt (DateTime)
- updatedAt (DateTime)
```

### Bookings Table
```sql
- id (String, Primary Key)
- userId (String, Foreign Key)
- tanggal (DateTime)
- layanan (String)
- jumlah (Integer)
- catatan (String, Optional)
- status (Enum: PENDING, APPROVED, REJECTED, COMPLETED)
- createdAt (DateTime)
- updatedAt (DateTime)
```

## Security Features

- **Password Hashing**: Menggunakan bcrypt
- **JWT Authentication**: Token-based authentication
- **Role-based Access**: Middleware proteksi route
- **Input Validation**: Client dan server side validation
- **SQL Injection Prevention**: Prisma ORM protection

## UI/UX Features

- **Responsive Design**: Mobile-first approach
- **Modern UI**: shadcn/ui components
- **Dark Mode Support**: next-themes integration
- **Loading States**: Skeleton dan spinners
- **Error Handling**: User-friendly error messages
- **Accessibility**: Semantic HTML dan ARIA support

## Booking Workflow

1. **Maker creates booking** → Status: PENDING
2. **Admin reviews** → Status: APPROVED/REJECTED
3. **If approved** → Status: COMPLETED (setelah event)
4. **Maker can edit/delete** → Hanya saat PENDING

## Development Notes

### File Structure
```
src/
├── app/
│   ├── admin/          # Admin pages
│   ├── maker/          # Maker pages
│   ├── api/            # API routes
│   └── login/          # Login page
├── components/
│   └── ui/             # shadcn/ui components
└── lib/
    ├── auth.ts         # Authentication utilities
    └── db.ts           # Database connection
```

### Environment Variables
```env
DATABASE_URL="file:./dev.db"
JWT_SECRET="your-secret-key"
```

## Future Enhancements

- Email notifications
- File upload for booking documents
- Export to PDF/Excel
- Advanced reporting
- Real-time notifications dengan WebSocket
- Multi-language support
- Advanced booking calendar

## Support

Untuk issues atau questions, silakan cek console logs atau contact development team.

---

**Note**: Aplikasi ini menggunakan Next.js 15 dengan App Router dan TypeScript untuk type safety dan development experience yang lebih baik.