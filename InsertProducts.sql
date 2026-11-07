-- SQL Script to insert Mobile Products into Add_Products_tbl

-- Insert Vivo Mobile Phones with photos
INSERT INTO Add_Products_tbl (Prod_Comp_id, Prod_Name, Prod_Model, Prod_Desc, Prod_Weight, Prod_Config, Prod_Img) 
VALUES
(
    (SELECT TOP 1 Comp_Id FROM Add_Company_tbl WHERE Comp_Name LIKE '%Vivo%'), 
    'Vivo X100 Pro 5G', 
    'V2308', 
    'Premium flagship camera smartphone with ZEISS optics and Dimensity 9300 chipset.', 
    '225g', 
    '16GB RAM | 512GB Storage', 
    '~/Product_Images/vivo_x100.jpg'
),
(
    (SELECT TOP 1 Comp_Id FROM Add_Company_tbl WHERE Comp_Name LIKE '%Vivo%'), 
    'Vivo V30 Pro 5G', 
    'V2319', 
    'Ultra-slim portrait master with 50MP ZEISS triple main camera and Aura Light.', 
    '188g', 
    '12GB RAM | 256GB Storage', 
    '~/Product_Images/vivo_v30_pro.jpg'
);
