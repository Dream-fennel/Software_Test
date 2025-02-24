# 项目实战练习
# 用户表:tp_users,商品表:tp_goods, 购物车表:tp_cart 

# 商品表相关练习：tp_goods
# 查询商品信息
SELECT * FROM tp_goods;

# 查询商品价格为1999.00的商品信息
SELECT * FROM tp_goods WHERE shop_price=1999.00;

# 查询商品价格大于1999.00的商品信息
SELECT * FROM tp_goods WHERE shop_price>1999.00;

# 查询商品价格小于1999.00的商品信息
SELECT * FROM tp_goods WHERE shop_price<1999.00;

# 查询商品价格1000到2000的商品信息
SELECT * FROM tp_goods 
WHERE shop_price>=1000.00 AND shop_price<=2000.00;

SELECT * FROM tp_goods 
WHERE shop_price BETWEEN 1000.00 AND 2000.00;

# 查询商品价格为1999.00,2999.00,3999.00的商品信息
SELECT * FROM tp_goods 
WHERE shop_price IN(1999.00,2999.00,3999.00);

# 查询商品名称包含“华为”的商品信息
SELECT * FROM tp_goods WHERE goods_name LIKE '%华为%';

# 查询商品名称包含“华为”的商品数量
SELECT COUNT(*) FROM tp_goods WHERE goods_name LIKE '%华为%';

# 查询商品价格最高的商品信息
SELECT MAX(shop_price) FROM tp_goods; 

# 查询商品价格最低的商品信息
SELECT MIN(shop_price) FROM tp_goods; 

# 查询每个价格的商品数量
SELECT COUNT(*),shop_price FROM tp_goods GROUP BY shop_price;

# 查询每个商品分类以及商品数量
SELECT COUNT(*),cat_id FROM tp_goods GROUP BY cat_id;

# 查询商品数量大于6的商品分类以及商品数量
SELECT COUNT(*),cat_id FROM tp_goods
GROUP BY cat_id
HAVING COUNT(*)>6;

# 查询商品价格，要求：按照商品价格进行升序/降序排序。
SELECT shop_price FROM tp_goods ORDER BY shop_price ASC;
SELECT shop_price FROM tp_goods ORDER BY shop_price DESC;

# 查询商品价格最高的商品信息
SELECT * FROM tp_goods ORDER BY shop_price DESC LIMIT 1;

# 查询商品价格最低的商品信息
SELECT * FROM tp_goods ORDER BY shop_price ASC LIMIT 1;

# 查询商品价格最高的前10条商品信息
SELECT * FROM tp_goods ORDER BY shop_price DESC LIMIT 10;

# 查询商品价格最低的前10条商品信息
SELECT * FROM tp_goods ORDER BY shop_price ASC LIMIT 10;

# 查询商品价格最高的第10到第35条商品信息
SELECT * FROM tp_goods ORDER BY shop_price DESC LIMIT 9,26;

# 每页显示6条商品，查询第3页的商品信息
SELECT * FROM tp_goods LIMIT 12,6;


# 用户表相关练习：tp_users
# 查询用户表信息
SELECT * FROM tp_users;

# 查询手机号为13012345678的用户信息
SELECT * FROM tp_users WHERE mobile='13012345678';

# 查询用户人数
SELECT COUNT(*) FROM tp_users;

# 查询女用户信息（0 保密 1 男 2 女）
SELECT * FROM tp_users WHERE sex=2;

# 查询女用户人数
SELECT COUNT(*) FROM tp_users WHERE sex=2;

# 查询男用户信息（0 保密 1 男 2 女）
SELECT * FROM tp_users WHERE sex=1;

# 查询男用户人数
SELECT COUNT(*) FROM tp_users WHERE sex=1;

# 查询用户余额
SELECT user_money FROM tp_users;

# 查询用户余额不为0的用户信息
SELECT user_money FROM tp_users WHERE user_money>0;

# 查询会员等级
SELECT LEVEL FROM tp_users;

# 查询每个会员等级的人数以及对应的会员等级
SELECT COUNT(*),LEVEL FROM tp_users GROUP BY LEVEL;


# 购物车表相关练习：tp_cart
# 查询购物车信息
SELECT * FROM tp_cart;

# 查询购物车中的商品id、商品名称、本店价格、用户id
SELECT goods_id,goods_name,goods_price,user_id
FROM tp_cart;

# 查询购物车中的商品id、商品名称、本店价格
# 以及对应用户的手机号码
SELECT goods_id,goods_name,goods_price,mobile
FROM tp_cart INNER JOIN tp_users
ON tp_cart.`user_id`=tp_users.`user_id`;

# 查询购物车表中手机号为18836306318
# 的商品id、商品名称、本店价格、手机号码
SELECT goods_id,goods_name,goods_price,mobile
FROM tp_cart INNER JOIN tp_users
ON tp_cart.`user_id`=tp_users.`user_id`
WHERE mobile='18836306318';

# 对比商品表中的商品名称、本店价格
# 与购物车表中的商品名称、本店价格
SELECT g.goods_name 商品表中的商品名称,
 g.shop_price 商品表中的本店价格,
 c.goods_name 购物车表中的商品名称,
 goods_price 购物车表中的本店价格
FROM tp_goods AS g INNER JOIN tp_cart c
ON g.`goods_id`=c.`goods_id`;


# 修改、删除练习：商品表：tp_goods 与 用户表: tp_users
 
/*
警告：
 1.在对原始表数据进行操作(增删改)时，建议先备份原始表数据；
 2.对原始表数据进行操作(增删改)并验证；
 3.清空原始表数据；
 4.将备份表数据还原到原始表中;
 5.删除备份表。
*/

# 备份商品表：tp_goods 数据到 tp_goods_copy表
CREATE TABLE tp_goods_copy SELECT * FROM tp_goods;

# 清空tp_goods表数据
TRUNCATE tp_goods;

# 把tp_goods_copy表数据插入到tp_goods表中
INSERT INTO tp_goods SELECT * FROM tp_goods_copy;

# 删除tp_goods_copy表
DROP TABLE tp_goods_copy;


# 备份用户表：tp_users 数据到 tp_users_copy表
CREATE TABLE tp_users_copy SELECT * FROM tp_users;

# 清空tp_users表数据
TRUNCATE tp_users;

# 把tp_users_copy表数据插入到tp_users表中
INSERT INTO tp_users SELECT * FROM tp_users_copy;

# 删除tp_users_copy表
DROP TABLE tp_users_copy;



# 商品表练习：
# 查询商品编号，商品名称，本店价格
SELECT goods_id,goods_name,shop_price FROM tp_goods;

# 查询商品编号为90的商品编号，商品名称，本店价格
SELECT goods_id,goods_name,shop_price FROM tp_goods WHERE goods_id=90;

# 把商品编号为90的本店价格修改0.01元
UPDATE tp_goods SET shop_price=0.01 WHERE goods_id=90;

# 删除商品编号为90的商品
DELETE FROM tp_goods WHERE goods_id=90;



# 用户表练习：
# 查询用户表信息
SELECT * FROM tp_users;

# 查询手机号为13012345678的用户信息
SELECT * FROM tp_users WHERE mobile='13012345678';

# 把手机号为13012345678的用户手机号修改为13012345688
UPDATE tp_users SET mobile='13012345688' WHERE mobile='13012345678';

# 查询手机号为13012345688的用户信息
SELECT * FROM tp_users WHERE mobile='13012345688';

# 删除手机号为13012345688的用户信息
DELETE FROM tp_users WHERE mobile='13012345688';




# 订单表练习：tp_order
# 查看订单表信息
SELECT * FROM tp_order;

# 查看订单id、用户id、下单单时间、支付时间信息
SELECT order_id,user_id,add_time,pay_time
FROM tp_order;

SELECT order_id,user_id,
 FROM_UNIXTIME(add_time,'%Y-%m-%d %H:%i:%s'),
 FROM_UNIXTIME(pay_time,'%Y-%m-%d %H:%i:%s')
FROM tp_order;

# 查看下了2单以上的用户id和下单数量
SELECT user_id,COUNT(*)
FROM tp_order
WHERE pay_time>0
GROUP BY user_id
HAVING COUNT(*)>1;

# 进阶：如何查2016-05-02下单的数量呢？
SELECT COUNT(*)
FROM tp_order
WHERE pay_time BETWEEN UNIX_TIMESTAMP('2016-05-02 00:00:00')
AND UNIX_TIMESTAMP('2016-05-02 23:59:59');

SELECT UNIX_TIMESTAMP('2016-05-02 00:00:00');  # 1462118400
SELECT UNIX_TIMESTAMP('2016-05-02 23:59:59');  # 1462204799
SELECT COUNT(*)
FROM tp_order
WHERE pay_time BETWEEN 1462118400 AND 1462204799;


















