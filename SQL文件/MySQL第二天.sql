/*
回顾：
 SQL语言中的DQL语言（查询语言）
 select		字段列表（查询内容）
 from		表名（数据的来源）
 where		条件列表（筛选条件）
 group by	分组字段列表
 having		分组后条件列表
 order by	排序字段列表
 limit		分页参数
 起别名：as  数据去重：distinct
 注意：
  字段与字段之间用逗号隔开；
  字符串必须加引号。
*/

/*
条件查询
 查询符合筛选条件的内容。
 语法：
  select 字段列表
  from 表名
  where 筛选条件
 注意：常见的筛选条件有比较筛选和逻辑筛选。
 比较运算符:
  = > >= < <= !=
  like'通配符' 像...一样
    （通配符：  % 匹配任意多个任意字符；
		_ 匹配任意一个任意字符。
      转义符： \  把\后面的通配符转义为普通符号。）
  is null 是空
  in(值1，值2，...) 在...里面
  between...and... 从...到...
  （前一个是小值，后一个是大值，要连续）
 逻辑运算符：
  and 并且（多个条件，同时成立）
  or  或者（多个条件，任意一个成立）
  not 非（取反的意思） 
*/

# 分析思路：
# 第一步：确定查询内容（）
# 第二步：确定表名（）
# 第三步：确定筛选条件（）

# 查询学生的姓名和手机号
SELECT NAME,mobile FROM students;

# 查询王小明的姓名和手机号
# 第一步：确定查询内容（姓名和手机号）
SELECT NAME,mobile AS 手机号  # 这里是别名，不能加引号
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（王小明）
WHERE NAME='王小明';  # 字符串必须加引号。

# 查询学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# select id,name,sex,age,birthdate,mobile,classid,locationid
# 第二步：确定表名（学生表）
FROM students;

# 查询年龄为23岁的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（年龄为23岁）
WHERE age=23;

# 查询年龄小于23岁的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（年龄小于23岁）
WHERE age<23;

# 查询年龄大于23岁的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（年龄大于23岁）
WHERE age>23;

# 查询年龄不是23岁的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（年龄不是23岁）
WHERE age!=23;

# 查询姓王的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（姓王）
WHERE NAME LIKE'王%';

# 查询姓名中第二个字为小的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（姓名中第二个字为小）
WHERE NAME LIKE'_小%';

# 查询手机号码包含7的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（手机号码包含7）
WHERE mobile LIKE '%7%';

# 查询手机号码9结尾的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（手机号码9结尾）
WHERE mobile LIKE '%9';

# 查询手机号码为空的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（手机号码为空）
WHERE mobile IS NULL;

# WHERE mobile <=> NULL;
# <=> 安全等于（可以处理空值）

# 查询手机号码不为空的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（手机号码不为空）
WHERE NOT mobile IS NULL;

/*
总结：
 到目前为止，
 筛选的条件都是一个，而且条件的值也是一个；
 思考：若我筛选的值有多个怎么办？

 筛选情景：
 一个条件，一个值；（年龄为23）
 一个条件，多个值；（年龄为23,25）
 多个条件，每个条件一个值；（年龄为23的男生）
 多个条件，每个条件多个值。（年龄为23,25的男生）
*/

# 查询年龄为23岁的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（年龄为23岁）
WHERE age=23;

# 查询年龄为23岁的男生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（年龄为23岁，男生）
WHERE age=23 AND sex='男';

# 查询2班的女生信息
# 分析思路：
# 第一步：确定查询内容（学生信息）
SELECT * 
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（2班，女生）
WHERE classid=2 AND sex='女';

# 查询年龄为23岁或25岁的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（年龄为23岁或25岁）
WHERE age=23 OR age=25;

SELECT *
FROM students
WHERE age IN(23,25);

# 查询年龄大于23岁或手机号码9结尾的学生信息
# 分析思路：
# 第一步：查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（年龄大于23岁或手机号码9结尾）
WHERE age>23 OR mobile LIKE'%9';


# 查询年龄22到25岁的学生信息
# 第一步：确定查询内容（学生信息）
SELECT *
# 第二步：确定表名（学生表）
FROM students
# 第三步：确定筛选条件（年龄为22到25岁）
WHERE age BETWEEN 22 AND 25;

SELECT * 
FROM students
WHERE age>=22 AND age<=25;


# 扩展：and 的优先级高于or

# 查询性别为男或女，并且年龄为22岁的学生信息
SELECT *
FROM students
WHERE sex='男' OR sex='女' AND age=22;

SELECT *
FROM students
WHERE (sex='男' OR sex='女') AND age=22;


/*
聚合函数查询
 函数：算法（方法）。
 
 常用的聚合函数如下：
  sum()   	求和  
  avg()   	求平均值
  max()   	求最大值 
  min()   	求最小值 
  count() 	统计数量（按行统计数量）
  
 语法：
  select 聚合函数(字段) from 表名;
  
 注意事项：
  聚合函数不对null值进行运算。
  聚合函数不能在 where 命令中使用。
*/

# 查询学生的年龄
SELECT age FROM students;

# 查询学生的年龄总和
SELECT SUM(age) FROM students;

# 查询学生的平均年龄
SELECT AVG(age) FROM students;

# 查询学生的最大年龄
SELECT MAX(age) FROM students;

# 查询学生的最小年龄
SELECT MIN(age) FROM students;

# 查询学生人数
SELECT * FROM students;
SELECT COUNT(*) FROM students;
 # 结果：7。 表示有7行数据的意思。
SELECT id FROM students;
SELECT COUNT(id) FROM students;

# 聚合函数不对null值进行运算。
# 查询有手机号的学生人数
SELECT COUNT(*) FROM students WHERE mobile IS NOT NULL;
SELECT mobile FROM students;
SELECT COUNT(mobile) FROM students;

# 查询没有手机号的学生人数
SELECT COUNT(*) FROM students WHERE mobile IS NULL;

# 查询学生表的班级数量
SELECT classid FROM students;
SELECT DISTINCT classid FROM students;
SELECT COUNT(DISTINCT classid) FROM students;


/*
COUNT(*)与COUNT(字段)的区别？
 COUNT(*)时，不过滤null值；
 COUNT(字段)时，过滤null值。
 理解：
   * 表示所有字段(students 表中有8列)
  COUNT(*)时，把所有列（8列）看做一个整体，
   当做入参，即便某列里面有null值，该行也计算在内；
  COUNT(字段)时，只统计该列里面有值的行数，null值不计算在内。
*/
SELECT * FROM students;
SELECT COUNT(*) FROM students;
SELECT mobile FROM students;
SELECT COUNT(mobile) FROM students;









