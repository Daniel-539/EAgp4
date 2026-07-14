-- 建立資料庫
CREATE DATABASE IF NOT EXISTS snack_shop;
USE snack_shop;

-- ============================================================
-- 用戶表
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 產品表（全部 190 件產品）
-- ============================================================
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    name_en VARCHAR(200),
    name_cn VARCHAR(200),
    category VARCHAR(50) NOT NULL,
    weight VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 購物車表
-- ============================================================
CREATE TABLE IF NOT EXISTS cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_cart (user_id, product_id)
);

-- ============================================================
-- 訂單表（進階功能）
-- ============================================================
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ============================================================
-- 訂單項目表
-- ============================================================
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- ============================================================
-- 插入產品資料（從之前嘅 products array 轉換）
-- ============================================================
INSERT INTO products (name, name_en, name_cn, category, weight, price) VALUES
('GINBIS 愉快動物餅乾 牛油味', 'GINBIS Animal Biscuits Butter', 'GINBIS 愉快动物饼干 牛油味', 'biscuit', '37g', 8),
('GINBIS 愉快動物餅乾 紫菜味', 'GINBIS Animal Biscuits Seaweed', 'GINBIS 愉快动物饼干 紫菜味', 'biscuit', '37g', 8),
('GINBIS 愉快動物餅 8包 紫菜味', 'GINBIS Animal Biscuits 8pcs Seaweed', 'GINBIS 愉快动物饼 8包 紫菜味', 'biscuit', '144g', 28),
('固力果 番茄味百力滋餅乾條', 'Glico Pretz Tomato', '固力果 番茄味百力滋饼干条', 'biscuit', '64g', 12),
('固力果 沙律味百力滋餅乾條', 'Glico Pretz Salad', '固力果 沙律味百力滋饼干条', 'biscuit', '64g', 12),
('固力果 朱古力味百力滋餅乾條', 'Glico Pretz Chocolate', '固力果 朱古力味百力滋饼干条', 'biscuit', '52g', 12),
('固力果 士多啤梨味百力滋餅乾條', 'Glico Pretz Strawberry', '固力果 士多啤梨味百力滋饼干条', 'biscuit', '51g', 12),
('固力果 沙律味百力滋家庭裝', 'Glico Pretz Salad Family Pack', '固力果 沙律味百力滋家庭装', 'biscuit', '118g', 18),
('固力果 番茄味百力滋家庭裝', 'Glico Pretz Tomato Family Pack', '固力果 番茄味百力滋家庭装', 'biscuit', '110g', 18),
('固力果 士多啤梨味百力滋家庭裝', 'Glico Pretz Strawberry Family Pack', '固力果 士多啤梨味百力滋家庭装', 'biscuit', '87g', 18),
('固力果 朱古力味百力滋家庭裝', 'Glico Pretz Chocolate Family Pack', '固力果 朱古力味百力滋家庭装', 'biscuit', '95g', 18),
('固力果 沙律味百力滋', 'Glico Pretz Salad', '固力果 沙律味百力滋', 'biscuit', '193g', 25),
('固力果 炭燒百力滋', 'Glico Pretz Charcoal', '固力果 炭烧百力滋', 'biscuit', '193g', 25),
('樂天 朱古力熊仔餅', 'Lotte Koala March Chocolate', '乐天 朱古力熊仔饼', 'biscuit', '37g', 10),
('樂天 士多啤梨味熊仔餅', 'Lotte Koala March Strawberry', '乐天 士多啤梨味熊仔饼', 'biscuit', '37g', 10),
('樂天 朱古力小熊餅家庭裝', 'Lotte Koala March Chocolate Family Pack', '乐天 朱古力小熊饼家庭装', 'biscuit', '195g', 28),
('樂天 白朱古力牛奶味芝士小熊餅', 'Lotte Koala March White Chocolate Cheese', '乐天 白朱古力牛奶味芝士小熊饼', 'biscuit', '195g', 28),
('樂天 特濃朱古力小熊餅家庭裝', 'Lotte Koala March Rich Chocolate Family Pack', '乐天 特浓朱古力小熊饼家庭装', 'biscuit', '195g', 28),
('樂天 杏仁朱古力餅棒', 'Lotte Almond Chocolate Biscuit Stick', '乐天 杏仁朱古力饼棒', 'biscuit', '32g', 10),
('樂天 脆米朱古力餅棒', 'Lotte Crispy Rice Chocolate Biscuit Stick', '乐天 脆米朱古力饼棒', 'biscuit', '39g', 10),
('樂天 白朱古力杏仁餅棒', 'Lotte White Chocolate Almond Biscuit Stick', '乐天 白朱古力杏仁饼棒', 'biscuit', '32g', 10),
('樂天 白朱古力曲奇餅棒', 'Lotte White Chocolate Cookie Biscuit Stick', '乐天 白朱古力曲奇饼棒', 'biscuit', '32g', 10),
('旺旺 仙貝 (兩片裝)', 'Want Want Senbei (2pcs)', '旺旺 仙贝 (两片装)', 'biscuit', '56g', 12),
('旺旺 雪餅', 'Want Want Rice Crackers', '旺旺 雪饼', 'biscuit', '72g', 12),
('旺旺 燒米餅', 'Want Want Baked Rice Crackers', '旺旺 烧米饼', 'biscuit', '72g', 12),
('旺旺 機燒海苔米果', 'Want Want Seaweed Rice Cracker', '旺旺 机烧海苔米果', 'biscuit', '136g', 18),
('旺旺 厚燒海苔米果', 'Want Want Thick Seaweed Rice Cracker', '旺旺 厚烧海苔米果', 'biscuit', '308g', 28),
('旺旺 鐵火燒香濃芝士米果', 'Want Want Cheese Rice Cracker', '旺旺 铁火烧香浓芝士米果', 'biscuit', '96g', 15),
('旺旺 仙貝（經濟包）', 'Want Want Senbei (Economy Pack)', '旺旺 仙贝（经济包）', 'biscuit', '400g', 30),
('旺旺 芝士玉米味仙貝米餅', 'Want Want Cheese Corn Senbei', '旺旺 芝士玉米味仙贝米饼', 'biscuit', '258g', 25),
('旺旺 雪餅（經濟包）', 'Want Want Rice Crackers (Economy Pack)', '旺旺 雪饼（经济包）', 'biscuit', '400g', 30),
('旺旺 黑白配', 'Want Want Black & White', '旺旺 黑白配', 'biscuit', '60g', 10),
('江戶 DHA餅', 'Edo DHA Biscuits', '江户 DHA饼', 'biscuit', '172g', 18),
('江戶 杏仁餅', 'Edo Almond Biscuits', '江户 杏仁饼', 'biscuit', '133g', 18),
('江戶 薯仔餅', 'Edo Potato Biscuits', '江户 薯仔饼', 'biscuit', '172g', 18),
('江戶 牛乳餅', 'Edo Milk Biscuits', '江户 牛乳饼', 'biscuit', '172g', 18),
('Edo梳打餅', 'Edo Soda Crackers', 'Edo梳打饼', 'biscuit', '141g', 15),
('Edo奶酪餅', 'Edo Cheese Crackers', 'Edo奶酪饼', 'biscuit', '172g', 18),
('桃哈多 Harvest餅乾 - 牛油吐司味', 'Tohato Harvest Butter Toast', '桃哈多 Harvest饼干 - 牛油吐司味', 'biscuit', '4pcs', 10),
('桃哈多 Harvest餅乾 - 芝麻味', 'Tohato Harvest Sesame', '桃哈多 Harvest饼干 - 芝麻味', 'biscuit', '4pcs', 10),
('桃哈多 Harvest 餅乾 - 芝麻味', 'Tohato Harvest Sesame', '桃哈多 Harvest 饼干 - 芝麻味', 'biscuit', '72pcs', 35),
('桃哈多 蠟筆小新朱古力餅', 'Tohato Crayon Shin-chan Chocolate Biscuit', '桃哈多 蜡笔小新朱古力饼', 'biscuit', '25g', 8),

-- 薯片 (chip)
('卡樂B 熱浪香辣味薯片', 'Calbee Hot & Spicy Chips', '卡乐B 热浪香辣味薯片', 'chip', '55g', 15),
('卡樂B 熱浪香辣味薯片', 'Calbee Hot & Spicy Chips', '卡乐B 热浪香辣味薯片', 'chip', '105g', 8),
('卡樂B 燒烤味薯片', 'Calbee BBQ Chips', '卡乐B 烧烤味薯片', 'chip', '55g', 15),
('卡樂B 燒烤味薯片', 'Calbee BBQ Chips', '卡乐B 烧烤味薯片', 'chip', '105g', 8),
('卡樂B 蕃茄味薯片', 'Calbee Tomato Chips', '卡乐B 蕃茄味薯片', 'chip', '55g', 14),
('卡樂B 蕃茄味薯片', 'Calbee Tomato Chips', '卡乐B 蕃茄味薯片', 'chip', '90g', 8),
('卡樂B 原味薯片', 'Calbee Original Chips', '卡乐B 原味薯片', 'chip', '55g', 8),
('卡樂B 日燒醬汁味薯片', 'Calbee Japanese BBQ Sauce Chips', '卡乐B 日烧酱汁味薯片', 'chip', '55g', 15),
('卡樂B 日燒醬汁味薯片', 'Calbee Japanese BBQ Sauce Chips', '卡乐B 日烧酱汁味薯片', 'chip', '105g', 8),
('卡樂B 紫菜味薯片', 'Calbee Seaweed Chips', '卡乐B 紫菜味薯片', 'chip', '55g', 9),
('卡樂B 蜂蜜牛油味薯片', 'Calbee Honey Butter Chips', '卡乐B 蜂蜜牛油味薯片', 'chip', '55g', 16),
('卡樂B 蜂蜜牛油味薯片', 'Calbee Honey Butter Chips', '卡乐B 蜂蜜牛油味薯片', 'chip', '102g', 8),
('卡樂B 薄餅味薯片', 'Calbee Pizza Chips', '卡乐B 薄饼味薯片', 'chip', '55g', 14),
('卡樂B 薄餅味薯片', 'Calbee Pizza Chips', '卡乐B 薄饼味薯片', 'chip', '90g', 8),
('卡樂B 香辣薄餅味薯片', 'Calbee Spicy Pizza Chips', '卡乐B 香辣薄饼味薯片', 'chip', '55g', 8),
('卡樂B 咖喱味薯片', 'Calbee Curry Chips', '卡乐B 咖喱味薯片', 'chip', '55g', 28),
('卡樂B 波浪熱浪香辣味薯片', 'Calbee Wavy Hot & Spicy Chips', '卡乐B 波浪热浪香辣味薯片', 'chip', '192g', 28),
('卡樂B 波浪燒烤味薯片', 'Calbee Wavy BBQ Chips', '卡乐B 波浪烧烤味薯片', 'chip', '192g', 6),
('日清湖池屋 激肉魔薯 燒烤味薯片', 'Nissin Koikeya Jagariko BBQ', '日清湖池屋 激肉魔薯 烧烤味薯片', 'chip', '25g', 12),
('日清湖池屋 激肉魔薯 燒烤味薯片', 'Nissin Koikeya Jagariko BBQ', '日清湖池屋 激肉魔薯 烧烤味薯片', 'chip', '55g', 6),
('日清湖池屋 激辣魔薯 香辣味薯片', 'Nissin Koikeya Jagariko Spicy', '日清湖池屋 激辣魔薯 香辣味薯片', 'chip', '25g', 12),
('日清湖池屋 激辣魔薯 香辣味薯片', 'Nissin Koikeya Jagariko Spicy', '日清湖池屋 激辣魔薯 香辣味薯片', 'chip', '55g', 20),
('日清湖池屋 激辣魔薯 香辣味薯片', 'Nissin Koikeya Jagariko Spicy', '日清湖池屋 激辣魔薯 香辣味薯片', 'chip', '105g', 6),
('日清湖池屋 激辣魔薯 香辣芝士味薯片', 'Nissin Koikeya Jagariko Spicy Cheese', '日清湖池屋 激辣魔薯 香辣芝士味薯片', 'chip', '25g', 12),
('日清湖池屋 激辣魔薯 香辣芝士味薯片', 'Nissin Koikeya Jagariko Spicy Cheese', '日清湖池屋 激辣魔薯 香辣芝士味薯片', 'chip', '55g', 18),
('江戶 巨浪大切蕃茄味薯片', 'Edo Great Wave Tomato Chips', '江户 巨浪大切蕃茄味薯片', 'chip', '150g', 22),
('江戶 巨浪大切 紫菜味薯片', 'Edo Great Wave Seaweed Chips', '江户 巨浪大切 紫菜味薯片', 'chip', '150g', 22),
('江戶巨浪大切沙律醬焗薯味薯片', 'Edo Great Wave Salad Baked Potato Chips', '江户巨浪大切沙律酱焗薯味薯片', 'chip', '150g', 22),
('江戶 巨浪大切香辣味薯片', 'Edo Great Wave Spicy Chips', '江户 巨浪大切香辣味薯片', 'chip', '150g', 22),

-- 朱古力 (chocolate)
('明治牛奶朱古力盒裝', 'Meiji Milk Chocolate Box', '明治牛奶朱古力盒装', 'chocolate', '120g', 25),
('明治特濃朱古力盒裝', 'Meiji Rich Chocolate Box', '明治特浓朱古力盒装', 'chocolate', '120g', 28),
('明治抹茶朱古力盒裝', 'Meiji Matcha Chocolate Box', '明治抹茶朱古力盒装', 'chocolate', '120g', 30),
('明治麥加果仁朱古力', 'Meiji Macadamia Chocolate', '明治麦加果仁朱古力', 'chocolate', '64g', 18),
('明治麥加果仁朱古力', 'Meiji Macadamia Chocolate', '明治麦加果仁朱古力', 'chocolate', '9PC', 12),
('明治杏仁朱古力', 'Meiji Almond Chocolate', '明治杏仁朱古力', 'chocolate', '79g', 18),
('明治杏仁抹茶朱古力', 'Meiji Almond Matcha Chocolate', '明治杏仁抹茶朱古力', 'chocolate', '67g', 20),
('樂天 麥加果仁朱古力', 'Lotte Macadamia Chocolate', '乐天 麦加果仁朱古力', 'chocolate', '67g', 15),
('樂天 杏仁朱古力', 'Lotte Almond Chocolate', '乐天 杏仁朱古力', 'chocolate', '86g', 16),
('樂天 脆米杏仁朱古力', 'Lotte Crispy Almond Chocolate', '乐天 脆米杏仁朱古力', 'chocolate', '80g', 16),
('YUKA 提拉米蘇朱古力', 'YUKA Tiramisu Chocolate', 'YUKA 提拉米苏朱古力', 'chocolate', '160g', 22),

-- 其他 (other)
('卡樂B 原味蝦條', 'Calbee Original Shrimp Crackers', '卡乐B 原味虾条', 'other', '40g', 12),
('卡樂B 原味蝦條', 'Calbee Original Shrimp Crackers', '卡乐B 原味虾条', 'other', '90g', 18),
('卡樂B燒烤味蝦條', 'Calbee BBQ Shrimp Crackers', '卡乐B烧烤味虾条', 'other', '40g', 12),
('卡樂B燒烤味蝦條', 'Calbee BBQ Shrimp Crackers', '卡乐B烧烤味虾条', 'other', '90g', 18),
('卡樂B辛之味蝦條', 'Calbee Spicy Shrimp Crackers', '卡乐B辛之味虾条', 'other', '90g', 18),
('卡樂B和風醬汁味蝦條', 'Calbee Japanese Sauce Shrimp Crackers', '卡乐B和风酱汁味虾条', 'other', '90g', 18),
('卡樂B原味蝦條4連包', 'Calbee Original Shrimp Crackers 4pk', '卡乐B原味虾条4连包', 'other', '4 x 14g', 20),
('卡樂B燒烤味蝦條4連包', 'Calbee BBQ Shrimp Crackers 4pk', '卡乐B烧烤味虾条4连包', 'other', '4 x 14g', 20),
('卡樂B和風醬汁味蝦條4連包', 'Calbee Japanese Sauce Shrimp Crackers 4pk', '卡乐B和风酱汁味虾条4连包', 'other', '4 x 14g', 20),
('宅卡B薯條 原味企身袋裝', 'Jagariko Original Standing Pouch', '宅卡B薯条 原味企身袋装', 'other', '5 x 18g', 22),
('宅卡B薯條 熱浪香辣味企身袋裝', 'Jagariko Hot & Spicy Standing Pouch', '宅卡B薯条 热浪香辣味企身袋装', 'other', '5 x 17g', 22),
('宅卡B薯條 燒烤味企身袋裝', 'Jagariko BBQ Standing Pouch', '宅卡B薯条 烧烤味企身袋装', 'other', '5 x 17g', 22),
('宅卡B薯條 紫菜味企身袋裝', 'Jagariko Seaweed Standing Pouch', '宅卡B薯条 紫菜味企身袋装', 'other', '5 x 17g', 22),
('卡樂B粟一燒 燒烤味', 'Calbee Corn Snack BBQ', '卡乐B粟一烧 烧烤味', 'other', '32g', 10),
('卡樂B粟一燒 燒烤味', 'Calbee Corn Snack BBQ', '卡乐B粟一烧 烧烤味', 'other', '80g', 16),
('卡樂B粟一燒 熱浪香辣味', 'Calbee Corn Snack Hot & Spicy', '卡乐B粟一烧 热浪香辣味', 'other', '60g', 14),
('卡樂B粟一燒 蒲燒鰻魚味', 'Calbee Corn Snack Grilled Eel', '卡乐B粟一烧 蒲烧鳗鱼味', 'other', '80g', 18),
('卡樂B粟一燒 煙燻芝士味', 'Calbee Corn Snack Smoked Cheese', '卡乐B粟一烧 烟熏芝士味', 'other', '80g', 18),
('卡樂B 粟米條 芝士味', 'Calbee Corn Sticks Cheese', '卡乐B 粟米条 芝士味', 'other', '80g', 16),
('桃哈多 花生焦糖粟米條', 'Tohato Peanut Caramel Corn', '桃哈多 花生焦糖粟米条', 'other', '20g', 8),
('桃哈多 焦糖粟米條', 'Tohato Caramel Corn', '桃哈多 焦糖粟米条', 'other', '70g', 14),
('桃哈多 鹽味焦糖粟米條', 'Tohato Salt Caramel Corn', '桃哈多 盐味焦糖粟米条', 'other', '67g', 14),
('桃哈多 焦糖粟米條 - 濃厚朱古力', 'Tohato Caramel Corn Rich Chocolate', '桃哈多 焦糖粟米条 - 浓厚朱古力', 'other', '65g', 16),
('桃哈多 焦糖粟米條 - 濃厚抹茶味', 'Tohato Caramel Corn Rich Matcha', '桃哈多 焦糖粟米条 - 浓厚抹茶味', 'other', '65g', 16),
('桃哈多 高達Poteco薯圈', 'Tohato Poteco Potato Rings', '桃哈多 高达Poteco薯圈', 'other', '23g', 8),
('桃哈多 焦糖粟米條 4連包', 'Tohato Caramel Corn 4pk', '桃哈多 焦糖粟米条 4连包', 'other', '4 x 10g', 18),
('桃哈多 嬰孩粟米圈 - 輕鹽味', 'Tohato Baby Corn Rings Light Salt', '桃哈多 婴孩粟米圈 - 轻盐味', 'other', '25g', 8),
('桃哈多 Poteco 薯圈 - 鹽味', 'Tohato Poteco Potato Rings Salt', '桃哈多 Poteco 薯圈 - 盐味', 'other', '23g', 8),
('桃哈多 Poteko 薯圈 - 淡鹽味', 'Tohato Poteko Potato Rings Light Salt', '桃哈多 Poteko 薯圈 - 淡盐味', 'other', '5 x 44g', 18),

-- 飲品 - 咖啡·茶 (coffee_tea)
('UCC 牛奶咖啡', 'UCC Milk Coffee', 'UCC 牛奶咖啡', 'coffee_tea', '375g', 15),
('UCC 黑咖啡 (無糖)', 'UCC Black Coffee (Sugar Free)', 'UCC 黑咖啡 (无糖)', 'coffee_tea', '275g', 15),
('UCC Smooth & Clear 無糖黑咖啡', 'UCC Smooth & Clear Black Coffee', 'UCC Smooth & Clear 无糖黑咖啡', 'coffee_tea', '375g', 16),
('UCC 冷泡黑咖啡', 'UCC Cold Brew Black Coffee', 'UCC 冷泡黑咖啡', 'coffee_tea', '500ml', 18),
('UCC 烘焙拿鐵咖啡', 'UCC Roast Latte Coffee', 'UCC 烘焙拿铁咖啡', 'coffee_tea', '450ml', 16),
('UCC 冷萃拿鐵咖啡', 'UCC Cold Brew Latte Coffee', 'UCC 冷萃拿铁咖啡', 'coffee_tea', '500ml', 18),
('UCC 咖啡', 'UCC Coffee', 'UCC 咖啡', 'coffee_tea', '185g', 12),
('UCC 低糖咖啡', 'UCC Low Sugar Coffee', 'UCC 低糖咖啡', 'coffee_tea', '185g', 12),
('朝日極特濃牛奶咖啡', 'Asahi Extra Rich Milk Coffee', '朝日极特浓牛奶咖啡', 'coffee_tea', '370g', 18),
('朝日微糖咖啡', 'Asahi Light Sugar Coffee', '朝日微糖咖啡', 'coffee_tea', '370g', 16),
('朝日黑咖啡', 'Asahi Black Coffee', '朝日黑咖啡', 'coffee_tea', '400ml', 15),
('麒麟 Fire One Day 咖啡 (無糖)', 'Kirin Fire One Day Coffee (Sugar Free)', '麒麟 Fire One Day 咖啡 (无糖)', 'coffee_tea', '600ml', 15),
('麒麟 午後紅茶 - 奶茶', 'Kirin Afternoon Tea Milk Tea', '麒麟 午后红茶 - 奶茶', 'coffee_tea', '500ml', 12),
('麒麟 午後紅茶 奶茶 - 無糖', 'Kirin Afternoon Tea Milk Tea Sugar Free', '麒麟 午后红茶 奶茶 - 无糖', 'coffee_tea', '500ml', 12),
('麒麟 午後之紅茶 - 檸檬茶', 'Kirin Afternoon Tea Lemon Tea', '麒麟 午后之红茶 - 柠檬茶', 'coffee_tea', '500ml', 12),
('麒麟 午後紅茶 - 無糖檸檬茶', 'Kirin Afternoon Tea Sugar Free Lemon Tea', '麒麟 午后红茶 - 无糖柠檬茶', 'coffee_tea', '500ml', 12),
('朝日 濃味十六茶', 'Asahi Rich 16 Tea', '朝日 浓味十六茶', 'coffee_tea', '630ml', 14),
('朝日 無咖啡因十六茶', 'Asahi Caffeine Free 16 Tea', '朝日 无咖啡因十六茶', 'coffee_tea', '660ml', 14),
('伊藤園 無糖綠茶', 'Itoen Sugar Free Green Tea', '伊藤园 无糖绿茶', 'coffee_tea', '500ml', 10),
('伊藤園 無糖濃綠茶', 'Itoen Sugar Free Rich Green Tea', '伊藤园 无糖浓绿茶', 'coffee_tea', '500ml', 12),
('伊藤園 無糖玄米茶', 'Itoen Sugar Free Brown Rice Tea', '伊藤园 无糖玄米茶', 'coffee_tea', '500ml', 10),
('伊藤園 黃金烏龍茶', 'Itoen Golden Oolong Tea', '伊藤园 黄金乌龙茶', 'coffee_tea', '500ml', 12),
('伊右衛門 綠茶', 'Iemon Green Tea', '伊右卫门 绿茶', 'coffee_tea', '600ml', 14),
('伊右衛門 濃味綠茶', 'Iemon Rich Green Tea', '伊右卫门 浓味绿茶', 'coffee_tea', '600ml', 15),
('三得利 烏龍茶', 'Suntory Oolong Tea', '三得利 乌龙茶', 'coffee_tea', '600ml', 12),
('三得利 黑烏龍茶', 'Suntory Black Oolong Tea', '三得利 黑乌龙茶', 'coffee_tea', '1050ml', 18),

-- 飲品 - 運動·能量 (energy)
('寶礦力水特電解質補充飲料', 'Pocari Sweat Electrolyte Drink', '宝矿力水特电解质补充饮料', 'energy', '500ml', 10),
('寶礦力水特 低卡路里電解水飲料', 'Pocari Sweat Low Calorie Electrolyte Drink', '宝矿力水特 低卡路里电解水饮料', 'energy', '500ml', 10),
('水動樂 電解質補充飲品', 'Aquarius Electrolyte Drink', '水动乐 电解质补充饮品', 'energy', '500ml', 9),
('水動樂 零系電解質補充飲品', 'Aquarius Zero Electrolyte Drink', '水动乐 零系电解质补充饮品', 'energy', '500ml', 9),
('HOUSE WELLNESS You C1000 維他命檸檬健康飲料', 'House Wellness You C1000 Vitamin Lemon', 'HOUSE WELLNESS You C1000 维他命柠檬健康饮料', 'energy', '140ml', 12),
('HOUSE WELLNESS You C1000 維他命香橙健康飲料', 'House Wellness You C1000 Vitamin Orange', 'HOUSE WELLNESS You C1000 维他命香橙健康饮料', 'energy', '140ml', 12),
('HOUSE WELLNESS You C1000 維他命蘋果健康飲料', 'House Wellness You C1000 Vitamin Apple', 'HOUSE WELLNESS You C1000 维他命苹果健康饮料', 'energy', '140ml', 12),
('HOUSE WELLNESS You C1000 維他命檸檬健康飲料', 'House Wellness You C1000 Vitamin Lemon', 'HOUSE WELLNESS You C1000 维他命柠檬健康饮料', 'energy', '500ml', 15),
('HOUSE WELLNESS You C1000 維他命香橙健康飲料', 'House Wellness You C1000 Vitamin Orange', 'HOUSE WELLNESS You C1000 维他命香橙健康饮料', 'energy', '500ml', 15),
('RED BULL 能量飲品', 'Red Bull Energy Drink', 'RED BULL 能量饮品', 'energy', '250ml', 18),
('RED BULL 能量飲品', 'Red Bull Energy Drink', 'RED BULL 能量饮品', 'energy', '355ml', 22),
('RED BULL 無糖能量飲品', 'Red Bull Sugar Free Energy Drink', 'RED BULL 无糖能量饮品', 'energy', '250ml', 18),
('RED BULL 蘋果葡萄有汽能量飲品', 'Red Bull Apple Grape Sparkling Energy Drink', 'RED BULL 苹果葡萄有汽能量饮品', 'energy', '250ml', 18),
('RED BULL 柚子碳酸有汽能量飲品', 'Red Bull Yuzu Sparkling Energy Drink', 'RED BULL 柚子碳酸有汽能量饮品', 'energy', '250ml', 18),
('Monster 碳酸能量飲料', 'Monster Energy Drink', 'Monster 碳酸能量饮料', 'energy', '355ml', 20),
('Monster 超越碳酸能量飲料', 'Monster Ultra Energy Drink', 'Monster 超越碳酸能量饮料', 'energy', '355ml', 20),
('Monster 超越幻紫碳酸能量飲料', 'Monster Ultra Violet Energy Drink', 'Monster 超越幻紫碳酸能量饮料', 'energy', '355ml', 20),
('Monster 超越蜜桃閃耀碳酸能量飲料', 'Monster Ultra Peach Energy Drink', 'Monster 超越蜜桃闪耀碳酸能量饮料', 'energy', '355ml', 20),
('Monster 芒果狂歡碳酸能量飲料', 'Monster Mango Loco Energy Drink', 'Monster 芒果狂欢碳酸能量饮料', 'energy', '355ml', 20),
('Monster 澳式檸檬碳酸能量飲料', 'Monster Aussie Lemonade Energy Drink', 'Monster 澳式柠檬碳酸能量饮料', 'energy', '355ml', 20),
('奧樂蜜c維他命碳酸飲品', 'Oronamin C Vitamin Carbonated Drink', '奥乐蜜c维他命碳酸饮品', 'energy', '6 X 120ml', 28),

-- 飲品 - 果汁 (juice)
('野菜生活100 甘筍蔬果汁 (紙盒裝)', 'Yasai Seikatsu 100 Carrot Juice (Carton)', '野菜生活100 甘笋蔬果汁 (纸盒装)', 'juice', '200ml', 12),
('野菜生活100 提子蔬果汁 (紙盒裝)', 'Yasai Seikatsu 100 Grape Juice (Carton)', '野菜生活100 提子蔬果汁 (纸盒装)', 'juice', '200ml', 12),
('野菜生活100 芒果蔬果汁 (紙盒裝)', 'Yasai Seikatsu 100 Mango Juice (Carton)', '野菜生活100 芒果蔬果汁 (纸盒装)', 'juice', '200ml', 12),
('野菜生活100 蘋果蔬果汁 (紙盒裝)', 'Yasai Seikatsu 100 Apple Juice (Carton)', '野菜生活100 苹果蔬果汁 (纸盒装)', 'juice', '200ml', 12),
('野菜一日營 (紙盒裝)', 'Yasai Ichinichi (Carton)', '野菜一日营 (纸盒装)', 'juice', '200ml', 12),
('100% 純正番茄汁 (紙盒裝)', '100% Pure Tomato Juice (Carton)', '100% 纯正番茄汁 (纸盒装)', 'juice', '200ml', 12),
('100% 純正甘筍汁 (紙盒裝)', '100% Pure Carrot Juice (Carton)', '100% 纯正甘笋汁 (纸盒装)', 'juice', '200ml', 12),
('野菜生活100 甘筍蔬果汁 (樽裝)', 'Yasai Seikatsu 100 Carrot Juice (Bottle)', '野菜生活100 甘笋蔬果汁 (樽装)', 'juice', '280ml', 15),
('野菜生活100 提子蔬果汁 (樽裝)', 'Yasai Seikatsu 100 Grape Juice (Bottle)', '野菜生活100 提子蔬果汁 (樽装)', 'juice', '280ml', 15),
('野菜生活100 芒果蔬果汁 (樽裝)', 'Yasai Seikatsu 100 Mango Juice (Bottle)', '野菜生活100 芒果蔬果汁 (樽装)', 'juice', '280ml', 15),
('野菜一日營 (樽裝)', 'Yasai Ichinichi (Bottle)', '野菜一日营 (樽装)', 'juice', '280ml', 15),
('100% 純正番茄汁 (樽裝)', '100% Pure Tomato Juice (Bottle)', '100% 纯正番茄汁 (樽装)', 'juice', '280ml', 15),
('三得利 Natchan 蘋果汁飲料', 'Suntory Natchan Apple Juice', '三得利 Natchan 苹果汁饮料', 'juice', '425ml', 14),
('三得利 Natchan 橙汁飲品', 'Suntory Natchan Orange Juice', '三得利 Natchan 橙汁饮品', 'juice', '160g', 10),
('不二家 NECTAR 白桃果汁', 'Fujiya Nectar White Peach Juice', '不二家 NECTAR 白桃果汁', 'juice', '380g', 22),
('札幌飲料 檸檬酸飲品', 'Sapporo Beverage Lemon Acid Drink', '札幌饮料 柠檬酸饮品', 'juice', '525ml', 12),
('札幌飲料 無糖檸檬酸飲品', 'Sapporo Beverage Sugar Free Lemon Acid Drink', '札幌饮料 无糖柠檬酸饮品', 'juice', '490ml', 12),

-- 飲品 - 碳酸飲料 (soda)
('可口可樂 可樂 (罐裝)', 'Coca-Cola Can', '可口可乐 可乐 (罐装)', 'soda', '350ml', 8),
('可口可樂 檸檬味可口可樂 (高罐裝)', 'Coca-Cola Lemon (Tall Can)', '可口可乐 柠檬味可口可乐 (高罐装)', 'soda', '330ml', 9),
('可口可樂 可樂 (樽裝)', 'Coca-Cola Bottle', '可口可乐 可乐 (樽装)', 'soda', '500ml', 12),
('可口可樂 零系可樂 (樽裝)', 'Coca-Cola Zero (Bottle)', '可口可乐 零系可乐 (樽装)', 'soda', '500ml', 12),
('可口可樂 檸檬味可口可樂 (樽裝)', 'Coca-Cola Lemon (Bottle)', '可口可乐 柠檬味可口可乐 (樽装)', 'soda', '500ml', 12),
('SPRITE 汽水 (樽裝)', 'Sprite Bottle', 'SPRITE 汽水 (樽装)', 'soda', '500ml', 12),
('SCHWEPPES 忌廉梳打 (樽裝)', 'Schweppes Cream Soda (Bottle)', 'SCHWEPPES 忌廉梳打 (樽装)', 'soda', '500ml', 12),
('百事可樂 (日本)', 'Pepsi Cola (Japan)', '百事可乐 (日本)', 'soda', '340ml', 10),
('百事零系可樂 (日本)', 'Pepsi Zero Cola (Japan)', '百事零系可乐 (日本)', 'soda', '340ml', 10),
('百事特別零系可樂 (日本)', 'Pepsi Special Zero Cola (Japan)', '百事特别零系可乐 (日本)', 'soda', '490ml', 12),
('百事生可樂 (日本)', 'Pepsi Nama Cola (Japan)', '百事生可乐 (日本)', 'soda', '600ml', 14),
('百事可樂 零系生可樂 (日本)', 'Pepsi Nama Zero Cola (Japan)', '百事可乐 零系生可乐 (日本)', 'soda', '600ml', 14),
('樂天 忌廉溝鮮奶 (奶類碳酸飲品)', 'Lotte Cream Soda Milk', '乐天 忌廉沟鲜奶 (奶类碳酸饮品)', 'soda', '250ml', 14),
('樂天 零卡忌廉溝鮮奶', 'Lotte Zero Calorie Cream Soda Milk', '乐天 零卡忌廉沟鲜奶', 'soda', '250ml', 14),
('樂天 忌廉溝鮮奶 - 提子味 (碳酸飲品)', 'Lotte Cream Soda Grape', '乐天 忌廉沟鲜奶 - 提子味 (碳酸饮品)', 'soda', '250ml', 14);
