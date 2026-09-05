-- =============================================================
-- 网上订餐系统 (Online Food Ordering System) 数据库脚本
-- 数据库: MySQL 8.0  |  字符集: utf8mb4
-- 执行方式: mysql -u  root -p < food_ordering.sql
-- =============================================================

DROP DATABASE IF EXISTS food_ordering;
CREATE DATABASE food_ordering DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE food_ordering;

-- -------------------------------------------------------------
-- 1. 用户表 t_user
--    角色: customer-顾客 / merchant-商家 / admin-系统管理员
-- -------------------------------------------------------------
CREATE TABLE t_user (
  id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID',
    -- id自增
  username    VARCHAR(50)  NOT NULL UNIQUE COMMENT '用户名(登录账号)',
    -- varchar为可变长度字符串 unique保证了每个用户名不同
  password    VARCHAR(100) NOT NULL COMMENT '密码(MD5加密)',
    -- not null 保证了注册时必须输入用户名和密码
  real_name   VARCHAR(50)  DEFAULT '' COMMENT '真实姓名',
  phone       VARCHAR(20)  DEFAULT '' COMMENT '手机号',
  email       VARCHAR(100) DEFAULT '' COMMENT '邮箱',
  role        VARCHAR(20)  NOT NULL DEFAULT 'customer' COMMENT '角色: customer/merchant/admin',
  status      TINYINT      NOT NULL DEFAULT 1 COMMENT '状态: 1启用 0禁用',
  create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间'
) ENGINE=InnoDB COMMENT='用户表';

-- -------------------------------------------------------------
-- 2. 商家信息表 t_merchant
--    顾客注册时选择"商家入驻"并填写店铺信息，等待系统管理员审核
-- -------------------------------------------------------------
CREATE TABLE t_merchant (
  id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '商家ID',
  user_id     INT          NOT NULL COMMENT '关联用户ID',
  shop_name   VARCHAR(100) NOT NULL COMMENT '店铺名称',
  shop_desc   VARCHAR(500) DEFAULT '' COMMENT '店铺简介',
  address     VARCHAR(200) DEFAULT '' COMMENT '店铺地址',
  license_no  VARCHAR(50)  DEFAULT '' COMMENT '营业执照号',
  status      TINYINT      NOT NULL DEFAULT 0 COMMENT '审核状态: 0待审核 1通过 2驳回',
  create_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '入驻申请时间',
  CONSTRAINT fk_merchant_user FOREIGN KEY (user_id) REFERENCES t_user(id)
    --constraint外键约束，fk_merchant_user是这个约束的名字
) ENGINE=InnoDB COMMENT='商家信息表';

-- -------------------------------------------------------------
-- 3. 菜品分类表 t_category
-- -------------------------------------------------------------
CREATE TABLE t_category (
  id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '分类ID',
  name        VARCHAR(50) NOT NULL COMMENT '分类名称',
  sort        INT DEFAULT 0 COMMENT '排序号',
    -- sort控制分类在前台页面的展示顺序
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB COMMENT='菜品分类表';

-- -------------------------------------------------------------
-- 4. 菜品表 t_dish
-- -------------------------------------------------------------
CREATE TABLE t_dish (
  id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '菜品ID',
  merchant_id INT NOT NULL COMMENT '所属商家ID',
  category_id INT NOT NULL COMMENT '分类ID',
  name        VARCHAR(100) NOT NULL COMMENT '菜品名称',
  description VARCHAR(500) DEFAULT '' COMMENT '菜品描述',
  price       DECIMAL(10,2) NOT NULL COMMENT '价格',
    --decimal(M,D) M为有效数字位数，D为小数点后占几位，不会产生浮点误差，专门存金额、价格，而不用float/double
  image       VARCHAR(200) DEFAULT '' COMMENT '图片路径',
  status      TINYINT NOT NULL DEFAULT 1 COMMENT '状态: 1上架 0下架',
  sales       INT DEFAULT 0 COMMENT '销量',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  CONSTRAINT fk_dish_merchant FOREIGN KEY (merchant_id) REFERENCES t_merchant(id),
  CONSTRAINT fk_dish_category FOREIGN KEY (category_id) REFERENCES t_category(id)
) ENGINE=InnoDB COMMENT='菜品表';

-- -------------------------------------------------------------
-- 5. 购物车表 t_cart
-- -------------------------------------------------------------
CREATE TABLE t_cart (
  id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '购物车项ID',
  user_id     INT NOT NULL COMMENT '用户ID',
  dish_id     INT NOT NULL COMMENT '菜品ID',
  quantity    INT NOT NULL DEFAULT 1 COMMENT '数量',
  add_time    DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES t_user(id),
  CONSTRAINT fk_cart_dish FOREIGN KEY (dish_id) REFERENCES t_dish(id)
) ENGINE=InnoDB COMMENT='购物车表';

-- -------------------------------------------------------------
-- 6. 订单表 t_order
--    状态: 0待支付 1待接单 2制作中 3配送中 4已完成 5已取消
-- -------------------------------------------------------------
CREATE TABLE t_order (
  id           INT AUTO_INCREMENT PRIMARY KEY COMMENT '订单ID',
  order_no     VARCHAR(40) NOT NULL UNIQUE COMMENT '订单编号',
  user_id      INT NOT NULL COMMENT '下单用户ID',
  merchant_id  INT NOT NULL COMMENT '商家ID',
  total_amount DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
  status       TINYINT NOT NULL DEFAULT 0 COMMENT '订单状态',
  address      VARCHAR(200) DEFAULT '' COMMENT '配送地址',
  phone        VARCHAR(20)  DEFAULT '' COMMENT '联系电话',
  remark       VARCHAR(200) DEFAULT '' COMMENT '订单备注',
  create_time  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  pay_time     DATETIME DEFAULT NULL COMMENT '支付时间',
  finish_time  DATETIME DEFAULT NULL COMMENT '完成时间',
  CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES t_user(id),
  CONSTRAINT fk_order_merchant FOREIGN KEY (merchant_id) REFERENCES t_merchant(id)
) ENGINE=InnoDB COMMENT='订单表';

-- -------------------------------------------------------------
-- 7. 订单明细表 t_order_item
-- -------------------------------------------------------------
CREATE TABLE t_order_item (
  id         INT AUTO_INCREMENT PRIMARY KEY COMMENT '明细ID',
  order_id   INT NOT NULL COMMENT '订单ID',
  dish_id    INT NOT NULL COMMENT '菜品ID',
  dish_name  VARCHAR(100) NOT NULL COMMENT '菜品名称(快照)',
  price      DECIMAL(10,2) NOT NULL COMMENT '单价(快照)',
  quantity   INT NOT NULL COMMENT '数量',
  subtotal   DECIMAL(10,2) NOT NULL COMMENT '小计',
  CONSTRAINT fk_item_order FOREIGN KEY (order_id) REFERENCES t_order(id)
) ENGINE=InnoDB COMMENT='订单明细表';

-- -------------------------------------------------------------
-- 8. 评价表 t_review
-- -------------------------------------------------------------
CREATE TABLE t_review (
  id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '评价ID',
  order_id    INT NOT NULL COMMENT '订单ID',
  user_id     INT NOT NULL COMMENT '评价用户ID',
  merchant_id INT NOT NULL COMMENT '商家ID',
  dish_id     INT NOT NULL COMMENT '菜品ID',
  rating      TINYINT NOT NULL DEFAULT 5 COMMENT '评分 1-5',
  content     VARCHAR(500) DEFAULT '' COMMENT '评价内容',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '评价时间',
  CONSTRAINT fk_review_order FOREIGN KEY (order_id) REFERENCES t_order(id),
  CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES t_user(id)
) ENGINE=InnoDB COMMENT='评价表';

-- -------------------------------------------------------------
-- 9. 公告表 t_announcement
-- -------------------------------------------------------------
CREATE TABLE t_announcement (
  id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '公告ID',
  title       VARCHAR(100) NOT NULL COMMENT '公告标题',
  content     VARCHAR(1000) DEFAULT '' COMMENT '公告内容',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间'
) ENGINE=InnoDB COMMENT='公告表';

-- =============================================================
-- 初始化数据
-- 密码统一为 123456 (MD5: e10adc3949ba59abbe56e057f20f883e)
-- =============================================================
INSERT INTO t_user (id, username, password, real_name, phone, email, role, status) VALUES
(1, 'admin',   'e10adc3949ba59abbe56e057f20f883e', '系统管理员', '13800000001', 'admin@food.com', 'admin', 1),
(2, 'zhangsan','e10adc3949ba59abbe56e057f20f883e', '张三',       '13800000002', 'zs@food.com',    'customer', 1),
(3, 'lisi',    'e10adc3949ba59abbe56e057f20f883e', '李四',       '13800000003', 'ls@food.com',    'customer', 1),
(4, 'wangwu',  'e10adc3949ba59abbe56e057f20f883e', '王五',       '13800000004', 'ww@food.com',    'customer', 1),
(5, 'hualixuan', 'e10adc3949ba59abbe56e057f20f883e', '华利轩老板', '13800000005', 'hlx@food.com',   'merchant', 1),
(6, 'xiangmanlou', 'e10adc3949ba59abbe56e057f20f883e', '香满楼老板', '13800000006', 'xml@food.com',   'merchant', 1),
(7, 'chuanweiguan', 'e10adc3949ba59abbe56e057f20f883e', '川味馆老板', '13800000007', 'cwg@food.com',  'merchant', 1);

INSERT INTO t_merchant (id, user_id, shop_name, shop_desc, address, license_no, status) VALUES
(1, 5, '华利轩餐厅', '主打家常菜与商务套餐，口味地道，出餐快', '南京市玄武区中山路100号', 'NJ9132A001', 1),
(2, 6, '香满楼',     '正宗湘菜，辣味十足，深受好评',         '南京市秦淮区夫子庙大街50号', 'NJ9132A002', 1),
(3, 7, '川味馆',     '麻辣川菜，地道重庆火锅风味',           '南京市鼓楼区中央路200号', 'NJ9132A003', 1);

INSERT INTO t_category (id, name, sort) VALUES
(1, '热销推荐', 1),
(2, '家常菜',   2),
(3, '川湘菜',   3),
(4, '特色小吃', 4),
(5, '饮品甜点', 5),
(6, '商务套餐', 6);

INSERT INTO t_dish (id, merchant_id, category_id, name, description, price, image, status, sales) VALUES
(1, 1, 1, '招牌红烧肉',   '肥而不腻，入口即化，精选五花肉慢炖两小时', 28.00, 'images/dish/rst1.jpg', 1, 156),
(2, 1, 1, '糖醋里脊',     '酸甜可口，外酥里嫩', 22.00, 'images/dish/tclj.jpg', 1, 132),
(3, 1, 2, '番茄炒蛋',     '家常经典，营养美味', 12.00, 'images/dish/fqcd.jpg', 1, 210),
(4, 1, 2, '青椒土豆丝',   '清脆爽口，下饭神器', 10.00, 'images/dish/qjtds.jpg', 1, 188),
(5, 1, 6, '商务套餐A',    '红烧肉+时蔬+米饭+例汤', 25.00, 'images/dish/swta.jpg', 1, 96),
(6, 1, 6, '商务套餐B',    '鸡腿饭+小菜+饮料', 22.00, 'images/dish/swtb.jpg', 1, 78),
(7, 2, 3, '剁椒鱼头',     '湘菜经典，鲜辣过瘾', 48.00, 'images/dish/djyt.jpg', 1, 88),
(8, 2, 3, '辣椒炒肉',     '湘味十足，米饭杀手', 26.00, 'images/dish/ljcr.jpg', 1, 142),
(9, 2, 1, '湘味腊肉',     '烟熏腊肉，越嚼越香', 32.00, 'images/dish/xwlr.jpg', 1, 66),
(10, 3, 3, '麻婆豆腐',    '麻辣鲜香，滑嫩爽口', 16.00, 'images/dish/mpdf.jpg', 1, 175),
(11, 3, 3, '水煮牛肉',    '麻辣重口，牛肉嫩滑', 38.00, 'images/dish/sznr.jpg', 1, 59),
(12, 3, 4, '重庆小面',    '麻辣过瘾，面条筋道', 12.00, 'images/dish/zqxm.jpg', 1, 201),
(13, 1, 4, '手工水饺',    '皮薄馅大，现包现煮', 15.00, 'images/dish/sgsj.jpg', 1, 167),
(14, 2, 5, '红豆沙',      '香甜绵密，饭后甜点', 8.00,  'images/dish/hds.jpg', 1, 120),
(15, 2, 5, '杨枝甘露',    '港式经典饮品', 13.00, 'images/dish/yzgl.jpg', 1, 95);

-- 示例订单 (演示用)
INSERT INTO t_order (id, order_no, user_id, merchant_id, total_amount, status, address, phone, remark, create_time, pay_time, finish_time) VALUES
(1, '20260902001', 2, 1, 62.00, 4, '南京市玄武区中山路100号1栋', '13800000002', '不要辣', '2026-09-01 11:30:00', '2026-09-01 11:30:20', '2026-09-01 12:05:00'),
(2, '20260902002', 3, 2, 48.00, 4, '南京市秦淮区夫子庙大街50号', '13800000003', '', '2026-09-01 12:10:00', '2026-09-01 12:10:15', '2026-09-01 12:45:00'),
(3, '20260902003', 2, 3, 28.00, 1, '南京市玄武区中山路100号1栋', '13800000002', '多加香菜', '2026-09-02 09:20:00', '2026-09-02 09:20:10', NULL);

INSERT INTO t_order_item (order_id, dish_id, dish_name, price, quantity, subtotal) VALUES
(1, 1, '招牌红烧肉', 28.00, 1, 28.00),
(1, 2, '糖醋里脊', 22.00, 1, 22.00),
(1, 6, '商务套餐B', 12.00, 1, 12.00),
(2, 7, '剁椒鱼头', 48.00, 1, 48.00),
(3, 12, '重庆小面', 12.00, 1, 12.00),
(3, 10, '麻婆豆腐', 16.00, 1, 16.00);

INSERT INTO t_review (id, order_id, user_id, merchant_id, dish_id, rating, content, create_time) VALUES
(1, 1, 2, 1, 1, 5, '红烧肉非常好吃，配送也很快！', '2026-09-03 20:51:17'),
(2, 2, 3, 2, 7, 4, '剁椒鱼头很正宗，就是有点辣。', '2026-09-03 20:51:17'),
(3, 2, 3, 1, 1, 5, '红烧肉肥而不腻，入口即化，甜咸适中，配米饭绝了！', '2026-08-21 10:07:00'),
(4, 3, 4, 1, 1, 4, '肉炖得很烂，味道很入味，就是分量稍微有点少，总体不错。', '2026-08-22 11:14:00'),
(5, 1, 2, 1, 1, 5, '第二次点了，一如既往地好吃，包装也很干净。', '2026-08-23 12:21:00'),
(6, 2, 3, 1, 1, 4, '味道不错，但稍微偏甜了一点，喜欢咸口的可以备注少糖。', '2026-08-24 13:28:00'),
(7, 3, 4, 1, 2, 5, '糖醋里脊外酥里嫩，酸甜开胃，孩子特别喜欢。', '2026-08-25 14:35:00'),
(8, 1, 2, 1, 2, 5, '酱汁浓稠，味道正宗，配送及时，好评！', '2026-08-26 15:42:00'),
(9, 2, 3, 1, 2, 4, '不错的下饭菜，就是糖放得有点多，其他都很好。', '2026-08-27 16:49:00'),
(10, 3, 4, 1, 2, 4, '里脊肉很嫩，酸甜比例刚好，下次还会回购。', '2026-08-20 17:56:00'),
(11, 1, 2, 1, 3, 5, '家常味道，番茄汁水充足，鸡蛋嫩滑，非常下饭。', '2026-08-21 18:03:00'),
(12, 2, 3, 1, 3, 5, '性价比很高，适合上班族，分量足味道好。', '2026-08-22 09:10:00'),
(13, 3, 4, 1, 3, 4, '味道中规中矩，就是油稍微多了点，整体还行。', '2026-08-23 10:17:00'),
(14, 1, 2, 1, 3, 4, '番茄新鲜，酸甜可口，配米饭特别棒。', '2026-08-24 11:24:00'),
(15, 2, 3, 1, 4, 5, '土豆丝切得很细，爽脆可口，酸辣适中，很开胃。', '2026-08-25 12:31:00'),
(16, 3, 4, 1, 4, 4, '清爽不油腻，价格实惠，值得回购。', '2026-08-26 13:38:00'),
(17, 1, 2, 1, 4, 4, '味道不错，要是再多点辣就更好了。', '2026-08-27 14:45:00'),
(18, 2, 3, 1, 4, 5, '家常口味，下饭神器，配送速度快。', '2026-08-20 15:52:00'),
(19, 3, 4, 1, 5, 5, '套餐搭配合理，荤素都有，分量足，吃饱没问题。', '2026-08-21 16:59:00'),
(20, 1, 2, 1, 5, 4, '中午点商务套餐很方便，出餐快，味道也不错。', '2026-08-22 17:06:00'),
(21, 2, 3, 1, 5, 4, '米饭软硬适中，菜色新鲜，性价比高。', '2026-08-23 18:13:00'),
(22, 3, 4, 1, 5, 4, '整体不错，就是希望配菜能再多一种。', '2026-08-24 09:20:00'),
(23, 1, 2, 1, 6, 5, '套餐很丰盛，主食配菜齐全，适合工作餐。', '2026-08-25 10:27:00'),
(24, 2, 3, 1, 6, 4, '味道不错，就是米饭稍微有点硬。', '2026-08-26 11:34:00'),
(25, 3, 4, 1, 6, 5, '商务餐方便快捷，菜品新鲜，推荐。', '2026-08-27 12:41:00'),
(26, 1, 2, 1, 6, 4, '分量足够，价格合理，下次还点这家。', '2026-08-20 13:48:00'),
(27, 2, 3, 2, 7, 5, '剁椒鱼头很正宗，鱼肉鲜嫩，辣得过瘾！', '2026-08-21 14:55:00'),
(28, 3, 4, 2, 7, 4, '很入味，就是对我来说太辣了，能吃辣的一定喜欢。', '2026-08-22 15:02:00'),
(29, 1, 2, 2, 7, 5, '鱼头新鲜，剁椒香辣开胃，好吃！', '2026-08-23 16:09:00'),
(30, 2, 3, 2, 7, 4, '味道不错，就是汤汁有点咸，其他都满意。', '2026-08-24 17:16:00'),
(31, 3, 4, 2, 8, 5, '辣椒炒肉锅气十足，五花肉肥瘦相间，下饭一绝。', '2026-08-25 18:23:00'),
(32, 1, 2, 2, 8, 5, '香辣可口，很湖南风味，推荐给爱吃辣的朋友。', '2026-08-26 09:30:00'),
(33, 2, 3, 2, 8, 4, '味道不错，就是稍微有点油，整体满意。', '2026-08-27 10:37:00'),
(34, 3, 4, 2, 8, 4, '肉片炒得刚刚好，辣椒提香，非常下饭。', '2026-08-20 11:44:00'),
(35, 1, 2, 2, 9, 5, '腊肉烟熏味浓，肥而不腻，很地道的湘味。', '2026-08-21 12:51:00'),
(36, 2, 3, 2, 9, 5, '腊肉切得薄，炒得很香，配饭很合适。', '2026-08-22 13:58:00'),
(37, 3, 4, 2, 9, 4, '味道不错，但腊肉有点咸，建议少放点盐。', '2026-08-23 14:05:00'),
(38, 1, 2, 2, 9, 4, '很下饭，价格实惠，就是配送有点慢。', '2026-08-24 15:12:00'),
(39, 2, 3, 3, 10, 5, '麻婆豆腐麻辣鲜香，豆腐嫩滑，入口即化，绝了！', '2026-08-25 16:19:00'),
(40, 3, 4, 3, 10, 4, '很正宗，花椒味十足，就是有点辣。', '2026-08-26 17:26:00'),
(41, 1, 2, 3, 10, 5, '豆腐很嫩，酱汁浓稠，下饭神器。', '2026-08-27 18:33:00'),
(42, 2, 3, 3, 10, 4, '味道不错，喜欢麻的应该会很喜欢。', '2026-08-20 09:40:00'),
(43, 3, 4, 3, 11, 5, '水煮牛肉片很嫩，麻辣过瘾，配菜也很丰富。', '2026-08-21 10:47:00'),
(44, 1, 2, 3, 11, 5, '牛肉量足，味道正宗，红油香辣，推荐！', '2026-08-22 11:54:00'),
(45, 2, 3, 3, 11, 4, '味道很好，就是对我来说偏辣，能吃辣的放心点。', '2026-08-23 12:01:00'),
(46, 3, 4, 3, 11, 4, '分量实在，麻辣鲜香，性价比高。', '2026-08-24 13:08:00'),
(47, 1, 2, 3, 12, 5, '重庆小面劲道爽滑，麻辣汤底很香，正宗！', '2026-08-25 14:15:00'),
(48, 2, 3, 3, 12, 5, '面很筋道，调料地道，价格实惠。', '2026-08-26 15:22:00'),
(49, 3, 4, 3, 12, 4, '好吃是好吃，就是汤稍微有点油。', '2026-08-27 16:29:00'),
(50, 1, 2, 3, 12, 5, '夜宵首选，麻辣过瘾，出餐快。', '2026-08-20 17:36:00'),
(51, 2, 3, 1, 13, 5, '手工水饺皮薄馅大，鲜嫩多汁，好吃！', '2026-08-21 18:43:00'),
(52, 3, 4, 1, 13, 5, '饺子是现包的，口感新鲜，蘸醋绝配。', '2026-08-22 09:50:00'),
(53, 1, 2, 1, 13, 4, '味道不错，就是希望馅料种类能多一点。', '2026-08-23 10:57:00'),
(54, 2, 3, 1, 13, 4, '个头大，馅料足，很实惠。', '2026-08-24 11:04:00'),
(55, 3, 4, 2, 14, 5, '红豆沙细腻绵密，甜度刚好，饭后甜点不错。', '2026-08-25 12:11:00'),
(56, 1, 2, 2, 14, 4, '红豆煮得软烂，口感顺滑，很好喝。', '2026-08-26 13:18:00'),
(57, 2, 3, 2, 14, 4, '甜度适中，分量足，性价比高。', '2026-08-27 14:25:00'),
(58, 3, 4, 2, 14, 5, '很解腻，配甜品套餐很合适。', '2026-08-20 15:32:00'),
(59, 1, 2, 2, 15, 5, '杨枝甘露芒果味浓郁，西柚微苦回甘，很正宗。', '2026-08-21 16:39:00'),
(60, 2, 3, 2, 15, 5, '料很足，芒果新鲜，椰奶味香浓，推荐！', '2026-08-22 17:46:00'),
(61, 3, 4, 2, 15, 4, '好喝是好喝，就是稍微有点甜。', '2026-08-23 18:53:00'),
(62, 1, 2, 2, 15, 5, '冰冰凉凉很解暑，夏天必点。', '2026-08-24 09:00:00');

INSERT INTO t_announcement (title, content) VALUES
('欢迎使用网上订餐系统', '本系统支持在线浏览菜品、加入购物车、提交订单、模拟在线支付，支持商家入驻与订单管理，祝您用餐愉快！'),
('支付说明', '本课程设计项目采用模拟支付，提交订单后点击"立即支付"即可完成支付流程，不会产生真实扣款。');
