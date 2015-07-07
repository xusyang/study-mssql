----------------------------------------------------------
-------------------------存储过程使用---------------------
----------------------------------------------------------
--参考链接:http://www.cnblogs.com/kissdodog/p/3173421.html
----------------------------------------------------------

---1、变量声明
---1.1 定义整型
declare @pInt as int;
---1.2 定义字符型
declare @pStr as varchar(255);


---2、条件语句使用
---2.1 IF语句使用
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
---5.1 UPDATE触发器 
Alter TRIGGER UPDATECHECK
　　ON [UserWechat]
　　FOR UPDATE
　　AS
	IF UPDATE(NickName)    --修改了昵称字段， 这里还有一个目的相同的函数：COLUMNS_UPDATE()
　　BEGIN
    　　PRINT('修改了昵称');
　　END

---测试用例
Update UserWeChat set RealName ='1' where OpenID = 'oXQfVjg_6Ee_REmURzs2-8oFGhGc'

---5.2 INESRT触发器
Alter TRIGGER INSERTCHECK
	ON [UserWeChat]
	FOR INSERT
	AS
	declare @i as nvarchar(128)
	select @i = count(*) from [UserWeChat]
	if @i > 100
		begin
			print('100个奖品已经领取完，下次再来！')
			ROLLBACK TRANSACTION
		end
	else
		begin
			print('添加成功')
		end

---测试用例
insert [UserWeChat] (OpenID, UpdateTime, AddTime, GameType) Values (4, '2015/7/7','2015/7/7',1)

---5.3 DELETE触发器
