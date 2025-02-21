/*
多行注释
;英文分号结尾
DQL:数组查询语言
select
from
where
group by
having
order by
limit

,
''
select *
from students;

select name
from students;

select name,sex,mobile
from students;

select name as 姓名,sex as 性别
from students;

select distinct age
from students;

select *
from class;

select name
from class;

*/
#单行注释

/*
#第一天练习
SELECT 123,666;
SELECT '好好学习吧';
SELECT 1111;
SELECT NAME AS 姓名 ,sex AS 性别
FROM students;
SELECT *
FROM students;

SELECT DISTINCT age
FROM students;
SELECT age
FROM students;
*/

SELECT NAME,mobile
FROM students
WHERE NAME ='王小明';
#第一步：查询学生信息
#第二步：学生表
#第三步：年龄为23
SELECT *
FROM students
WHERE age =23;

SELECT *
FROM students
WHERE age > (
	SELECT age
	FROM students
	WHERE NAME = '刘星');
#第一步：查询学生信息
#第二步：学生表
#第三步：年龄小于23
SELECT *
FROM students
WHERE age <23;
#第一步：查询学生信息
#第二步：学生表
#第三步：年龄大于23
SELECT *
FROM students
WHERE age >23;
#第一步：查询学生信息
#第二步：学生表
#第三步：年龄不等于23
SELECT *
FROM students
WHERE age != 23;
#第一步：查询学生信息
#第二步：学生表
#第三步：姓王
SELECT *
FROM students
WHERE NAME LIKE '王%';
#第一步：查询学生信息
#第二步：学生表
#第三步：手机号包含7
SELECT *
FROM students
WHERE mobile LIKE '%7%';
#第一步：查询学生信息
#第二步：学生表
#第三步：手机号9结尾
SELECT *
FROM students
WHERE mobile LIKE '%9';

#查询手机号为空的学生信息
#第一步：查询学生信息
#第二步：学生表
#第三步：手机号为空
SELECT *
FROM students
WHERE mobile IS NULL;

#查询手机号不为空的学生信息
#第一步：查询学生信息
#第二步：学生表
#第三步：手机号不为空
SELECT *
FROM students
#WHERE mobile is not NULL;
WHERE NOT mobile IS NULL;

/*
筛选情景
一个条件，一个值:（年龄23)
一个条件，多个值：
多个条件，每个条件一个条件一个值：
多个条件，每个条件多个值
*/

#第一步：查询学生信息
#第二步：学生表
#第三步：年龄23的男生
SELECT *
FROM students
WHERE age = 23 AND sex='女';


#第一步：查询学生信息
#第二步：学生表
#第三步：年龄2班的女生
SELECT *
FROM students
WHERE classid =2 AND sex='女';

#第一步：查询学生信息
#第二步：学生表
#第三步：年龄23或25
SELECT *
FROM students
-- WHERE age =23 or age =25;
WHERE age IN (23,25);

#第一步：查询学生信息
#第二步：学生表
#第三步：年龄大于23或手机号码9结尾
SELECT *
FROM students
WHERE age >23 OR mobile LIKE '%9';

#第一步：查询学生信息
#第二步：学生表
#第三步：年龄大于22到25
SELECT *
FROM students
WHERE age BETWEEN 22 AND 25;


#查询性别为男或女，并且年龄为22岁的学生信息
SELECT *
FROM students
WHERE (sex = '男' OR sex = '女') AND age = 22;

SELECT *
FROM students
#会先执行and再执行or，因为and的优先级高于or
WHERE sex = '男' OR sex = '女' AND age = 22;

#查询学生的年龄总和
SELECT SUM(age)
FROM students;
#去重之后求和
SELECT SUM(DISTINCT age)
FROM students;
#查询学生的平均年龄
SELECT AVG(age)
FROM students;
#查询学生的最大年龄
SELECT MAX(age)
FROM students;
#查询学生的最小年龄
SELECT MIN(age)
FROM students;

#查询学生人数
SELECT	COUNT(*)
FROM students;

#查询有手机号的学生人数
-- select count(id)
-- from students
-- where id in(
-- 	select id
-- 	from students
-- 	where mobile is not null);

-- select count(*)
-- from students
-- where mobile is not null;

#聚合函数不对NULL值进行统计
SELECT mobile
FROM students;
SELECT COUNT(mobile)
FROM students;

/*面试题
COUNT(*)与COUNT(字段)的区别
* 表示所有字段（students 表中有8列）
count(*)时把8列看做一个整体（入参）
count(*)时，不过滤NULL值（把某列中的NULL值也计算在内）
count(字段)时，过滤NULL值（把某列中的NULL值也计算在内）
*/ 
#查询没有手机号的学生人数
-- SELECT COUNT(id)
-- FROM students
-- WHERE id IN(
-- 	SELECT id
-- 	FROM students
-- 	WHERE mobile IS NULL);

SELECT COUNT(*)
FROM students
WHERE mobile IS NULL;

#查询学生表的班级数量
SELECT DISTINCT classid
FROM students;

SELECT COUNT(DISTINCT classid)
FROM students;
