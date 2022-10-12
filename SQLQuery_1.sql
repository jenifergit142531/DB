select * from one

insert into one values(101,'aaa')
create table Product  
(  
      ProductId int primary key,  
      ProductName varchar(20) unique,  
      ProductQty int,  
      ProductPrice float  
)  

insert product values(1,'Printer',10,4500)  
insert product values(2,'Scanner',15,3500)  
insert product values(3,'Mouse',45,500)  
select * from product


create procedure prcInsert   
@id int,  
@name varchar(40),  
@qty int,  
@price float  
as  
begin  
 declare @cnt int  
 declare @p float  
 select @cnt=COUNT(ProductId)from Product where ProductName=@name  
 if(@cnt>0)  
 begin  
  update Product set ProductQty=ProductQty+@qty where ProductName=@name  
  select @p=ProductPrice from Product where ProductName=@name  
  if(@p<@price)  
  begin  
   update Product set ProductPrice=@price where ProductName=@name  
  end  
 end  
 else  
 begin  
  insert Product values(@id,@name,@qty,@price)  
 end  
end   

exec prcInsert @id=2,@name='scanner',@qty=3,@price=1600


exec prcInsert @id=4,@name='Iphone',@qty=10,@price=25000

-- creating case statement in stored procedure

Create procedure Sp_CaseStatement  
As  
Begin  
set NoCount ON;  
select  case Product.ProductName when 'Printer' Then 'Printer(400)'  
when 'Scanner' Then 'Scanner(100)'  
when 'Mouse' Then 'Mouse(200)'  
when 'Iphone' Then 'Iphone(300)'   
else 'UnKnown' end as 'Your Contribution Counts'  
from Product 
end 


exec Sp_CaseStatement


CREATE TABLE ProductDescription
(ProductID INT, ProductDescription VARCHAR(800) )


-- create procedure with parameter

CREATE PROCEDURE GetProductDesc_withparameters
(@PID INT)
AS
BEGIN
SET NOCOUNT ON
 
SELECT P.ProductID,P.ProductName,PD.ProductDescription  FROM 
Product P
INNER JOIN ProductDescription PD ON P.ProductID=PD.ProductID
WHERE P.ProductID=@PID
END

EXEC GetProductDesc_withparameters 2

--Creating a stored procedure with default parameters values

CREATE PROCEDURE GetProductDesc_withDefaultparameters
(@PID INT =2)
AS
BEGIN
SET NOCOUNT ON
 
SELECT P.ProductID,P.ProductName,PD.ProductDescription  FROM 
Product P
INNER JOIN ProductDescription PD ON P.ProductID=PD.ProductID
WHERE P.ProductID=@PID
 
END

EXEC GetProductDesc_withparameters 3

-- create encrypted procedure

--We can hide the source code in the stored procedure by creating the procedure with the “ENCRYPTION” option.

CREATE PROCEDURE GetProduct
WITH ENCRYPTION
AS
BEGIN
SET NOCOUNT ON 
 
SELECT ProductId,ProductName from Product
END

sp_helptext GetProduct