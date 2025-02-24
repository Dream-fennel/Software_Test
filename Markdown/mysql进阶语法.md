当然，`CASE` 表达式在 SQL 中有两种主要的语法格式：简单 `CASE` 表达式和搜索 `CASE` 表达式。以下是这两种格式的详细说明和示例：

### 1. 简单 `CASE` 表达式

简单 `CASE` 表达式通常用于基于某个列的值进行条件判断。它的基本语法如下：

```sql
CASE column_name
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ...
    ELSE result ELSE
END
```

- `column_name` 是你要基于其值进行条件判断的列。
- `WHEN value1 THEN result1` 定义了第一个条件，如果 `column_name` 的值等于 `value1`，则返回 `result1`。
- `WHEN value2 THEN result2` 定义了第二个条件，如果 `column_name` 的值等于 `value2`，则返回 `result2`。
- `ELSE result ELSE` 是一个可选部分，如果所有的 `WHEN` 条件都不满足，则返回 `result ELSE`。

**示例**：

假设有一个名为 `employees` 的表，其中包含 `salary` 列，你想根据 `salary` 的值来确定员工的薪资等级：

```sql
SELECT 
    employee_id,
    salary,
    CASE salary
        WHEN 0 THEN '未定义'
        WHEN 1000 THEN '低'
        WHEN 3000 THEN '中'
        ELSE '高'
    END AS salary_level
FROM 
    employees;
```

### 2. 搜索 `CASE` 表达式

搜索 `CASE` 表达式不依赖于某个特定的列，而是根据任意条件进行判断。它的基本语法如下：

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE result ELSE
END
```

- `condition1`, `condition2`, ... 是你要评估的条件。
- `WHEN condition1 THEN result1` 定义了第一个条件，如果 `condition1` 为真，则返回 `result1`。
- `WHEN condition2 THEN result2` 定义了第二个条件，如果 `condition2` 为真，则返回 `result2`。
- `ELSE result ELSE` 是一个可选部分，如果所有的 `WHEN` 条件都不满足，则返回 `result ELSE`。

**示例**：

假设有一个名为 `sales` 的表，其中包含 `amount` 列，你想根据 `amount` 的值来确定销售的类别：

```sql
SELECT 
    sale_id,
    amount,
    CASE
        WHEN amount > 10000 THEN '大'
        WHEN amount BETWEEN 5000 AND 10000 THEN '中'
        ELSE '小'
    END AS sale_category
FROM 
    sales;
```

这两种 `CASE` 表达式都允许你在 SQL 查询中实现条件逻辑，从而根据不同的条件返回不同的结果。