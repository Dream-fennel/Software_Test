/*
单表查询：
 查询的数据来源于一个表中。
多表查询：
 查询的数据来源于多个表中。
 
连表分类：
 内连接：等值连接，非等值连接，自连接。
 外连接：左外连接，右外连接，全外连接。
 交叉连接：
*/
/*
内连接：
 返回符合连接条件以及查询条件的结果集。
  连接条件：on命令后的内容；
  查询条件：select命令后的内容。
 
等值语法格式：
 select * 
 from 表A [inner] join 表B on 表A.列=表B.列;
 
 注意事项：
  inner 可以省略；
  可以给表起别名；
  单此SQL语句中需要使用表名的地方，必须使用别名；
  若多个表中有相同的字段名时，前面需用表名区别；
   如：students.name 学生表.姓名；
  表名位置不限制，可以调换；
  on后面的连接条件，不要求字段名一致，但必须值的逻辑意义一致；
  多个表连表时，先把其中两个表连表，再去连下一个表，一次类推。
*/
/*
如何判断连接条件？（on命令后面怎么写？）
 第一种：
  第一步：跟人理解两个表中是哪个字段一致？(学生表与班级表)
	如：学生表的班级编号=班级表的班级编号
  第二步：选中表-->右键-->改变表，找每个字段的注释？
  第三步：书写on命令后的代码即可。
	如：students.classid=class.id
 第二种：
  第一步：执行代码：show create table 表名；
  第二步：复制查询结果内容；
  第三步：找到references（参考）前后的字段，
	如 classid references class(id)
	这就表示classid这一列的值参考的是class表中(id)列的值。
  第四步：书写ON命令后的代码即可。
	如：students.classid=class.id
*/	
# 分析思路
# 第一步：确定查询内容（）
# 第二步：确定数据源（）
# 第三步：确定原始数据筛选条件（）
# 第四步：确定分组字段（）
# 第五步：确定分组后统计的数据筛选条件（）
# 第六步：确定排序字段以及排序方式（）
# 第七步：确定查询条数（）

# 查询学生姓名
# 第一步：确定查询内容（学生姓名）
SELECT *
# 第二步：确定数据源（学生表）
FROM students;

# 查询学生姓名以及所在班级名称
# 第一步：确定查询内容（学生姓名，班级名称）
SELECT students.name,class.name
# 第二步：确定数据源（学生表，班级表）
FROM students INNER JOIN class
# 学生表的班级编号=班级表的班级编号
ON students.classid=class.id;

SHOW CREATE TABLE students;

CREATE TABLE `students` (
  `id` INT(11) NOT NULL COMMENT '学生编号',
  `name` VARCHAR(30) NOT NULL COMMENT '学生姓名',
  `sex` CHAR(1) DEFAULT '男' COMMENT '性别',
  `age` INT(11) DEFAULT NULL COMMENT '年龄',
  `birthdate` DATE DEFAULT NULL COMMENT '出生日期',
  `mobile` CHAR(11) DEFAULT NULL COMMENT '手机号',
  `classid` INT(11) DEFAULT NULL COMMENT '班级编号',
  `locationid` INT(11) DEFAULT NULL COMMENT '地址编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile` (`mobile`),
  KEY `classid` (`classid`),
  KEY `waijian` (`locationid`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`classid`) REFERENCES `class` (`id`),
  CONSTRAINT `waijian` FOREIGN KEY (`locationid`) REFERENCES `locations` (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8


/*
非等值连接:
 查询的结果为表1里某字段里的数据在表2里对应字段的等级范围。

语法格式:
 select * 
 from 表A [inner]  join表B 
 On  表A.列 bewteen 表B.列 and 表B.列; 
*/
# 查询学生的年龄以及年龄称呼
SELECT age,level.`name`
FROM students INNER JOIN LEVEL
ON age BETWEEN low_age AND high_age;

/*
自连接 
 把一个表当两个表来使用。 
 注意：必须起别名，否则无法区分。
语法格式: 
 select * 
 from 表1 AS 别名1 [inner]  join 表1 AS 别名2 
 On别名1 .列 = 别名2.列; 
*/
# 查询地址名称以及上级地址名称
SELECT loca.name AS 地址名称,locb.name AS 上级地址名称
FROM locations AS loca INNER JOIN locations AS locb
ON loca.upid=locb.id;


/*
外连接
 外连接不但返回符合连接和查询条件的数据行，
 还返回不符合连接条件，但符合查询条件的数据行。
 
左外连接语法格式：(左表的全部内容)
 select * 
 from 表A left [outer] join 表B
 on 表A.列=表B.列;
 
右外连接语法格式：（右表的全部内容）
 select * 
 from 表A right [outer] join 表B
 on 表A.列=表B.列;
 
注意事项：
1.主从表：（位置不能随意调换）
  左外连接时，左表为主表，右表为从表；
  右外连接时，右表为主表，左表为从表。
2.查询的结果集：
  主表中的全部内容+从表中能匹配到的内容+从表中匹配不到的内容以null填充。
3.语法：
  outer可以省略不写。
4.如何判断使用内连接还是外连接呢？
  内连接：通常需求为肯定句式；
  外连接：通常需求为否定句式。
	  还有就是需求中有明确表达查询某个表的全部数据。
5.如何判断使用左外连接还是右外连接呢？
  第一步：先判断主从表
	I：通常否定词后面的表就是从表，另一个表为主表。
	II:通常查哪个表的全部数据，哪个表就是主表，另一个表为从表。
  第二步：若把主表放在左表，就用左外连接；
	  若把主表放在右表，就用右外连接。
6.如何判断筛选条件？
  通常筛选从表的主键值为空。
*/
/*
面试： 
 内连接与外连接的区别？
  1.语法不同：
	内连接用inner join 命令；
	外连接用left/right outer join 命令。
  2.查询的内容不同：
	内连接查询的是两个表都能匹配到的数据；
	外连接查询的是主表中的全部内容
	 +从表中能匹配到的内容+从表中匹配不到的内容以null填充。
	 
 左外连接与右外连接的区别？
  1.语法不同：
	左外连接使用left outer join 命令；
	右外连接使用right outer join 命令。
  2.主从表位置不同：
	左外连接主表在左边，从表在右边；
	右外连接主表在右边，从表在左边。 
*/
SELECT class.`name`,students.`name`
FROM class LEFT OUTER JOIN students
ON class.`id`=students.`classid`;


# 查询班级名称和对应的学生姓名(内连接)
SELECT class.`name`,students.`name`
FROM class INNER JOIN students
ON class.`id`=students.`classid`;

# 查询所有班级名称和对应的学生姓名(左外连接)
SELECT class.`name`,students.`name`
FROM class LEFT OUTER JOIN students
ON class.`id`=students.`classid`;

# 查询没有学生的班级名称(左外连接)
SELECT class.`name`
FROM class LEFT OUTER JOIN students
ON class.`id`=students.`classid`
WHERE students.id IS NULL;

# 查询所有班级名称和对应的学生姓名(右外连接)
SELECT class.`name`,students.`name`
FROM students RIGHT OUTER JOIN class
ON class.`id`=students.`classid`;

# 查询没有学生的班级名称(右外连接)
SELECT class.`name`
FROM students RIGHT OUTER JOIN class
ON class.`id`=students.`classid`
WHERE students.`id` IS NULL;


/*
全外连接语法格式：
 select * 
 from 表A full [outer] join 表B 
 on 表A.列=表B.列；
*/
# 查询所有学生信息和所有班级信息（全外连接）
SELECT *
FROM students FULL OUTER JOIN class
ON students.`classid`=class.`id`;
# 通过分析需求，得出学生表为主表，班级表也为主表
# 使用2条SQL语句，让学生表和班级表分别当一次主表
SELECT *
FROM students LEFT OUTER JOIN class
ON students.`classid`=class.`id`
UNION 
SELECT *
FROM students RIGHT OUTER JOIN class
ON students.`classid`=class.`id`;

/*
交叉连接
 结果是笛卡尔积（缺少连表条件导致）。
语法格式:
 select * from 表1 cross  join表2； 
*/
# 使用交叉连接查询学生和班级的信息
SELECT *
FROM students CROSS JOIN class;










