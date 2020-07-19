
The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+
The Department table holds all departments of the company.

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows (order of rows does not matter).

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+

-- Join

select
  *,
  dense_rank() over (partition by DepartmentId order by Salary desc) as rnk
from
  Employee
where rnk in (1, 2, 3)


-- Where

select
    d.Name as Department,
    e1.Name as Employee,
    e1.Salary as Salary
from
    Employee e1
join
    Department d
on
    e1.DepartmentId = d.Id
where
    (
        select
            count(distinct Salary) as count
        from
            Employee e2
        where
            e2.DepartmentId = e1.DepartmentId and
            e2.Salary > e1.Salary and
            e2.Id not in (e1.Id)
    ) < 3