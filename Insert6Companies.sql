-- SQL Script to clear old company data and insert 6 mobile phone companies into Add_Company_tbl

-- 1. Delete old records from Add_Products_tbl & Add_Company_tbl
DELETE FROM Add_Products_tbl;
DELETE FROM Add_Company_tbl;

-- 2. Reseed identity seeds to start from 1
DBCC CHECKIDENT ('Add_Company_tbl', RESEED, 0);
DBCC CHECKIDENT ('Add_Products_tbl', RESEED, 0);

-- 3. Insert 6 Mobile Companies
INSERT INTO Add_Company_tbl (Comp_Name, Comp_Owner_Name, Comp_Email, Comp_Address, Comp_Cover_img) VALUES
('Apple', 'Tim Cook', 'contact@apple.com', 'Cupertino, California, USA', '~/Comp_Images/apple.png'),
('Samsung', 'Lee Jae-yong', 'contact@samsung.com', 'Seoul, South Korea', '~/Comp_Images/samsung.png'),
('Vivo', 'Shen Wei', 'contact@vivo.com', 'Dongguan, China', '~/Comp_Images/vivo.png'),
('Oppo', 'Chen Mingyong', 'contact@oppo.com', 'Dongguan, China', '~/Comp_Images/oppo.png'),
('OnePlus', 'Pete Lau', 'contact@oneplus.com', 'Shenzhen, China', '~/Comp_Images/oneplus.png'),
('Xiaomi', 'Lei Jun', 'contact@xiaomi.com', 'Beijing, China', '~/Comp_Images/xiaomi.png');

-- 4. Insert Flagship Phones into Add_Products_tbl
INSERT INTO Add_Products_tbl (Prod_Comp_Id, Prod_Name, Prod_Model, Prod_Desc, Prod_Weight, Prod_Config, Prod_Img) VALUES
(1, 'iPhone 15 Pro Max', 'A3106', 'Flagship iPhone with Titanium body, A17 Pro Chip and 5x Telephoto Zoom.', '221g', '8GB RAM, 256GB Storage, Super Retina XDR Display', '~/Product_Images/apple.png'),
(2, 'Galaxy S24 Ultra', 'SM-S928B', 'Flagship Samsung Galaxy with Galaxy AI, 200MP Camera and Built-in S-Pen.', '232g', '12GB RAM, 512GB Storage, Snapdragon 8 Gen 3', '~/Product_Images/samsung.png'),
(3, 'Vivo X100 Pro', 'V2308', 'Zeiss Optics Camera Smartphone with Dimensity 9300 chipset.', '225g', '16GB RAM, 512GB Storage, 5400mAh Battery', '~/Product_Images/vivo.png'),
(4, 'Oppo Find X7 Ultra', 'PHY110', 'Quad Main Camera with Dual Periscope Lenses and Hasselblad tuning.', '221g', '16GB RAM, 512GB Storage, Snapdragon 8 Gen 3', '~/Product_Images/oppo.png'),
(5, 'OnePlus 12', 'CPH2581', 'Powerful flagship with 4th Gen Hasselblad Camera System and 100W SUPERVOOC charging.', '220g', '16GB RAM, 512GB Storage, 5400mAh Battery', '~/Product_Images/oneplus.png'),
(6, 'Xiaomi 14 Ultra', '24030PN60G', 'Leica Quad Camera flagship with 1-inch sensor and Snapdragon 8 Gen 3.', '220g', '16GB RAM, 512GB Storage, 90W HyperCharge', '~/Product_Images/xiaomi.png');
