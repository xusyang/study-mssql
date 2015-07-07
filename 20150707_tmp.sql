-----------------------------
---------存储过程使用---------
-----------------------------

---1、变量声明

---1.1定义整型
declare @pInt as int;
---1.2定义字符型
declare @pStr as varchar(255);


---2、条件语句使用

---2.1IF语句使用
if 1 > 0
	begin
		print 'hello procedure'
	end

---3、WHILE语句使用
declare @i as int
set @i = 10
while (@i > 0)
	begin
		print 'hello' + Str(@i);
		set @i = @i - 1;
	end

---4、游标使用
declare @id as nvarchar(128)
declare cur cursor for
	select OpenID from UserWechat
open cur
fetch next from cur into @id
while @@FETCH_STATUS = 0
	begin
		print @id
		fetch next from cur into @id
	end
close cur
deallocate cur


---5、触发器使用
