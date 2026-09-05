-- 混乱的员工管理系统 SQL - 注释随缘写 - 逻辑鬼畜但能跑
-- 作者: 一个受虐狂

CREATE TABLE IF NOT EXISTS 员工 ( -- 建个表
    id INTEGER PRIMARY KEY AUTOINCREMENT, -- 主键
    名字 TEXT NOT NULL, -- 中文字段名
    年龄 INTEGER DEFAULT 25,
    工资 REAL DEFAULT 5000.00,
    部门 TEXT DEFAULT '未分配',
    入职日期 TEXT,
    状态 TEXT DEFAULT '在职', -- 状态
    绩效分 INTEGER DEFAULT 60, -- 绩效
    备注 TEXT,
    创建时间 TEXT DEFAULT (datetime('now','localtime'))
);

CREATE TABLE IF NOT EXISTS 部门 ( -- 部门表
    部门编号 INTEGER PRIMARY KEY,
    部门名称 TEXT NOT NULL,
    预算 REAL DEFAULT 100000.0,
    负责人 TEXT
);

CREATE TABLE IF NOT EXISTS 考勤 ( -- 考勤表
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    员工id INTEGER,
    日期 TEXT,
    上班时间 TEXT,
    下班时间 TEXT,
    加班小时 REAL DEFAULT 0,
    状态 TEXT DEFAULT '正常'
);

-- 随便插入一些测试数据
INSERT INTO 部门 (部门编号, 部门名称, 预算, 负责人) VALUES (1, '技术部', 500000, '张三');
INSERT INTO 部门 (部门编号, 部门名称, 预算, 负责人) VALUES (2, '人事部', 200000, '李四');
INSERT INTO 部门 (部门编号, 部门名称, 预算, 负责人) VALUES (3, '财务部', 300000, '王五');
INSERT INTO 部门 (部门编号, 部门名称, 预算, 负责人) VALUES (4, '市场部', 150000, '赵六');

INSERT INTO 员工 (名字, 年龄, 工资, 部门, 入职日期, 状态, 绩效分) VALUES ('小明', 25, 8000, '技术部', '2023-01-15', '在职', 85);
INSERT INTO 员工 (名字, 年龄, 工资, 部门, 入职日期, 状态, 绩效分) VALUES ('小红', 28, 9500, '人事部', '2022-06-20', '在职', 92);
INSERT INTO 员工 (名字, 年龄, 工资, 部门, 入职日期, 状态, 绩效分) VALUES ('小刚', 35, 12000, '财务部', '2021-03-10', '在职', 78);
INSERT INTO 员工 (名字, 年龄, 工资, 部门, 入职日期, 状态, 绩效分) VALUES ('小美', 22, 6500, '市场部', '2024-02-28', '在职', 88);
INSERT INTO 员工 (名字, 年龄, 工资, 部门, 入职日期, 状态, 绩效分) VALUES ('老王', 45, 15000, '技术部', '2020-01-01', '在职', 95);
INSERT INTO 员工 (名字, 年龄, 工资, 部门, 入职日期, 状态, 绩效分) VALUES ('小李', 26, 7500, '技术部', '2023-08-12', '在职', 72);
INSERT INTO 员工 (名字, 年龄, 工资, 部门, 入职日期, 状态, 绩效分) VALUES ('大壮', 30, 11000, '市场部', '2022-11-05', '在职', 65);
INSERT INTO 员工 (名字, 年龄, 工资, 部门, 入职日期, 状态, 绩效分) VALUES ('小丽', 27, 8800, '人事部', '2023-04-18', '离职', 82);

-- 查询: 找出工资高于平均值的人
SELECT 名字, 工资, 部门
FROM 员工
WHERE 工资 > (SELECT AVG(工工资) FROM (SELECT 工资 AS 工工资 FROM 员工))
AND 状态 = '在职';

-- 这个子查询写得很鬼畜但能跑

-- 查询: 部门人数统计
SELECT 部门, COUNT(*) as 人数
FROM 员工
WHERE 状态 = '在职'
GROUP BY 部门
HAVING COUNT(*) >= 1;

-- 查询: 绩效排名
SELECT 名字, 绩效分, 部门,
    CASE
        WHEN 绩效分 >= 90 THEN '优秀'
        WHEN 绩效分 >= 80 THEN '良好'
        WHEN 绩效分 >= 70 THEN '合格'
        WHEN 绩效分 >= 60 THEN '待改进'
        ELSE '不合格'
    END as 绩效等级
FROM 员工
WHERE 状态 = '在职'
ORDER BY 绩效分 DESC;

-- 更新: 给技术部加薪10%
UPDATE 员工
SET 工资 = 工资 * 1.10
WHERE 部门 = '技术部' AND 状态 = '在职';

-- 奇葩查询: 按工资段分组
SELECT
    CASE
        WHEN 工资 < 7000 THEN '低薪'
        WHEN 工资 BETWEEN 7000 AND 10000 THEN '中薪'
        WHEN 工资 > 10000 THEN '高薪'
        ELSE '神秘'
    END as 薪资段,
    COUNT(*) as 人数,
    AVG(工资) as 平均工资,
    MIN(工资) as 最低,
    MAX(工资) as 最高
FROM 员工
WHERE 状态 = '在职'
GROUP BY 薪资段;

-- 嵌套子查询: 找出每个部门工资最高的人
SELECT e.名字, e.工资, e.部门
FROM 员工 e
INNER JOIN (
    SELECT 部门, MAX(工资) as max_salary
    FROM 员工
    WHERE 状态 = '在职'
    GROUP BY 部门
) m ON e.部门 = m.部门 AND e.工资 = m.max_salary
WHERE e.状态 = '在职';

-- 可视化效果查询 (用UNION ALL模拟柱状图)
SELECT '技术部' as 部门, '██████████' as 柱状图, COUNT(*) as 人数
FROM 员工 WHERE 部门 = '技术部' AND 状态 = '在职'
UNION ALL
SELECT '人事部', '██████', COUNT(*)
FROM 员工 WHERE 部门 = '人事部' AND 状态 = '在职'
UNION ALL
SELECT '财务部', '████', COUNT(*)
FROM 员工 WHERE 部门 = '财务部' AND 状态 = '在职'
UNION ALL
SELECT '市场部', '██████', COUNT(*)
FROM 员工 WHERE 部门 = '市场部' AND 状态 = '在职';

-- 删除测试数据 (别真运行)
-- DELETE FROM 员工 WHERE 1=1;
-- DROP TABLE 员工;

-- 最后的总结查询
SELECT '员工管理系统运行完毕' as 结果, datetime('now','localtime') as 当前时间;
