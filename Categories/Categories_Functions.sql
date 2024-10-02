CREATE OR ALTER FUNCTION ViewCategories(
	@category_id int,
	@category_name varchar(50)
)

returns @result table(
	Id int,
	category_name varchar(50),
	created_at datetime,
	updated_at DATETIME
)

AS
begin
	if exists(select * from Categories where Id=@category_id or Category_name = @category_name)
	begin 
		insert into @result
		select * from Categories where Id=@category_id or Category_name = @category_name
	end
	else
	begin
		insert into @result
		select * from Categories
	end
	return
end

select * from dbo.ViewCategories(null,null)