-- Booking System Database Migration Script
-- Generated from SQLite to MariaDB

-- Disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;

-- Insert Users
INSERT INTO User (id, username, email, name, password, role, createdAt, updatedAt) VALUES ('cmjbghclj0000mpca9g8p3x10', 'admin', 'admin@example.com', 'Admin User', '$2b$10$bqKcZpvlpdIvLxo9m9dbBOtuT9MVynclmrQxz5ok6lWItERXUXi7e', 'ADMIN', '2025-12-18 13:08:05', '2025-12-18 13:08:05');
INSERT INTO User (id, username, email, name, password, role, createdAt, updatedAt) VALUES ('cmjbghco00001mpcazm985jrf', 'maker', 'maker@example.com', 'Maker User', '$2b$10$8mBFfLV2.XDzncwV0HHnqOGgKTqy/6NHE6f/7xI2VtxBeOoH50ylK', 'MAKER', '2025-12-18 13:08:05', '2025-12-18 13:08:05');

-- Insert Services
INSERT INTO Service (id, name, description, price, duration, isActive, createdAt, updatedAt) VALUES ('cmjbghco20002mpca4v0ve674', 'Meeting Room', 'Ruang meeting untuk 10-20 orang', 500000, 120, true, '2025-12-18 13:08:05', '2025-12-18 13:08:05');
INSERT INTO Service (id, name, description, price, duration, isActive, createdAt, updatedAt) VALUES ('cmjbghco30003mpcakfswf2ip', 'Conference Hall', 'Aula konferensi untuk 100-200 orang', 2000000, 240, true, '2025-12-18 13:08:05', '2025-12-18 13:08:05');
INSERT INTO Service (id, name, description, price, duration, isActive, createdAt, updatedAt) VALUES ('cmjbghco40004mpca4tpav8tr', 'Training Room', 'Ruang training dengan fasilitas lengkap', 750000, 180, true, '2025-12-18 13:08:05', '2025-12-18 13:08:05');
INSERT INTO Service (id, name, description, price, duration, isActive, createdAt, updatedAt) VALUES ('cmjbghco50005mpcaurqmez44', 'Event Space', 'Ruang acara outdoor/indoor', 1500000, 300, true, '2025-12-18 13:08:05', '2025-12-18 13:08:05');
INSERT INTO Service (id, name, description, price, duration, isActive, createdAt, updatedAt) VALUES ('cmjbghco60006mpcaj3x958u6', 'Photo Studio', 'Studio foto dengan lighting lengkap', 400000, 120, true, '2025-12-18 13:08:05', '2025-12-18 13:08:05');
INSERT INTO Service (id, name, description, price, duration, isActive, createdAt, updatedAt) VALUES ('cmjbghco70007mpca4n7fzvin', 'Recording Studio', 'Studio rekaman profesional', 1000000, 180, true, '2025-12-18 13:08:05', '2025-12-18 13:08:05');
INSERT INTO Service (id, name, description, price, duration, isActive, createdAt, updatedAt) VALUES ('cmjbghco80008mpcanwvrnc9n', 'Workshop Space', 'Ruang workshop untuk 30-50 orang', 800000, 240, true, '2025-12-18 13:08:05', '2025-12-18 13:08:05');
INSERT INTO Service (id, name, description, price, duration, isActive, createdAt, updatedAt) VALUES ('cmjbghco90009mpcagdgx1bdi', 'Outdoor Event', 'Area outdoor untuk acara besar', 3000000, 360, true, '2025-12-18 13:08:05', '2025-12-18 13:08:05');

-- Insert Bookings
INSERT INTO Booking (id, userId, serviceId, serviceName, bookingDate, bookingTime, customerName, customerEmail, customerPhone, address, notes, status, price, createdAt, updatedAt) VALUES ('cmjbh42lq000bmpk2sntjw164', 'cmjbghco00001mpcazm985jrf', 'cmjbghco40004mpca4tpav8tr', 'Training Room', '2025-12-20 00:00:00', '17:00', 'Maman Sumarna', 'mamansumarna24@gmail.com', '081337141991', 'Kp. Cisaat Ciater Subang', '', 'APPROVED', 750000, '2025-12-18 13:25:45', '2025-12-18 13:48:35');

-- Insert Payments
INSERT INTO Payment (id, bookingId, amount, method, status, paymentDate, proofUrl, notes, createdAt, updatedAt) VALUES ('cmjbh8fmn000hmpk2remrhp5z', 'cmjbh42lq000bmpk2sntjw164', 1200000, 'CASH', 'COMPLETED', '2025-12-18 13:42:48', '', '', '2025-12-18 13:29:09', '2025-12-18 13:42:48');

-- Insert Invoices
INSERT INTO Invoice (id, invoiceNumber, bookingId, amount, dueDate, status, createdAt, updatedAt) VALUES ('cmjbh6zgb000dmpk258ls78q6', 'INV-1766064481762-GJ67DJIMY', 'cmjbh42lq000bmpk2sntjw164', 1200000, '2025-12-20 00:00:00', 'DRAFT', '2025-12-18 13:28:01', '2025-12-18 13:28:01');
INSERT INTO Invoice (id, invoiceNumber, bookingId, amount, dueDate, status, createdAt, updatedAt) VALUES ('cmjbh6zzi000fmpk2i142s22y', 'INV-1766064482478-XH8GF7IJP', 'cmjbh42lq000bmpk2sntjw164', 1200000, '2025-12-20 00:00:00', 'DRAFT', '2025-12-18 13:28:02', '2025-12-18 13:28:02');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;
