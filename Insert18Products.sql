-- SQL Script to clear old products and insert 18 products (3 products for each of the 6 mobile companies) into Add_Products_tbl

-- 1. Delete existing products
DELETE FROM Add_Products_tbl;

-- 2. Reseed identity seed to start from 1
DBCC CHECKIDENT ('Add_Products_tbl', RESEED, 0);

-- 3. Insert 18 Products (3 for each company)
INSERT INTO Add_Products_tbl (Prod_Comp_Id, Prod_Name, Prod_Model, Prod_Desc, Prod_Weight, Prod_Config, Prod_Img) VALUES
-- Apple (Comp_Id: 1)
(1, 'iPhone 15 Pro Max', 'A3106', 'Titanium design, A17 Pro chip, 5x Telephoto camera.', '221g', '8GB RAM, 256GB Storage, 6.7" Super Retina XDR', '~/Product_Images/apple_iphone15promax.png'),
(1, 'iPhone 15', 'A3090', 'Dynamic Island, 48MP Main camera, USB-C, Durable design.', '171g', '6GB RAM, 128GB Storage, 6.1" Super Retina XDR', '~/Product_Images/apple_iphone15.png'),
(1, 'iPhone 14', 'A2882', 'Super Retina XDR display, Advanced dual-camera system.', '172g', '6GB RAM, 128GB Storage, A15 Bionic Chip', '~/Product_Images/apple_iphone14.png'),

-- Samsung (Comp_Id: 2)
(2, 'Galaxy S24 Ultra', 'SM-S928B', 'Galaxy AI features, 200MP Quad camera, Titanium frame, Built-in S Pen.', '232g', '12GB RAM, 512GB Storage, Snapdragon 8 Gen 3', '~/Product_Images/samsung_s24ultra.png'),
(2, 'Galaxy Z Fold5', 'SM-F946B', 'Foldable 7.6" Main display, Armor Aluminum frame, Flex Hinge.', '253g', '12GB RAM, 512GB Storage, Snapdragon 8 Gen 2', '~/Product_Images/samsung_zfold5.png'),
(2, 'Galaxy A55 5G', 'SM-A556B', 'Premium glass back, Metal frame, 50MP OIS camera, 5000mAh battery.', '213g', '8GB RAM, 256GB Storage, Exynos 1480', '~/Product_Images/samsung_a55.png'),

-- Vivo (Comp_Id: 3)
(3, 'Vivo X100 Pro', 'V2308', 'ZEISS APO Floating Telephoto camera, Dimensity 9300 chip.', '225g', '16GB RAM, 512GB Storage, 5400mAh Battery', '~/Product_Images/vivo_x100pro.png'),
(3, 'Vivo V30 Pro', 'V2319', 'ZEISS Professional Portrait Camera, Studio Quality Aura Light.', '188g', '12GB RAM, 512GB Storage, Dimensity 8200', '~/Product_Images/vivo_v30pro.png'),
(3, 'Vivo Y200e 5G', 'V2336', 'Eco-Fiber Leather finish, 120Hz AMOLED display, 50MP HD Camera.', '191g', '8GB RAM, 128GB Storage, Snapdragon 4 Gen 2', '~/Product_Images/vivo_y200e.png'),

-- Oppo (Comp_Id: 4)
(4, 'Oppo Find X7 Ultra', 'PHY110', 'World''s first Quad Main Camera with Dual Periscope Telephoto.', '221g', '16GB RAM, 512GB Storage, Snapdragon 8 Gen 3', '~/Product_Images/oppo_findx7ultra.png'),
(4, 'Oppo Reno 11 Pro 5G', 'CPH2607', '32MP Telephoto Portrait Camera, 80W SUPERVOOC charging.', '181g', '12GB RAM, 256GB Storage, Dimensity 8200', '~/Product_Images/oppo_reno11pro.png'),
(4, 'Oppo F25 Pro 5G', 'CPH2603', 'Ultra-slim 7.54mm body, 4K video recording, 64MP Triple Camera.', '177g', '8GB RAM, 256GB Storage, Dimensity 7050', '~/Product_Images/oppo_f25pro.png'),

-- OnePlus (Comp_Id: 5)
(5, 'OnePlus 12', 'CPH2581', '4th Gen Hasselblad Camera, 2K 120Hz ProXDR display, 100W charging.', '220g', '16GB RAM, 512GB Storage, Snapdragon 8 Gen 3', '~/Product_Images/oneplus_12.png'),
(5, 'OnePlus 12R', 'CPH2585', '1.5K 4th Gen LTPO display, 5500mAh largest battery, 100W charging.', '207g', '16GB RAM, 256GB Storage, Snapdragon 8 Gen 2', '~/Product_Images/oneplus_12r.png'),
(5, 'OnePlus Nord CE4', 'CPH2613', 'Sony LYT-600 OIS camera, 100W SUPERVOOC fast charging.', '186g', '8GB RAM, 256GB Storage, Snapdragon 7 Gen 3', '~/Product_Images/oneplus_nordce4.png'),

-- Xiaomi (Comp_Id: 6)
(6, 'Xiaomi 14 Ultra', '24030PN60G', 'Leica Quad Camera with 1-inch Sony LYT-900 sensor.', '220g', '16GB RAM, 512GB Storage, Snapdragon 8 Gen 3', '~/Product_Images/xiaomi_14ultra.png'),
(6, 'Xiaomi 14', '23127PN0CG', 'Compact flagship, Leica Summilux optical lens, 90W HyperCharge.', '193g', '12GB RAM, 512GB Storage, Snapdragon 8 Gen 3', '~/Product_Images/xiaomi_14.png'),
(6, 'Redmi Note 13 Pro+ 5G', '23090RA98I', '200MP OIS Camera, Curved 120Hz AMOLED display, 120W HyperCharge.', '204g', '12GB RAM, 512GB Storage, Dimensity 7200 Ultra', '~/Product_Images/xiaomi_redminote13pro.png');
