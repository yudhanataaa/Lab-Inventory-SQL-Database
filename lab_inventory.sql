
-- LABORATORY INVENTORY MANAGEMENT SYSTEM

-- 1. Membuat Tabel untuk Peneliti/Anggota Lab
CREATE TABLE Researchers (
    researcher_id INT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    contact_email VARCHAR(100)
);

-- 2. Membuat Tabel untuk Inventaris Lab (Reagen, Plasmid, Enzim)
CREATE TABLE Inventory (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    category VARCHAR(50), -- e.g., 'Reagent', 'Plasmid', 'Enzyme'
    stock_quantity DECIMAL(10, 2),
    unit VARCHAR(20), -- e.g., 'ml', 'mg', 'tube'
    minimum_threshold DECIMAL(10, 2), -- Batas minimum sebelum harus restock
    storage_location VARCHAR(50) -- e.g., '-80C Freezer', 'Shelf A'
);

-- 3. Membuat Tabel Catatan Penggunaan (Log)
CREATE TABLE Usage_Log (
    log_id INT PRIMARY KEY,
    item_id INT,
    researcher_id INT,
    quantity_used DECIMAL(10, 2),
    usage_date DATE,
    purpose VARCHAR(255),
    FOREIGN KEY (item_id) REFERENCES Inventory(item_id),
    FOREIGN KEY (researcher_id) REFERENCES Researchers(researcher_id)
);


-- INSERT DUMMY DATA


INSERT INTO Researchers (researcher_id, name, role, contact_email) VALUES
(1, 'Dr. Sarah', 'Principal Investigator', 'sarah@lab.edu'),
(2, 'Budi Santoso', 'Dry Lab Lead', 'budi@lab.edu'),
(3, 'Nisa', 'Wet Lab Assistant', 'nisa@lab.edu');

INSERT INTO Inventory (item_id, item_name, category, stock_quantity, unit, minimum_threshold, storage_location) VALUES
(101, 'Taq Polymerase', 'Enzyme', 5.0, 'ml', 2.0, '-20C Freezer'),
(102, 'pUC19 Plasmid', 'Plasmid', 15.0, 'tube', 5.0, '-80C Freezer'),
(103, 'LB Broth', 'Reagent', 500.0, 'ml', 100.0, 'Shelf A'),
(104, 'Ampicillin', 'Antibiotic', 10.0, 'mg', 15.0, '4C Fridge'),
(105, 'EcoRI', 'Enzyme', 1.5, 'ml', 2.0, '-20C Freezer');

INSERT INTO Usage_Log (log_id, item_id, researcher_id, quantity_used, usage_date, purpose) VALUES
(1001, 101, 3, 0.5, '2026-03-10', 'PCR amplification for construct A'),
(1002, 103, 3, 200.0, '2026-03-11', 'Bacterial culture preparation'),
(1003, 104, 2, 5.0, '2026-03-12', 'Selecting transformed E. coli'),
(1004, 102, 2, 1.0, '2026-03-12', 'Cloning vector preparation');


-- ANALYTICAL QUERIES


-- Query 1: Cek barang apa saja yang stoknya sudah menipis (Butuh Restock)
SELECT item_name, category, stock_quantity, minimum_threshold, storage_location
FROM Inventory
WHERE stock_quantity <= minimum_threshold;

-- Query 2: Lacak siapa yang menggunakan Reagen/Enzim tertentu dan untuk apa (Menggunakan JOIN)
SELECT u.usage_date, i.item_name, r.name AS user_name, u.quantity_used, i.unit, u.purpose
FROM Usage_Log u
JOIN Inventory i ON u.item_id = i.item_id
JOIN Researchers r ON u.researcher_id = r.researcher_id
ORDER BY u.usage_date DESC;

-- Query 3: Hitung total penggunaan per kategori barang selama ini (GROUP BY)
SELECT i.category, SUM(u.quantity_used) AS total_used
FROM Usage_Log u
JOIN Inventory i ON u.item_id = i.item_id
GROUP BY i.category
ORDER BY total_used DESC;
