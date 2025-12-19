# 🚀 Booking System

Aplikasi booking berbasis web modern dengan Next.js 15, TypeScript, dan Tailwind CSS.

## ✨ Features

- 🔐 **Role-based Authentication** (Admin & Maker)
- 📊 **Dashboard Analytics** untuk kedua role
- 📅 **Booking Management** dengan status tracking
- 🎨 **Modern UI** dengan shadcn/ui components
- 📱 **Responsive Design** (Desktop & Mobile)
- 🔒 **Security** dengan JWT & password hashing

## 🚀 Quick Start

### 1. Install Dependencies
```bash
bun install
```

### 2. Setup Database
```bash
bun run db:push
```

### 3. Create Demo Users
```bash
curl -X POST http://localhost:3000/api/init
```

### 4. Start Development Server
```bash
bun run dev
```

### 5. Open Browser
Navigate to [http://localhost:3000](http://localhost:3000)

**Note**: Login now uses **username** instead of email.

## 👤 Demo Accounts

### Admin
- **Username**: admin
- **Password**: admin123
- **Access**: Full admin privileges

### Maker
- **Username**: maker  
- **Password**: maker123
- **Access**: Limited to own bookings

## 📱 Screenshots

### Login Page
Modern login form with demo account hints.

### Admin Dashboard
- Total booking statistics
- User management
- Full booking control
- Status management

### Maker Dashboard  
- Personal booking statistics
- Quick booking creation
- Booking management (edit/delete pending bookings)

## 🛠 Tech Stack

- **Framework**: Next.js 15 (App Router)
- **Language**: TypeScript 5
- **Styling**: Tailwind CSS 4
- **UI Components**: shadcn/ui
- **Database**: SQLite with Prisma ORM
- **Authentication**: JWT + bcrypt
- **Icons**: Lucide React

## 📁 Project Structure

```
src/
├── app/
│   ├── admin/          # Admin pages & dashboard
│   ├── maker/          # Maker pages & dashboard  
│   ├── api/            # API routes
│   └── login/          # Authentication page
├── components/
│   └── ui/             # shadcn/ui components
└── lib/
    ├── auth.ts         # Authentication utilities
    └── db.ts           # Database connection
```

## 🔐 Security Features

- ✅ Password hashing dengan bcrypt
- ✅ JWT token authentication
- ✅ Role-based access control
- ✅ Input validation (client & server)
- ✅ SQL injection prevention (Prisma)
- ✅ Route protection middleware

## 📊 Booking Workflow

1. **Maker creates booking** → Status: `PENDING`
2. **Admin reviews** → Status: `APPROVED`/`REJECTED`  
3. **If approved** → Status: `COMPLETED`
4. **Maker can edit/delete** → Hanya saat `PENDING`

## 🎯 Role Permissions

### Admin 👑
- ✅ View all bookings
- ✅ Edit/delete any booking
- ✅ Change booking status
- ✅ Manage users (add/delete)
- ✅ Access admin dashboard

### Maker 👷
- ✅ Create new bookings
- ✅ View own bookings only
- ✅ Edit/delete pending bookings
- ✅ Access maker dashboard
- ❌ Cannot see other users' bookings

## 🧪 Testing

### Run Linting
```bash
bun run lint
```

### Database Operations
```bash
# Reset database
bun run db:push

# View database (optional)
sqlite3 db/dev.db
```

## 📖 Documentation

For detailed documentation, see [DOCUMENTATION.md](./DOCUMENTATION.md)

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License.

---

**Built with ❤️ using Next.js 15 and TypeScript**