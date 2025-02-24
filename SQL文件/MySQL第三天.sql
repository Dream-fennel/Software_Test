/*
分组查询：（为什么要分组？）
 为了方便统计数据。
 语法：
 select 分组字段，聚合函数
 from 表名
 [where 对原始数据的筛选]
 group by 分组字段
 having 对分组后的数据筛选

 group by 把字段内相同的数据分到一个组里。
 having 通常筛选的是聚合函数。（聚合函数不能用在where后面）
 
 1.判断要不要分组？
  关键字+聚合函数。
   关键字：每个、哪个、各个等有区分的意思。
   聚合函数：sum,avg,max,min,count。
  
 2.判断分组字段？
  通常分关键字后面的字段。
   
 3.如何避免数据失真？
  建议查询的结果是分组字段或聚合函数；
  未分组的字段不建议查询，有可能会导致数据（查询结果）失真。
  分组字段：group by 命令后的字段。
*/

# 查询学生人数
SELECT COUNT(id) FROM students;  # 7
# 查询男生人数
SELECT COUNT(id) FROM students WHERE sex='男';  # 6
# 查询女生人数
SELECT COUNT(id) FROM students WHERE sex='女';  # 1
# 分别查询男生与女生的人数
SELECT COUNT(id),sex FROM students GROUP BY sex;
# 分别查询每个年龄段的人数
SELECT COUNT(id) AS 人数,age FROM students GROUP BY age;

# 查询每个班级的学生人数
# 分析思路
# 第一步：确定查询内容（人数）
SELECT COUNT(*)
# 第二步：确定数据源（学生表）
FROM students
# 第三步：确定筛选条件（无）
# 第四步：确定分组字段（班级）
GROUP BY classid;

# 试一试：若查询每个班级的学生姓名会怎样？
SELECT NAME,classid FROM students GROUP BY classid;
 # 查询的结果失真。

# 查询每个班级每个年龄段的人数
SELECT COUNT(*),classid,age
FROM students
GROUP BY classid,age;


# 查询学生人数大于2的班级编号以及人数
# 第一步：确定查询内容（班级编号，人数）
SELECT classid,COUNT(id)
# 第二步：确定数据源（学生表）
FROM students
# 第三步：确定原始数据筛选条件（无）
# 第四步：确定分组字段（班级编号）
GROUP BY classid
# 第五步：确定分组后统计的数据筛选条件（学生人数大于2）
HAVING COUNT(id)>2;
# having不能单独出现，必须跟在group by 后面。
# 1.必须要分组；
# 2.分哪个字段？--> 关键字后面的字段；（无关键字）
#  线索提醒：（避免查询的结果失真）
#   分组后，查询的内容建议是：分组字段或聚合函数；
# （看看select后面都查的什么内容？）

# 试一试：若使用where筛选人数大于2会怎样？
SELECT classid,COUNT(id)
FROM students
WHERE COUNT(id)>2
GROUP BY classid;

/*
where 与 having 的区别？
 1.语法不同：
	where书写在group by 前；
	having书写在group by 后。
 2.筛选的数据对象：
	where筛选的是原始数据；（不能筛选聚合函数）
	having筛选的是分组后统计的数据。
*/


/*
排序查询：
 方便对查询的结果进行查看。
语法：
 select 字段列表
 from 数据源
 order by 字段1 排序方式，字段2 排序方式，...；

 排序方式：升序 ASC，降序 DESC。
  若缺失排序方式，则默认为升序。
 多个字段排序时，需用逗号隔开；
  先排前一个字段，若值相同，再对后一个字段进行排序。
*/
# 查询学生的年龄，要求：按照年龄升序/降序排序
# 分析思路
# 第一步：确定查询内容（年龄）
SELECT age
# 第二步：确定数据源（学生表）
FROM students
# 第三步：确定原始数据筛选条件（无）
# 第四步：确定分组字段（无）
# 第五步：确定分组后统计的数据筛选条件（无）
# 第六步：确定排序字段以及排序方式（年龄（升序/降序））
ORDER BY age ASC;  # 升序

SELECT age FROM students ORDER BY age DESC;  # 降序

# 查询学生的年龄和地址编号，
# 要求：按照年龄升序，地址编号降序排序。
SELECT age,locationid
FROM students
ORDER BY age,locationid DESC;

# 查询每个班级的男生人数
# 要求：按照人数降序排序
# 第一步：确定查询内容（人数）
SELECT COUNT(*) 人数,classid
# 第二步：确定数据源（学生表）
FROM students
# 第三步：确定原始数据筛选条件（男生）
WHERE sex='男'
# 第四步：确定分组字段（每个班级）
GROUP BY classid
# 第五步：确定分组后统计的数据筛选条件（无）
# 第六步：确定排序字段以及排序方式（人数降序）
ORDER BY 人数 DESC;

/*
分页查询
 语法：
 select 字段列表
 from 数据源
 limit [offset,]size;
   offset 表示偏移量（起始值为0）；
   size   表示查询的行数（几行？）。
 limit后可以跟一个值，也可以跟两个值；
  跟一个值：表示查询几条数据；
  跟两个值：前值表示几条不要，后值表示查询的条数。
*/
# 查询年龄最小的学生信息
# 思路：把年龄升序排序，取第一条。
SELECT age FROM students ORDER BY age LIMIT 1;
SELECT age FROM students ORDER BY age LIMIT 0,1;

# 查询地址编号最大的学生信息
# 思路：把地址编号降序，取第一条。
SELECT * FROM students ORDER BY locationid DESC LIMIT 1;

# 查询人数最多的班级以及人数。
# 思路：先 查询每个班级的人数
# 再 把每个班级的人数降序排序
# 最后 获取第一条信息
# 第一步：确定查询内容（班级，人数）
SELECT classid,COUNT(*) AS 人数
# 第二步：确定数据源（学生表）
FROM students
# 第三步：确定原始数据筛选条件（无）
# 第四步：确定分组字段（班级）
GROUP BY classid
# 第五步：确定分组后统计的数据筛选条件（无）
# 第六步：确定排序字段以及排序方式（人数、降序）
ORDER BY 人数 DESC
# 第七步：确定查询条数（1条）
LIMIT 1;

# 查询第二到第四位的学生信息
SELECT * FROM students LIMIT 1,3;

# 每页显示2个人，查询第2页的学生信息
SELECT * FROM students LIMIT 2,2;

/*
总结：limit后可以跟1个值或2个值。
 1个值时，表示查询的条数。
 2个值时，判断是条数还是页数？
  条数：前值=小值-1，后值=大值-小值+1；
  页数：前置=(页数-1)×每页条数，后值=每页条数。
*/


# 单表查询的分析思路：
# 第一步select：确定查询内容（）
# 第二步from：确定数据源（）
# 第三步where：确定原始数据筛选条件（）
# 第四步group by：确定分组字段（）
# 第五步having：确定分组后统计的数据筛选条件（）
# 第六步order by：确定排序字段以及排序方式（）
# 第七步limit：确定查询条数（）



