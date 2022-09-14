USE Master
GO
IF DB_ID('SuperShopDB') IS NOT NULL
	BEGIN
		ALTER DATABASE SuperShopDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE SuperShopDB
	END
GO
CREATE DATABASE SuperShopDB
GO
USE SuperShopDB
GO

DROP TABLE IF EXISTS Customer
CREATE TABLE [Customer] (
  [Customer_ID] INT PRIMARY KEY IDENTITY(1,1),
  [Username] NVARCHAR(100),
  [Email] NVARCHAR(100),
  [Password] NVARCHAR(100)
);

DROP TABLE IF EXISTS Product
CREATE TABLE [Product] (
  [Product_ID] INT PRIMARY KEY IDENTITY(1,1),
  [Productname] NVARCHAR(100),
  [Price] DECIMAL(6,2)
);

DROP TABLE IF EXISTS [Order]
CREATE TABLE [Order] (
  [Order_ID] INT PRIMARY KEY IDENTITY(1,1),
  [Customer] INT,
  CONSTRAINT [FK_Order.Customer] FOREIGN KEY ([Customer])REFERENCES [Customer]([Customer_ID])
);

CREATE TABLE [ProductOrder] (
	[Product_ID] INT,
	[Order_ID] INT,
	[Amount] INT,
	CONSTRAINT [FK_ProductOrder.ProductID] FOREIGN KEY ([Product_ID]) REFERENCES [Product]([Product_ID]),
	CONSTRAINT [FK_ProductOrder.OrderID] FOREIGN KEY ([Order_ID]) REFERENCES [Order]([Order_ID])
);


INSERT INTO [Order] VALUES (5)
INSERT INTO [ProductOrder] VALUES (13, 2, 10)
INSERT INTO [ProductOrder] VALUES (23, 2, 5)


SELECT Username, Email, STRING_AGG(CONCAT(ProductOrder.Amount,' ',Product.Productname), ', ') as [Shopping Cart] FROM [Order]
JOIN Customer ON [Order].Customer = Customer.Customer_ID
JOIN ProductOrder ON [Order].Order_ID = ProductOrder.Order_ID
JOIN Product ON Product.Product_ID = ProductOrder.Product_ID
GROUP BY Username, Email


SELECT * FROM Product
SELECT * FROM Customer
