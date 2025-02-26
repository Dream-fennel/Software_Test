/*
1.子查询语法：
	SQL语句（select语句（select语句（...）））；
	
2.子查询分类：
   根据子查询返回的结果进行分类。
 标量子查询：一行一列；
 列子查询：一列多行；
 行子查询：一行多列；
 表子查询：多行多列。
 
3.子查询位置：
  放在不同的地方，充当不同的角色，常见的子查询类型有哪些？
 select (子查询):子查询充当查询内容。（标量子查询）
 from(子查询)：子查询充当数据源。（表子查询）
 where/having(子查询)：子查询充当筛选条件。（标量/列/行子查询）

4.子查询注意事项：
 子查询可以嵌套多层，但每一层需要用小括号括起来。
 表子查询时，必须给子查询起别名；
 若表子查询中返回的字段有函数作用时，必须给该字段起别名。
*/
/*
标量子查询
 常用 主查询 where 条件 =（子查询）
*/

# 查询班级编号为1的学生信息
SELECT * FROM students WHERE classid=1;

# 查询与王小明同班的学生信息
# 1.查询王小明所在班（1）
SELECT classid FROM students WHERE NAME='王小明';
# 2.查询（1）班的学生信息
SELECT * FROM students WHERE classid=1;
# 3.用SQL语句替换（1）完成子查询
SELECT * FROM students WHERE classid=(
 SELECT classid FROM students WHERE NAME='王小明');
 
# 查询年龄比李晓红大的学生信息
# 1.查询李晓红的年龄（23）
SELECT age FROM students WHERE NAME='李晓红';
# 2.查询年龄大于（23）的学生信息
SELECT * FROM students WHERE age>23;
# 3.用SQL替换（23）完成子查询
SELECT * FROM students WHERE age>(
 SELECT age FROM students WHERE NAME='李晓红');
 
# 查询MySQL班的学生信息
 # 提示：连表与子查询都能实现此需求。
# 连表：内连(因为查询的数据在学生表，而筛选的数据在班级表)
SELECT students.*
FROM students INNER JOIN class
ON students.`classid`=class.`id`
WHERE class.`name`='MySQL班';
# 子查询：
# 1.查询MySQL班的班级编号（1）
SELECT id FROM class WHERE NAME='MySQL班';
# 2.查询班级编号为（1）的学生信息
SELECT * FROM students WHERE classid=1;
# 3.用SQL替换（1）完成子查询
SELECT * FROM students WHERE classid=(
 SELECT id FROM class WHERE NAME='MySQL班');

# 查询女生的年龄以及男生的平均年龄
# 1.查询男生的平均年龄（24.3333）
SELECT AVG(age) FROM students WHERE sex='男';
# 2.查询女生的年龄以及（24.3333）
SELECT age AS 女生的年龄,24.3333 AS 男生的平均年龄
FROM students 
WHERE sex='女';
# 3.用SQL替换（24.3333）完成子查询
SELECT age AS 女生的年龄,(
 SELECT AVG(age) FROM students WHERE sex='男') AS 男生的平均年龄
FROM students 
WHERE sex='女';

# 进阶：查询班级人数比1号学生所在班级人数多的班级编号与人数 
 # 提示：子查询嵌套子查询
# 1.查询1号学生所在班级编号（1）
SELECT classid FROM students WHERE id=1;
# 2.查询（1）班的人数（2）
SELECT COUNT(*) FROM students WHERE classid=1;
# 3.查询班级人数大于（2）的班级编号与人数
SELECT classid,COUNT(*)
FROM students
GROUP BY classid
HAVING COUNT(*)>2;
# 4.用SQL替换（X）（Y）的值完成子查询
SELECT classid,COUNT(*)
FROM students
GROUP BY classid
HAVING COUNT(*)>(
 SELECT COUNT(*) FROM students WHERE classid=(
  SELECT classid FROM students WHERE id=1));

/*
列子查询
 常用   主查询 where 条件 in(子查询)
	主查询 where 条件 =any(子查询)
	主查询 where 条件 !=all(子查询)
	
 注意：any和all只能用于子查询里面，不能用于普通查询。
 总结：
  <any时，小于最大的即可；
  >any时，大于最小的即可；
  <all时，小于最小的；
  >all时，大于最大的。
*/
# 查询与学生编号为1、3班级相同的学生信息
# 1.查询学生编号为1、3的班级编号（1,2）
SELECT classid FROM students WHERE id IN(1,3);
# 2.查询（1,2）班的学生信息
SELECT * FROM students WHERE classid IN(1,2);
# 3.用SQL替换（1,2）完成子查询
SELECT * FROM students WHERE classid IN(
 SELECT classid FROM students WHERE id IN(1,3));

SELECT * FROM students WHERE classid =ANY(
 SELECT classid FROM students WHERE id IN(1,3));

# 查询年龄比1班任意年龄小的学生信息
# 1.查询1班的学生年龄（23,25）
SELECT age FROM students WHERE classid=1;
# 2.查询年龄比任意（23,25）小的学生信息
SELECT * FROM students WHERE age<ANY(
 SELECT age FROM students WHERE classid=1);

 
SELECT * FROM students WHERE age<(
 SELECT MAX(age) FROM students WHERE classid=1);

# 查询年龄比1班所有年龄小的学生信息
# 1.查询1班的学生年龄（23,25）
SELECT age FROM students WHERE classid=1;
# 2.查询年龄比所有（23,25）小的学生信息
SELECT * FROM students WHERE age<ALL(
 SELECT age FROM students WHERE classid=1);  # 列子查询

SELECT * FROM students WHERE age<(
 SELECT MIN(age) FROM students WHERE classid=1); # 标量子查询
 

# 查询学生编号为1、3的学生信息
SELECT * FROM students WHERE id IN(1,3);

SELECT * FROM students WHERE id=ANY(1,3); # 错误语法
 # any与all后小括号内必须是子查询，不能直接是值。
 
/*
行子查询
 常见 主查询  where (条件1,条件2) =(行子查询)
*/
# 查询1班年龄最高的学生信息
# 1.查询1班的班级编号与最高年龄（X,Y）
SELECT classid,MAX(age) FROM students WHERE classid=1;
# 2.查询班级编号与学生年龄为（1,25）的学生信息
SELECT * FROM students WHERE (classid,age)=(1,25);
 # SELECT * FROM students WHERE classid=1 AND age=25;
# 3.用SQL替换（1.25）完成子查询
SELECT * FROM students WHERE (classid,age)=(
 SELECT classid,MAX(age) FROM students WHERE classid=1);
 
/*
表子查询
 常见 主查询 from （表子查询） as 表别名
*/
# 把每个班的平均年龄当做数据源，查询最低平均年龄。
SELECT MIN(avg_age) AS 最低平均年龄
FROM (
 SELECT classid,AVG(age) AS avg_age  # 给函数作用的字段起别名
 FROM students 
 GROUP BY classid) AS s;  # 给表子查询起别名



/*
mysql 常见数据类型：数值型，字符型，日期型等。
 数值型：表达数值的，如 小数，整数
	int 整型（整数），double 浮点型（小数）
 字符型：表达字符串的，如 我好好好学习，月薪过万
	char 定长字符串，varchar 变长字符串
 日期型：表达时间的，如 2025-02-26 16:25:00
	datetime 年月日时分秒
*/
/*
面试：
char与varchar的区别？
 char 存储的是固定长度字符串，
 varchar 存储的是可变长度字符串；
 所以 varchar 比 char 更节省空间。
 但是，创建表时，varchar必须指定长度，否则会报错；
 而char不指定长度不会报错，但有可能默认长度不能满足需求。
*/

# SQL语句中，字符串必须加引号。
SELECT NAME
FROM students
WHERE id=1;  # 未加引号，因为id列的数据类型为int

SELECT *
FROM students
WHERE sex='男';  # 加了引号，因为sex列的数据类型为char




























