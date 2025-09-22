-- Create fresh database
CREATE DATABASE production_inventory;
USE production_inventory;

-- Suppliers table
CREATE TABLE suppliers (
  supplier_id INT AUTO_INCREMENT PRIMARY KEY,
  supplier_name VARCHAR(100) NOT NULL,
  contact_number VARCHAR(20) UNIQUE,
  address VARCHAR(255)
);

-- Items table
CREATE TABLE items (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  item_name VARCHAR(100) NOT NULL,
  category VARCHAR(50),
  unit_price DECIMAL(10,2) NOT NULL,
  stock_quantity INT NOT NULL DEFAULT 0,
  supplier_id INT,
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Purchase Orders table
CREATE TABLE purchase_orders (
  po_id INT AUTO_INCREMENT PRIMARY KEY,
  po_number VARCHAR(50) NOT NULL UNIQUE,
  supplier_id INT NOT NULL,
  order_date DATE NOT NULL,
  expected_date DATE,
  status VARCHAR(20) DEFAULT 'OPEN',
  total_amount DECIMAL(12,2) DEFAULT 0.00,
  FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Purchase Order Items table (many-to-many between orders and items)
CREATE TABLE po_items (
  po_item_id INT AUTO_INCREMENT PRIMARY KEY,
  po_id INT NOT NULL,
  item_id INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  quantity INT NOT NULL,
  FOREIGN KEY (po_id) REFERENCES purchase_orders(po_id),
  FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Sample data
INSERT INTO suppliers (supplier_name, contact_number, address)
VALUES 
('ABC Traders', '0712345678', 'Nairobi'),
('XYZ Supplies', '0798765432', 'Mombasa');

INSERT INTO items (item_name, category, unit_price, stock_quantity, supplier_id)
VALUES 
('Laptop', 'Electronics', 75000, 10, 1),
('Printer', 'Electronics', 32000, 5, 2);

INSERT INTO purchase_orders (po_number, supplier_id, order_date, expected_date, status, total_amount)
VALUES 
('PO-2025-001', 1, '2025-09-22', '2025-09-30', 'RECEIVED', 150000);

INSERT INTO po_items (po_id, item_id, unit_price, quantity)
VALUES (1, 1, 75000, 2);
