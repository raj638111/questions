
In facebook, there is a follow table with two columns: followee, follower.

Please write a sql query to get the amount of each follower’s follower if he/she has one.

For example:

+-------------+------------+
| followee    | follower   |
+-------------+------------+
|     A       |     B      |
|     B       |     C      |
|     B       |     D      |
|     D       |     E      |
+-------------+------------+

should output:
+-------------+------------+
| follower    | num        |
+-------------+------------+
|     B       |  2         |
|     D       |  1         |
+-------------+------------+

Explanation:
Both B and D exist in the follower list, when as a followee, B's follower is C and D, and D's follower is E. A does not exist in follower list.


Note:
Followee would not follow himself/herself in all cases.
Please display the result in follower's alphabet order.


-- Solution (This question is quite weird... fails for other test case except for the default one)

select
followee as follower,
count(*) as num
from
follow
where followee in (select distinct follower from follow)
      and follower != followee
group by followee;

{"headers": ["followee", "follower"], "values": [["B", "C"], ["B", "D"], ["D", "E"]]}