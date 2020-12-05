DROP TABLE IF EXISTS [dbo].[Plant]

CREATE TABLE dbo.Plant (
	PlantID int IDENTITY(1,1) NOT NULL,
	NickName nvarchar(100) NOT NULL,
	NameShort nvarchar(50) NOT NULL,
	NameLong nvarchar(150) NULL,
	DescriptionShort nvarchar(300) NOT NULL,
	DescriptionLong nvarchar(1000) NULL,
	DatePurchased DATETIME NOT NULL,
	PRIMARY KEY (PlantID)
)

INSERT INTO dbo.Plant (
	NickName,
	NameShort,
	NameLong,
	DescriptionShort,
	DatePurchased
)
VALUES (
	N'Jezza',
	N'ZZ plant',
	N'Zamioculcas zamiifolia',
	N'The ZZ plant is an aroid family member that is native to dry grassland and forest in Eastern Africa. It is a stemless evergreen plant that typically grows to 3 tall with attractive, pinnately compound leaves rising up from its rhizomes.',
	2020-28-04
)

INSERT INTO dbo.PlantMedia (
	MediaTypeID,
	MediaID,
	PlantID
)
VALUES (
	1,
	N'17e24d43ef8f46f997720b0185412505.jpeg',
	1
)

INSERT INTO dbo.Plant (
	NickName,
	NameShort,
	NameLong,
	DescriptionShort,
	DatePurchased
)
VALUES (
	N'Harold',
	N'Arrowhead plant',
	N'Syngonium podophyllum',
	N'The arrowhead plant goes by numerous names, including arrowhead vine, American evergreen, five fingers, and nephthytis.The arrowhead plant can be grown alone or in a mixed planting for additional interest.',
	2020-30-04
)

INSERT INTO dbo.PlantMedia (
	MediaTypeID,
	MediaID,
	PlantID
)
VALUES (
	1,
	N'27e4f31d23854cde8ff27258e3bba6e9.jpg',
	2
)

INSERT INTO dbo.Plant (
	NickName,
	NameShort,
	NameLong,
	DescriptionShort,
	DatePurchased
)
VALUES (
	N'Dennis',
	N'Goldon Pothos',
	N'Epipremnum aureum',
	N'Goldon Pothos is a species of flowering plant in the arum family Araceae, native to Moorea in the Society Islands of French Polynesia. It is also called devils vine or devils ivy because it is almost impossible to kill and it stays green even when kept in the dark.',
	2020-30-04
)

INSERT INTO dbo.PlantMedia (
	MediaTypeID,
	MediaID,
	PlantID
)
VALUES (
	1,
	N'd2d5ab5f7bec4e06aec8ba37401487d6.jpg',
	3
)

INSERT INTO dbo.Plant (
	NickName,
	NameShort,
	NameLong,
	DescriptionShort,
	DatePurchased
)
VALUES (
	N'Wallace',
	N'Swiss Cheese plant',
	N'Monstera Adansonii',
	N'The Swiss cheese plant, Monstera adansonii, gets its name from its large, heart-shaped leaves, which as it ages, become covered with holes that resemble Swiss cheese.',
	2020-05-05
)

INSERT INTO dbo.PlantMedia (
	MediaTypeID,
	MediaID,
	PlantID
)
VALUES (
	1,
	N'26977e6c7f3d40738f9e4feb03db509c.jpeg',
	4
)