USE [master]
GO
/****** Object:  Database [SecurityStock]    Script Date: 5/9/2020 10:24:06 AM ******/
CREATE DATABASE [SecurityStock]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SecurityStock', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SecurityStock.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SecurityStock_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SecurityStock_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SecurityStock] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SecurityStock].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SecurityStock] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SecurityStock] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SecurityStock] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SecurityStock] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SecurityStock] SET ARITHABORT OFF 
GO
ALTER DATABASE [SecurityStock] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SecurityStock] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SecurityStock] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SecurityStock] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SecurityStock] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SecurityStock] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SecurityStock] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SecurityStock] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SecurityStock] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SecurityStock] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SecurityStock] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SecurityStock] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SecurityStock] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SecurityStock] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SecurityStock] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SecurityStock] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SecurityStock] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SecurityStock] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SecurityStock] SET  MULTI_USER 
GO
ALTER DATABASE [SecurityStock] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SecurityStock] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SecurityStock] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SecurityStock] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SecurityStock] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SecurityStock] SET QUERY_STORE = OFF
GO
USE [SecurityStock]
GO
/****** Object:  Table [dbo].[TB_GL]    Script Date: 5/9/2020 10:24:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_GL](
	[ID] [numeric](18, 0) NOT NULL,
	[TRADING_DATE] [date] NULL,
	[GAIN_LOSS] [char](1) NULL,
	[SYMBOL] [nvarchar](10) NULL,
	[CLOSE_PRIC] [numeric](18, 2) NULL,
	[PREV_CL_PR] [numeric](18, 2) NULL,
	[PERCENT_CG] [numeric](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_INDEX_SECURITY_MAP]    Script Date: 5/9/2020 10:24:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_INDEX_SECURITY_MAP](
	[INDEX_ID] [numeric](18, 0) NOT NULL,
	[SECURITY_ID] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_PD_TRADE]    Script Date: 5/9/2020 10:24:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_PD_TRADE](
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[SECURITY_ID] [numeric](18, 0) NOT NULL,
	[TRADING_DATE] [date] NOT NULL,
	[PREV_CL_PR] [numeric](18, 2) NOT NULL,
	[OPEN_PRICE] [numeric](18, 2) NOT NULL,
	[HIGH_PRICE] [numeric](18, 2) NOT NULL,
	[LOW_PRICE] [numeric](18, 2) NOT NULL,
	[CLOSE_PRICE] [numeric](18, 2) NOT NULL,
	[NET_TRDVAL] [numeric](18, 2) NULL,
	[NET_TRDQTY] [numeric](18, 2) NULL,
	[IND_SEC] [char](1) NULL,
	[CORP_IND] [nvarchar](100) NULL,
	[TRADES] [numeric](18, 2) NULL,
	[HI_52_WK] [numeric](18, 2) NOT NULL,
	[LO_52_WK] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK__TB_PD_TR__3214EC2744A5D5A5] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_SECURITY]    Script Date: 5/9/2020 10:24:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_SECURITY](
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[SYMBOL] [nvarchar](15) NULL,
	[SECURITY_NAME] [nvarchar](100) NOT NULL,
	[MKT] [nvarchar](10) NOT NULL,
	[SERIES] [nvarchar](10) NULL,
 CONSTRAINT [PK__TB_SECUR__3214EC27FFC78F5C] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_TB_PD_SECURITY]    Script Date: 5/9/2020 10:24:14 AM ******/
CREATE NONCLUSTERED INDEX [IX_TB_PD_SECURITY] ON [dbo].[TB_PD_TRADE]
(
	[SECURITY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_TB_PD_TRADE_DATE]    Script Date: 5/9/2020 10:24:14 AM ******/
CREATE NONCLUSTERED INDEX [IX_TB_PD_TRADE_DATE] ON [dbo].[TB_PD_TRADE]
(
	[TRADING_DATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_PD_TRADE] ADD  CONSTRAINT [DF_TB_PD_TRADE_TRADING_DATE]  DEFAULT (getdate()) FOR [TRADING_DATE]
GO
ALTER TABLE [dbo].[TB_PD_TRADE] ADD  CONSTRAINT [DF_TB_PD_TRADE_PREV_CL_PR]  DEFAULT ((0)) FOR [PREV_CL_PR]
GO
ALTER TABLE [dbo].[TB_PD_TRADE] ADD  CONSTRAINT [DF_TB_PD_TRADE_OPEN_PRICE]  DEFAULT ((0)) FOR [OPEN_PRICE]
GO
ALTER TABLE [dbo].[TB_PD_TRADE] ADD  CONSTRAINT [DF_TB_PD_TRADE_HIGH_PRICE]  DEFAULT ((0)) FOR [HIGH_PRICE]
GO
ALTER TABLE [dbo].[TB_PD_TRADE] ADD  CONSTRAINT [DF_TB_PD_TRADE_LOW_PRICE]  DEFAULT ((0)) FOR [LOW_PRICE]
GO
ALTER TABLE [dbo].[TB_PD_TRADE] ADD  CONSTRAINT [DF_TB_PD_TRADE_CLOSE_PRICE]  DEFAULT ((0)) FOR [CLOSE_PRICE]
GO
ALTER TABLE [dbo].[TB_PD_TRADE] ADD  CONSTRAINT [DF_TB_PD_TRADE_HI_52_WK]  DEFAULT ((0)) FOR [HI_52_WK]
GO
ALTER TABLE [dbo].[TB_PD_TRADE] ADD  CONSTRAINT [DF_TB_PD_TRADE_LO_52_WK]  DEFAULT ((0)) FOR [LO_52_WK]
GO
ALTER TABLE [dbo].[TB_INDEX_SECURITY_MAP]  WITH CHECK ADD  CONSTRAINT [FK_TB_INDEX_SECURITY_MAP_TB_SECURITY] FOREIGN KEY([INDEX_ID])
REFERENCES [dbo].[TB_SECURITY] ([ID])
GO
ALTER TABLE [dbo].[TB_INDEX_SECURITY_MAP] CHECK CONSTRAINT [FK_TB_INDEX_SECURITY_MAP_TB_SECURITY]
GO
ALTER TABLE [dbo].[TB_INDEX_SECURITY_MAP]  WITH CHECK ADD  CONSTRAINT [FK_TB_INDEX_SECURITY_MAP_TB_SECURITY1] FOREIGN KEY([SECURITY_ID])
REFERENCES [dbo].[TB_SECURITY] ([ID])
GO
ALTER TABLE [dbo].[TB_INDEX_SECURITY_MAP] CHECK CONSTRAINT [FK_TB_INDEX_SECURITY_MAP_TB_SECURITY1]
GO
ALTER TABLE [dbo].[TB_PD_TRADE]  WITH CHECK ADD  CONSTRAINT [FK_TB_PD_TRADE_TB_SECURITY] FOREIGN KEY([SECURITY_ID])
REFERENCES [dbo].[TB_SECURITY] ([ID])
GO
ALTER TABLE [dbo].[TB_PD_TRADE] CHECK CONSTRAINT [FK_TB_PD_TRADE_TB_SECURITY]
GO
/****** Object:  StoredProcedure [dbo].[GetSecurities]    Script Date: 5/9/2020 10:24:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSecurities] 
AS
BEGIN
	SELECT * FROM TB_SECURITY; 
END
	--Exec GetSecurities ;
GO
/****** Object:  StoredProcedure [dbo].[GetSecurityStatus]    Script Date: 5/9/2020 10:24:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSecurityStatus] 
(@Id NUMERIC(18,0), @FromDate DATE, @ToDate DATE)
AS
BEGIN
	SELECT s.SYMBOL,s.MKT,s.SERIES,s.SECURITY_NAME , t.* 
	FROM TB_SECURITY s INNER JOIN TB_PD_TRADE t ON t.SECURITY_ID = s.ID
	WHERE s.ID = @Id AND t.TRADING_DATE BETWEEN @FromDate AND @ToDate; 
END
	--Exec GetSecurityStatus 150, '01/May/2020', '31/May/2020';
GO
/****** Object:  StoredProcedure [dbo].[ImportDailyPdData]    Script Date: 5/9/2020 10:24:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ImportDailyPdData]
(@Data NVARCHAR(MAX), @TradingDate DATE)
AS
BEGIN
	DECLARE @IsExist INT;
	DECLARE @SecurityId Numeric(18,0);
	DECLARE @IndexId Numeric(18,0);
	DECLARE @MKT	     NVARCHAR(1);
	DECLARE @SERIES	     NVARCHAR(10);
	DECLARE @SYMBOL	     NVARCHAR(50);
	DECLARE @INDEX_NAME	 NVARCHAR(100);
	DECLARE @TRADING_DATE	 DATE;
	DECLARE @SECURITY_NAME	 NVARCHAR(100);
	DECLARE @PREV_CL_PR	 Numeric(18,2);
	DECLARE @OPEN_PRICE	 Numeric(18,2);
	DECLARE @HIGH_PRICE	 Numeric(18,2);
	DECLARE @LOW_PRICE	 Numeric(18,2);
	DECLARE @CLOSE_PRICE	 Numeric(18,2);
	DECLARE @NET_TRDVAL	 Numeric(18,2);
	DECLARE @NET_TRDQTY	 Numeric(18,2);
	DECLARE @IND_SEC	     NVARCHAR(100);
	DECLARE @CORP_IND	 NVARCHAR(100);
	DECLARE @TRADES	     Numeric(18,2);
	DECLARE @HI_52_WK	 Numeric(18,2);
	DECLARE @LO_52_WK     Numeric(18,2);
		
	BEGIN TRY
		BEGIN TRANSACTION tr
		
		DELETE FROM TB_PD_TRADE WHERE TRADING_DATE = @tradingdate;
		
		
		DECLARE cur CURSOR LOCAL FAST_FORWARD
			FOR
				SELECT *  
				FROM OPENJSON(@data)  
				  WITH (
						MKT NVARCHAR(1) '$.SecurityInfo.MKT',
						SERIES NVARCHAR(10) '$.SecurityInfo.SERIES',
						SYMBOL NVARCHAR(50) '$.SecurityInfo.SYMBOL',
						SECURITY_NAME NVARCHAR(100) '$.SecurityInfo.SECURITY_NAME', 
						INDEX_NAME NVARCHAR(50) '$.SecurityInfo.INDEX_NAME',
						TRADING_DATE DATE '$.TRADING_DATE',
						PREV_CL_PR numeric(18,2) '$.PREV_CL_PR',
						OPEN_PRICE numeric(18,2) '$.OPEN_PRICE',
						HIGH_PRICE numeric(18,2) '$.HIGH_PRICE',
						LOW_PRICE numeric(18,2) '$.LOW_PRICE',
						CLOSE_PRICE numeric(18,2) '$.CLOSE_PRICE',
						NET_TRDVAL numeric(18,2) '$.NET_TRDVAL',
						NET_TRDQTY numeric(18,2) '$.NET_TRDQTY',
						IND_SEC NVARCHAR(100) '$.IND_SEC',
						CORP_IND NVARCHAR(100) '$.CORP_IND',
						TRADES numeric(18,2) '$.TRADES',
						HI_52_WK numeric(18,2) '$.HI_52_WK',
						LO_52_WK numeric(18,2) '$.LO_52_WK'
				  )
			OPEN cur
			FETCH NEXT
			FROM cur         
			INTO @MKT	     ,
			     @SERIES	 ,
			     @SYMBOL	 ,
			     @SECURITY_NAME	 ,
				 @INDEX_NAME,
				 @TRADING_DATE,
			     @PREV_CL_PR ,
			     @OPEN_PRICE ,
			     @HIGH_PRICE ,
			     @LOW_PRICE	 ,
			     @CLOSE_PRICE,
			     @NET_TRDVAL ,
			     @NET_TRDQTY ,
			     @IND_SEC	 ,
			     @CORP_IND	 ,
			     @TRADES	 ,
			     @HI_52_WK	 ,
			     @LO_52_WK  

			WHILE @@FETCH_STATUS = 0
			BEGIN
				-- Logic
				SELECT @SecurityId = IsNull(Max(Id), 0)
				FROM TB_SECURITY
				WHERE SECURITY_NAME = Rtrim(Ltrim(@SECURITY_NAME)); 

				IF (@SecurityId = 0)
				BEGIN
					INSERT INTO TB_SECURITY (SYMBOL
						,SECURITY_NAME
						,MKT
						,SERIES)
					VALUES (@SYMBOL
						,@SECURITY_NAME
						,@MKT
						,@SERIES);
						
					SET @SecurityId = SCOPE_IDENTITY();
					
					PRINT @SecurityId
					--IF (LTRIM(RTRIM(@SYMBOL)) <> '')
					--BEGIN
					--	SELECT @IndexId = IsNull(Max(Id), 0)
					--	FROM TB_SECURITY
					--	WHERE SECURITY_NAME = Rtrim(Ltrim(@INDEX_NAME));
					--	
					--	INSERT INTO TB_INDEX_SECURITY_MAP VALUES (@IndexId,@SecurityId);
					--END;
				END 

				INSERT INTO TB_PD_TRADE (
						SECURITY_ID,
						TRADING_DATE,
						PREV_CL_PR , 
						OPEN_PRICE , 
						HIGH_PRICE , 
						LOW_PRICE	 , 
						CLOSE_PRICE, 
						NET_TRDVAL , 
						NET_TRDQTY , 
						IND_SEC	 , 
						CORP_IND	 , 
						TRADES	 , 
						HI_52_WK	 , 
						LO_52_WK)
					VALUES (
						@SecurityId,
						@tradingdate,
						@PREV_CL_PR, 
						@OPEN_PRICE, 
						@HIGH_PRICE, 
						@LOW_PRICE, 
						@CLOSE_PRICE, 
						@NET_TRDVAL, 
						@NET_TRDQTY, 
						@IND_SEC, 
						@CORP_IND, 
						@TRADES	 , 
						@HI_52_WK, 
						@LO_52_WK); 
				
				FETCH NEXT
				FROM cur
				INTO @MKT	     ,
			     @SERIES	 ,
			     @SYMBOL	 ,
			     @SECURITY_NAME	 ,
				 @INDEX_NAME,
				 @TRADING_DATE,
			     @PREV_CL_PR ,
			     @OPEN_PRICE ,
			     @HIGH_PRICE ,
			     @LOW_PRICE	 ,
			     @CLOSE_PRICE,
			     @NET_TRDVAL ,
			     @NET_TRDQTY ,
			     @IND_SEC	 ,
			     @CORP_IND	 ,
			     @TRADES	 ,
			     @HI_52_WK	 ,
			     @LO_52_WK   
			END

		CLOSE cur

		DEALLOCATE cur

		COMMIT TRANSACTION tr
	END TRY
	
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT @ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE();

		ROLLBACK TRANSACTION tr

		RAISERROR (
				@ErrorMessage
				,-- Message text.  
				@ErrorSeverity
				,-- Severity.  
				@ErrorState -- State.  
				);
	END CATCH		
END
	--Exec ImportDailyData N'[{}]';
GO
USE [master]
GO
ALTER DATABASE [SecurityStock] SET  READ_WRITE 
GO
