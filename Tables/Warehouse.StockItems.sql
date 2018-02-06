CREATE TABLE [Warehouse].[StockItems]
(
[StockItemID] [int] NOT NULL CONSTRAINT [DF_Warehouse_StockItems_StockItemID] DEFAULT (NEXT VALUE FOR [Sequences].[StockItemID]),
[StockItemName] [nvarchar] (100) COLLATE Latin1_General_100_CI_AS NOT NULL,
[SupplierID] [int] NOT NULL,
[ColorID] [int] NULL,
[UnitPackageID] [int] NOT NULL,
[OuterPackageID] [int] NOT NULL,
[Brand] [nvarchar] (50) COLLATE Latin1_General_100_CI_AS NULL,
[Size] [nvarchar] (20) COLLATE Latin1_General_100_CI_AS NULL,
[LeadTimeDays] [int] NOT NULL,
[QuantityPerOuter] [int] NOT NULL,
[IsChillerStock] [bit] NOT NULL,
[Barcode] [nvarchar] (50) COLLATE Latin1_General_100_CI_AS NULL,
[TaxRate] [decimal] (18, 3) NOT NULL,
[UnitPrice] [decimal] (18, 2) NOT NULL,
[RecommendedRetailPrice] [decimal] (18, 2) NULL,
[TypicalWeightPerUnit] [decimal] (18, 3) NOT NULL,
[MarketingComments] [nvarchar] (max) COLLATE Latin1_General_100_CI_AS NULL,
[InternalComments] [nvarchar] (max) COLLATE Latin1_General_100_CI_AS NULL,
[Photo] [varbinary] (max) NULL,
[CustomFields] [nvarchar] (max) COLLATE Latin1_General_100_CI_AS NULL,
[Tags] AS (json_query([CustomFields],N'$.Tags')),
[SearchDetails] AS (concat([StockItemName],N' ',[MarketingComments])),
[LastEditedBy] [int] NOT NULL,
[ValidFrom] [datetime2] GENERATED ALWAYS AS ROW START NOT NULL,
[ValidTo] [datetime2] GENERATED ALWAYS AS ROW END NOT NULL,
PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo),
CONSTRAINT [PK_Warehouse_StockItems] PRIMARY KEY CLUSTERED  ([StockItemID]) ON [USERDATA]
) ON [USERDATA] TEXTIMAGE_ON [USERDATA]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [Warehouse].[StockItems_Archive])
)
GO
CREATE NONCLUSTERED INDEX [FK_Warehouse_StockItems_ColorID] ON [Warehouse].[StockItems] ([ColorID]) ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Warehouse_StockItems_OuterPackageID] ON [Warehouse].[StockItems] ([OuterPackageID]) ON [USERDATA]
GO
ALTER TABLE [Warehouse].[StockItems] ADD CONSTRAINT [UQ_Warehouse_StockItems_StockItemName] UNIQUE NONCLUSTERED  ([StockItemName]) ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Warehouse_StockItems_SupplierID] ON [Warehouse].[StockItems] ([SupplierID]) ON [USERDATA]
GO
CREATE NONCLUSTERED INDEX [FK_Warehouse_StockItems_UnitPackageID] ON [Warehouse].[StockItems] ([UnitPackageID]) ON [USERDATA]
GO
ALTER TABLE [Warehouse].[StockItems] ADD CONSTRAINT [FK_Warehouse_StockItems_Application_People] FOREIGN KEY ([LastEditedBy]) REFERENCES [Application].[People] ([PersonID])
GO
ALTER TABLE [Warehouse].[StockItems] ADD CONSTRAINT [FK_Warehouse_StockItems_ColorID_Warehouse_Colors] FOREIGN KEY ([ColorID]) REFERENCES [Warehouse].[Colors] ([ColorID])
GO
ALTER TABLE [Warehouse].[StockItems] ADD CONSTRAINT [FK_Warehouse_StockItems_OuterPackageID_Warehouse_PackageTypes] FOREIGN KEY ([OuterPackageID]) REFERENCES [Warehouse].[PackageTypes] ([PackageTypeID])
GO
ALTER TABLE [Warehouse].[StockItems] ADD CONSTRAINT [FK_Warehouse_StockItems_SupplierID_Purchasing_Suppliers] FOREIGN KEY ([SupplierID]) REFERENCES [Purchasing].[Suppliers] ([SupplierID])
GO
ALTER TABLE [Warehouse].[StockItems] ADD CONSTRAINT [FK_Warehouse_StockItems_UnitPackageID_Warehouse_PackageTypes] FOREIGN KEY ([UnitPackageID]) REFERENCES [Warehouse].[PackageTypes] ([PackageTypeID])
GO
EXEC sp_addextendedproperty N'Description', N'Main entity table for stock items', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', NULL, NULL
GO
EXEC sp_addextendedproperty N'Description', 'Barcode for this stock item', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'Barcode'
GO
EXEC sp_addextendedproperty N'Description', 'Brand for the stock item (if the item is branded)', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'Brand'
GO
EXEC sp_addextendedproperty N'Description', 'Color (optional) for this stock item', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'ColorID'
GO
EXEC sp_addextendedproperty N'Description', 'Custom fields added by system users', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'CustomFields'
GO
EXEC sp_addextendedproperty N'Description', 'Internal comments (not exposed outside organization)', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'InternalComments'
GO
EXEC sp_addextendedproperty N'Description', 'Does this stock item need to be in a chiller?', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'IsChillerStock'
GO
EXEC sp_addextendedproperty N'Description', 'Number of days typically taken from order to receipt of this stock item', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'LeadTimeDays'
GO
EXEC sp_addextendedproperty N'Description', 'Marketing comments for this stock item (shared outside the organization)', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'MarketingComments'
GO
EXEC sp_addextendedproperty N'Description', 'Usual package for selling outers of this stock item (ie cartons, boxes, etc.)', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'OuterPackageID'
GO
EXEC sp_addextendedproperty N'Description', 'Photo of the product', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'Photo'
GO
EXEC sp_addextendedproperty N'Description', 'Quantity of the stock item in an outer package', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'QuantityPerOuter'
GO
EXEC sp_addextendedproperty N'Description', 'Recommended retail price for this stock item', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'RecommendedRetailPrice'
GO
EXEC sp_addextendedproperty N'Description', 'Combination of columns used by full text search', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'SearchDetails'
GO
EXEC sp_addextendedproperty N'Description', 'Size of this item (eg: 100mm)', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'Size'
GO
EXEC sp_addextendedproperty N'Description', 'Numeric ID used for reference to a stock item within the database', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'StockItemID'
GO
EXEC sp_addextendedproperty N'Description', 'Full name of a stock item (but not a full description)', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'StockItemName'
GO
EXEC sp_addextendedproperty N'Description', 'Usual supplier for this stock item', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'SupplierID'
GO
EXEC sp_addextendedproperty N'Description', 'Advertising tags associated with this stock item (JSON array retrieved from CustomFields)', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'Tags'
GO
EXEC sp_addextendedproperty N'Description', 'Tax rate to be applied', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'TaxRate'
GO
EXEC sp_addextendedproperty N'Description', 'Typical weight for one unit of this product (packaged)', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'TypicalWeightPerUnit'
GO
EXEC sp_addextendedproperty N'Description', 'Usual package for selling units of this stock item', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'UnitPackageID'
GO
EXEC sp_addextendedproperty N'Description', 'Selling price (ex-tax) for one unit of this product', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'COLUMN', N'UnitPrice'
GO
EXEC sp_addextendedproperty N'Description', 'Auto-created to support a foreign key', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'INDEX', N'FK_Warehouse_StockItems_ColorID'
GO
EXEC sp_addextendedproperty N'Description', 'Auto-created to support a foreign key', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'INDEX', N'FK_Warehouse_StockItems_OuterPackageID'
GO
EXEC sp_addextendedproperty N'Description', 'Auto-created to support a foreign key', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'INDEX', N'FK_Warehouse_StockItems_SupplierID'
GO
EXEC sp_addextendedproperty N'Description', 'Auto-created to support a foreign key', 'SCHEMA', N'Warehouse', 'TABLE', N'StockItems', 'INDEX', N'FK_Warehouse_StockItems_UnitPackageID'
GO
