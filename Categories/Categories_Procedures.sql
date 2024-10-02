
-- Insert Procedur

CREATE OR ALTER PROCEDURE dbo.InsertNewCategory 
    @Category_name varchar(50) = ''
AS
    insert into dbo.Categories (Category_name, created_at) values (@Category_name, CAST( GETDATE() as DATETIME))

exec InsertNewCategory @category_name='ÓÑæ' 

-- Update Procedur
CREATE OR ALTER PROCEDURE dbo.UpdateCategory 
	@category_id INT ,
    @New_category_name varchar(50) = ''
AS
	

	if exists(select * from Categories where Category_name = @New_category_name)
	begin
		return 'This category is exists in database'
	end

    update Categories set Category_name = @New_category_name where Id = @category_id

 exec UpdateCategory @category_id=2 , @New_category_name='edits'

-- Delete Procedur
CREATE OR ALTER PROCEDURE dbo.DeleteCategory 
	@category_id INT 
AS
	if not exists(select * from Categories where Id = @category_id)
	begin
		return 'This category is not exists in database'
	end

    delete from Categories where Id = @category_id


usage: exec DeleteCategory @category_id=1

