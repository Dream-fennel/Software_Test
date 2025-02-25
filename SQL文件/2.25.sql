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

#分析思路
# 第一步：确定查询内容（班级名称，学生姓名）
# 第二步：确定数据源（学生表，班级表）

SELECT students.name,class.name
FROM students 
INNER JOIN class 
ON class.id=students.classid;

SELECT *
FROM students
INNER JOIN locations 
ON locations.id = students.locationid;

#查询学生的姓名，班级名称，地址名称
SELECT stu.name,cla.name,loc.name
FROM students AS stu 
INNER JOIN class AS cla
ON stu.classid = cla.id
INNER JOIN locations AS loc
ON loc.id = stu.locationid;


SELECT *
FROM students 
INNER JOIN class 
ON class.id=students.classid;

/*非等值连接
查询的结果为表1里某字段里的数据在表2里对应字段的等级范围。 
语法格式: 
select * 
from 表A [inner]  join表B 
On  表A.列 bewteen 表B.列 and 表B.列; 
*/
#查询学生的年龄以及年龄称呼
SELECT age,level.name
FROM students INNER JOIN LEVEL
ON age BETWEEN low_age AND high_age;

/*自连接
把一个表当两个表来使用。 
注意：必须起别名，否则无法区分。
语法格式: 
select * 
from 表1 AS 别名1 [inner]  join表1 AS 别名2 
On别名1 .列 = 别名2.列; 
*/
#查询地址名称以及上级地址名称
SELECT locb.name AS 地址,loca.name AS 上级名称
FROM locations AS loca 
INNER JOIN locations AS locb
ON loca.id=locb.upid;

#查询班级名称和对应的学生姓名（内连接）
SELECT class.name,students.name
FROM students 
INNER JOIN class
ON students.classid=class.id;

#查询所有班级名称和对应的学生姓名（左外连接）
SELECT class.name,students.name
FROM class 
LEFT OUTER JOIN students
ON students.classid=class.id;

#查询没有学生的班级名称（左外连接）
SELECT class.name
FROM class 
LEFT OUTER JOIN students
ON students.classid=class.id
WHERE students.name IS NULL;


#查询所有班级名称和对应的学生姓名（右外连接）
SELECT class.name,students.name
FROM students 
RIGHT OUTER JOIN class
ON students.classid=class.id;

#查询没有学生的班级名称（右外连接）
SELECT class.name
FROM students 
RIGHT OUTER JOIN class
ON students.classid=class.id
WHERE students.name IS NULL;

#查询没有手机号的学生姓名以及对应的班级名称
SELECT students.name,class.name,mobile
FROM students
RIGHT OUTER JOIN class
ON students.classid=class.id
WHERE mobile IS NULL;

#查询地址在周口的所有学生姓名以及对应的学生手机号
SELECT students.name,mobile
FROM locations
LEFT OUTER JOIN students
ON students.locationid=locations.id
WHERE locationid = 4;

#查询地址不在周口的所有学生姓名以及对应的学生手机号
SELECT students.name,mobile
FROM locations
RIGHT OUTER JOIN students
ON students.locationid=locations.id
WHERE locationid != 4;



SELECT *
FROM srudents
FULL OUTER JOIN class
ON students.classid=class.id;

SELECT *
FROM students
LEFT OUTER JOIN class
ON students.classid=class.id
UNION
SELECT *
FROM students
RIGHT OUTER JOIN class
ON students.classid=class.id;


SELECT *
FROM students
CROSS JOIN class;
