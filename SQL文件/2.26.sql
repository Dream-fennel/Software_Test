/*
1.子查询语法：
SQL语句(select 语句(select 语句(...)));
2.子查询分类
根据子查询返回的结果进行分类。

标量子查询：一行一列。子查询返回的值是一行一列
列子查询：一列多行
行子查询：一行多列
表级子查询：多行多列
3.子查询位置：
放在不同的位置，充当不同的角色，常见的子查询类型有哪些？
select （子查询）：子查询充当查询内容。（标量子查询）
from （子查询）：子查询充当数据源。（表级子查询）
where （子查询）：子查询充当筛选条件。（标量/列/行子查询）
having （子查询）：子查询充当筛选条件。（标量/列/行子查询）
4.子查询注意事项：
子查询可以嵌套多层，但每一层需要用小括号括起来。
*/

#查询王小明同班级的学生信息
#1.查询王小明所在班级
#2.查询学生信息
SELECT *
FROM students
WHERE classid =
	(SELECT classid
	FROM students
	WHERE NAME = '王小明');
#查询年龄比李晓红大的学生信息
#1.查询李晓红的年龄
#2.查询信息
SELECT *
FROM students
WHERE age>
	(SELECT age
	FROM students
	WHERE NAME = '李晓红');
#查询mysql班的学生信息
#查看mysql班的班级号
#查询学生信息
#方法1，子查询
SELECT *
FROM students
WHERE classid =
	(SELECT id
	FROM class
	WHERE NAME = 'MySQL班');
#方法2，连表
SELECT students.*
FROM students
INNER JOIN class
ON students.classid = class.id 
WHERE class.name = 'MySQL班';

#查询女生的年龄以及男生的平均年龄
SELECT age 女生年龄,
	(SELECT AVG(age)
	FROM students
	WHERE sex = '男') 男生的平均年龄
FROM students
WHERE sex = '女';

#查询班级人数比1号学生所在班级人数多的班级编号与人数
#1.1号学生所在班级号
#2.1号所在班级的人数
#3.查询班级编号与人数
SELECT classid,COUNT(*)
FROM students
GROUP BY classid
HAVING COUNT(*)>
	(SELECT COUNT(*)
	FROM students
	WHERE classid = 
		(SELECT classid
		FROM students
		WHERE id = 1));
	
#查询与学生编号为1，3班级相同的学生信息
#查询学生编号为1，3的班级编号
#查询学生信息
SELECT *
FROM students
WHERE classid = ANY 
	(SELECT classid
	FROM students
	WHERE id = 1 OR id = 3);
#查询与学生编号为1，3班级相同的学生信息
SELECT *
FROM students
WHERE classid IN
	(SELECT classid
	FROM students
	WHERE id IN (1,3));
#any不能用在普通查询
#any括号里面必须是SQL语句

#查询年龄比1班任意年龄小的学生信息
#1.查询1班的年龄N
#2.查询年龄比1班任意N小的学生信息
SELECT *
FROM students
WHERE age <ANY
	(SELECT age
	FROM students
	WHERE classid = 1);
#查询年龄比1班所有年龄小的学生信息
#1.查询1班的年龄N
#2.查询年龄比1班所有N小的学生信息
SELECT *
FROM students
WHERE age <ALL
	(SELECT age
	FROM students
	WHERE classid = 1);
#查询年龄比1班所有年龄小的学生信息
#标量子查询
SELECT *
FROM students
WHERE age <
	(SELECT MIN(age)
	FROM students
	WHERE classid=1);
/*
行子查询
常见 主查询 where (条件1,条件2) = (行子查询)
*/
#查询1班年龄最高的学生信息
SELECT *
FROM students
WHERE classid = 1 AND age=
	(SELECT MAX(age)
	FROM students
	WHERE classid = 1);
#1.查询1班的班级编号与最高年龄(X,Y)
SELECT classid,MAX(age) 
FROM students 
WHERE classid = 1;
#2.查询班级编号与学生年龄为(1,25)的学生信息
SELECT * 
FROM students 
WHERE (classid,age) = (1,25)
#3.用SQL语句替换(1,25)完成子查询
SELECT * 
FROM students 
WHERE (classid,age) = 
	(SELECT classid,MAX(age) 
	FROM students
	WHERE classid = 1);
	
#把每个班的平均年龄当作数据源，查询最低平均年龄
SELECT MIN(平均年龄) AS 最低平均年龄
FROM    (SELECT AVG(age) AS 平均年龄
	FROM students
	GROUP BY classid) AS a;
	
