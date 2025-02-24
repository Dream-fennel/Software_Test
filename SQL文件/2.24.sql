/*
分组查询：（为什么要分组？）
为了方便统计数据
语法：
select 分组字段，聚合函数
from 表名
[where 对原始数据的筛选]
group by 分组字段
having 对分组后的数据筛选
group by 把字段内相同的数据分到一个组中。
having 同v行筛选的是聚合函数。（聚合函数不能用在where后面）

# 分析思路
# 第一步：确定查询内容（）
# 第二步：确定数据源（）
# 第三步：确定原始数据筛选条件（）
# 第四步：确定分组字段（）
# 第五步：确定分组后统计的数据筛选条件（）
# 第六步：确定排序字段以及排序方式（）
# 第七步：确定查询条数（）

1.判断是否用分组
关键字+聚合函数
关键字：每个，哪个，各个等有区分的意思
聚合函数：SUM,AVG,MAX,MIN,COUNT
2.判断分组字段？
通常分关键字后面的字段。

3.如何避免数据失真？
建议查询的结果是分组字段或聚合函数：
未分组的字段不建议查询，有可能会导致数据（查询结果）失真。
分组字段：GROUP BY 命令后的字段

*/

SELECT	sex,COUNT(id)
FROM students
GROUP BY sex;

SELECT	age,COUNT(id) AS 人数
FROM students
GROUP BY age;

-- 查询每个班级的学生人数
-- 第一步：确认查询内容：人数
-- 第二步：确认数据源：学生表
-- 第三步：确实筛选条件：无
-- 第四步：确认分组字段：班级
SELECT	classid,COUNT(id) AS 人数
FROM students
GROUP BY classid;
-- 查询每个班级的学生姓名
-- 第一步：确认查询内容：姓名
-- 第二步：确认数据源：学生表
-- 第三步：确实筛选条件：无
-- 第四步：确认分组字段：班级
SELECT classid,NAME
FROM students
GROUP BY classid; #数据失真

SELECT classid
FROM students
GROUP BY classid; 
#查询学生人数大于2的班级编号及人数
# 分析思路
# 第一步：确定查询内容（班级编号，人数）
# 第二步：确定数据源（students）
# 第三步：确定原始数据筛选条件（无）
# 第四步：确定分组字段（班级编号）
# 第五步：确定分组后统计的数据筛选条件（学生人数大于2）
SELECT classid,COUNT(id)
FROM students
GROUP BY classid
HAVING COUNT(id)>2;

#having 不能单独出现，必须跟在group by后面
1.必须要分组
2.分哪个字段？  关键字后面的字段：（无关键字

#查询学生年龄大于23的班级编号及人数
SELECT classid,COUNT(id)
FROM students
WHERE age>23
GROUP BY classid;

SELECT classid,COUNT(id)
FROM students
WHERE COUNT(id)>2
GROUP BY classid;

-- where 与 having 的区别？
-- 1.语法不同：
-- where 书写在group by前；
-- having 书写在group by后；
-- 2.筛选的数据对象不同：
-- where 筛选的是原始数据：（不能筛选聚合函数）
-- having 筛选的是分组后统计的数据

-- 排序查询
-- 方便对查询的结果进行查看
-- 语法：
-- select 字段列表
-- from 数据源
-- order by 字段1 排序方式,字段2 排序方式,...
-- 排序方式 ASC 升序 ；DESC 降序
-- 若确实排序方式，则默认为升序
-- 多个字段排序时，需要用逗号隔开；
-- 先排前一个字段，若值相同，再对后一个字段进行排序

#查询学生的年龄，要求：按照年龄升序/降序
# 分析思路
# 第一步：确定查询内容（年龄）
# 第二步：确定数据源（学生表）
# 第三步：确定原始数据筛选条件（无）
# 第四步：确定分组字段（无）
# 第五步：确定分组后统计的数据筛选条件（无）
# 第六步：确定排序字段以及排序方式（降序）
SELECT age
FROM students
ORDER BY age DESC;

#查询学生的年龄和地址编号，
#要求按照年龄升序，地址编号降序
SELECT locationid,age
FROM students
ORDER BY locationid DESC,age;


#查询每个班级的男生人数
#人数按降序
# 分析思路
# 第一步：确定查询内容（人数）
# 第二步：确定数据源（学生表）
# 第三步：确定原始数据筛选条件（男生）
# 第四步：确定分组字段（班级编号）
# 第五步：确定分组后统计的数据筛选条件（无）
# 第六步：确定排序字段以及排序方式（降序）
SELECT COUNT(id)
FROM students
WHERE sex = '男'
GROUP BY classid
ORDER BY COUNT(id) DESC;

#AS可以省略
SELECT COUNT(id) 人数
FROM students
WHERE sex = '男'
GROUP BY classid
ORDER BY 人数 DESC;



/*
分页查询
语法：
select 字段列表
from 数据源
limit [offset,]size;
offset 表示偏移量（起始位置为0）
size   表示查询的函数（几行）
limit 后可以跟一个值，也可以跟两个值；
跟一个值：表示查询几条数据；
跟两个值：前值表示几条不要，后值表示查询的条数；


*/
#查询年龄最小的学生信息
SELECT *
FROM students
ORDER BY age
LIMIT 1;

SELECT *
FROM students
ORDER BY age
LIMIT 0,1;

#查询地址编号最大的学生信息
SELECT *
FROM students
ORDER BY locationid DESC
LIMIT 1;

#查询人数最多的班级以及人数
#思路：先查询每个班级的人数
#再把每个班级的人数降序排序
SELECT classid,COUNT(id)
FROM students
GROUP BY classid
ORDER BY COUNT(id) DESC
LIMIT 1;

#查询第二到第四位的学生信息
SELECT *
FROM students
ORDER BY id
LIMIT 1,3;

/*
总结：limit后可以跟1个值或2个值。
1个值时，表示查询的条数
2个值时，判断时条数还是页数？
条数：前值=小值-1，后值=大值-小值+1
页数：前值=（页数-1）* 每项条数，后值=每页条数。

*/
#查询学生姓名以及所在的班级名称
SELECT students.name,class.name
FROM class,students
WHERE students.classid=class.id;