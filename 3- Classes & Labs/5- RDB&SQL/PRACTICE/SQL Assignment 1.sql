
CREATE DATABASE Manufacturer

USE Manufacturer

CREATE SCHEMA Product

CREATE SCHEMA Component


CREATE TABLE [Product].[Product](
	[prod_id] INT PRIMARY KEY,
	[prod_name] [VARCHAR](50) NOT NULL,
	[quantity] INT NOT NULL);

CREATE TABLE [Product].[Prod_Comp](
	[prod_id] INT NOT NULL,
	[comp_id] INT NOT NULL,
	[quantity_comp] INT NOT NULL,
	PRIMARY KEY ([prod_id], [comp_id]));


CREATE TABLE [Component].[Component](
	[comp_id] INT PRIMARY KEY,
	[comp_name] VARCHAR(50) NOT NULL,
	[description] VARCHAR(50) NULL,
	[quantity_comp] INT NOT NULL);

CREATE TABLE [Component].[Supplier](
	[supp_id] INT PRIMARY KEY NOT NULL,
	[supp_name] VARCHAR(50) NOT NULL,
	[supp_location] VARCHAR(50) NOT NULL,
	[supp_country] VARCHAR(50) NOT NULL, 
	[is_active] BIT NOT NULL);

CREATE TABLE [Component].[Comp_Supp](
	[supp_id] INT NOT NULL,
	[comp_id] INT NOT NULL,
	[order_date] DATE NOT NULL,
	[quantity] INT NOT NULL,
	PRIMARY KEY ([supp_id], [comp_id]));


ALTER TABLE Product.Prod_Comp 
ADD CONSTRAINT FK_Product FOREIGN KEY (prod_id) REFERENCES Product.Product (prod_id)

ALTER TABLE Product.Prod_Comp 
ADD CONSTRAINT FK_Component FOREIGN KEY (comp_id) REFERENCES Component.Component (comp_id)

ALTER TABLE Component.Comp_Supp 
ADD CONSTRAINT FK_Supplier FOREIGN KEY (supp_id) REFERENCES Component.Supplier (supp_id)

ALTER TABLE Component.Comp_Supp 
ADD CONSTRAINT FK_Component_2 FOREIGN KEY (comp_id) REFERENCES Component.Component (comp_id)
