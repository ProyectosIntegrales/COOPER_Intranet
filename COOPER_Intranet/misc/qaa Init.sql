USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblAreas]    Script Date: 01/15/2013 11:15:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[tblAreas]') AND type in (N'U'))
DROP TABLE [qaa].[tblAreas]
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblAreas]    Script Date: 01/15/2013 11:15:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [qaa].[tblAreas](
	[areaID] [int] IDENTITY(1,1) NOT NULL,
	[areaMnemonic] [nchar](10) NULL,
	[areaName] [varchar](100) NULL,
 CONSTRAINT [PK_tblAreas_2] PRIMARY KEY CLUSTERED 
(
	[areaID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblAuditData]    Script Date: 01/15/2013 11:15:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[tblAuditData]') AND type in (N'U'))
DROP TABLE [qaa].[tblAuditData]
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblAuditData]    Script Date: 01/15/2013 11:15:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [qaa].[tblAuditData](
	[dataID] [int] IDENTITY(1,1) NOT NULL,
	[auditDate] [datetime] NULL,
	[userID] [int] NULL,
	[areaID] [int] NULL,
	[workOrder] [varchar](50) NULL,
	[partNo] [varchar](50) NULL,
	[lotPlan] [int] NULL,
	[lotQty] [int] NULL,
	[samSize] [int] NULL,
	[comments] [text] NULL,
	[dr] [varchar](50) NULL,
	[datecode] [varchar](50) NULL,
	[rewQty] [int] NULL,
	[accQty] [int] NULL,
 CONSTRAINT [PK_tblAuditData] PRIMARY KEY CLUSTERED 
(
	[dataID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblAuditDefectos]    Script Date: 01/15/2013 11:16:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[tblAuditDefectos]') AND type in (N'U'))
DROP TABLE [qaa].[tblAuditDefectos]
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblAuditDefectos]    Script Date: 01/15/2013 11:16:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [qaa].[tblAuditDefectos](
	[dataID] [int] NULL,
	[defectoID] [int] NULL,
	[defectoQty] [int] NULL
) ON [PRIMARY]

GO

 USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblDefectos]    Script Date: 01/15/2013 11:17:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[tblDefectos]') AND type in (N'U'))
DROP TABLE [qaa].[tblDefectos]
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblDefectos]    Script Date: 01/15/2013 11:17:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [qaa].[tblDefectos](
	[defectoID] [int] NOT NULL,
	[defectoDescription] [varchar](100) NULL,
 CONSTRAINT [PK_tblDefectos] PRIMARY KEY CLUSTERED 
(
	[defectoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblOrders]    Script Date: 01/15/2013 11:17:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[tblOrders]') AND type in (N'U'))
DROP TABLE [qaa].[tblOrders]
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblOrders]    Script Date: 01/15/2013 11:17:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [qaa].[tblOrders](
	[orderNo] [varchar](50) NOT NULL,
	[areaID] [int] NULL,
	[auditorID] [int] NULL,
	[lotPlan] [int] NULL,
	[partNo] [varchar](50) NULL,
	[dateCode] [varchar](50) NULL,
	[lotQty] [int] NULL,
	[dateIn] [datetime] NULL,
 CONSTRAINT [PK_tblOrders] PRIMARY KEY CLUSTERED 
(
	[orderNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblPartsByArea]    Script Date: 01/15/2013 11:17:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[tblPartsByArea]') AND type in (N'U'))
DROP TABLE [qaa].[tblPartsByArea]
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblPartsByArea]    Script Date: 01/15/2013 11:17:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [qaa].[tblPartsByArea](
	[areaID] [int] NULL,
	[partNo] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

 USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblPrivs]    Script Date: 01/15/2013 11:18:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[tblPrivs]') AND type in (N'U'))
DROP TABLE [qaa].[tblPrivs]
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblPrivs]    Script Date: 01/15/2013 11:18:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [qaa].[tblPrivs](
	[privID] [int] NOT NULL,
	[privDesc] [varchar](50) NULL,
 CONSTRAINT [PK_tblPrivs_1] PRIMARY KEY CLUSTERED 
(
	[privID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblUsers]    Script Date: 01/15/2013 11:18:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[tblUsers]') AND type in (N'U'))
DROP TABLE [qaa].[tblUsers]
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [qaa].[tblUsers]    Script Date: 01/15/2013 11:18:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [qaa].[tblUsers](
	[userID] [int] NOT NULL,
	[userPriv] [int] NULL,
 CONSTRAINT [PK_tblUsers_2] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [COOPER_Intranet]
GO

/****** Object:  View [qaa].[vAreasPre]    Script Date: 01/15/2013 11:18:35 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[qaa].[vAreasPre]'))
DROP VIEW [qaa].[vAreasPre]
GO

USE [COOPER_Intranet]
GO

/****** Object:  View [qaa].[vAreasPre]    Script Date: 01/15/2013 11:18:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [qaa].[vAreasPre]
AS
SELECT     deptoMnemonic as areaMnemonic, left(deptoName,1) + lower(substring(deptoName,2,100)) as areaName
FROM         dbo.tblDeptos

union

select areaMnemonic, areaName
from dbo.tblAreas

union

select celdaMnemonic, celdaname
from cdd.tblCeldas


GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[15] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblDeptos"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 322
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'qaa', @level1type=N'VIEW',@level1name=N'vAreasPre'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'qaa', @level1type=N'VIEW',@level1name=N'vAreasPre'
GO

USE [COOPER_Intranet]
GO

/****** Object:  View [qaa].[vUsers]    Script Date: 01/15/2013 11:18:56 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[qaa].[vUsers]'))
DROP VIEW [qaa].[vUsers]
GO

USE [COOPER_Intranet]
GO

/****** Object:  View [qaa].[vUsers]    Script Date: 01/15/2013 11:18:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [qaa].[vUsers]
AS
SELECT     tblUsers_1.userName, tblUsers_1.userFirstName + ' ' + tblUsers_1.userLastName AS userFullname, tblUsers_1.userEmployeeNo, tblUsers_1.userDept, 
                      tblUsers_1.userEMailAddress, qaa.tblUsers.userID, qaa.tblUsers.userPriv, dbo.tblDeptos.deptoMnemonic AS mgrOfDepto, 
                      dbo.fGetEngAreas(tblUsers_1.userEmployeeNo, N'MFG') AS mfgEngOf, dbo.fGetEngAreas(tblUsers_1.userEmployeeNo, N'CAL') AS calEngOf
FROM         dbo.tblAreas RIGHT OUTER JOIN
                      qaa.tblUsers INNER JOIN
                      dbo.tblUsers AS tblUsers_1 ON qaa.tblUsers.userID = tblUsers_1.userId ON dbo.tblAreas.areaCalEng = tblUsers_1.userEmployeeNo LEFT OUTER JOIN
                      dbo.tblDeptos ON tblUsers_1.userEmployeeNo = dbo.tblDeptos.deptoManagerNo
GROUP BY tblUsers_1.userName, tblUsers_1.userFirstName + ' ' + tblUsers_1.userLastName, tblUsers_1.userEmployeeNo, tblUsers_1.userDept, 
                      tblUsers_1.userEMailAddress, qaa.tblUsers.userID, qaa.tblUsers.userPriv, dbo.tblDeptos.deptoMnemonic, dbo.fGetEngAreas(tblUsers_1.userEmployeeNo, N'CAL')

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblAreas"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblUsers_1"
            Begin Extent = 
               Top = 131
               Left = 398
               Bottom = 315
               Right = 587
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblDeptos"
            Begin Extent = 
               Top = 131
               Left = 39
               Bottom = 318
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblUsers (qaa)"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 95
               Right = 428
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = ' , @level0type=N'SCHEMA',@level0name=N'qaa', @level1type=N'VIEW',@level1name=N'vUsers'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'qaa', @level1type=N'VIEW',@level1name=N'vUsers'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'qaa', @level1type=N'VIEW',@level1name=N'vUsers'
GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [qaa].[spAreas]    Script Date: 01/15/2013 11:19:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[spAreas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [qaa].[spAreas]
GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [qaa].[spAreas]    Script Date: 01/15/2013 11:19:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Gabriel Estrada
-- Create date: Ene 11, 2013
-- Description:	Update Defectos
-- =============================================
create PROCEDURE [qaa].[spAreas]
	-- Add the parameters for the stored procedure here
	@action nchar(3),
	@areaID int = 0,
	@areaMnemonic nchar(10) = '',
	@areaName  varchar(100) = ''

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @action = 'ADD' 
	INSERT INTO qaa.tblAreas
			(areaMnemonic, areaName)
	VALUES (@areaMnemonic, @areaName)

    IF @action = 'UPD' 
	UPDATE qaa.tblAreas 
		SET areaMnemonic = @areaMnemonic,
			areaname = @areaName
	WHERE areaID = @areaID
		
	IF @action = 'DEL'
	DELETE qaa.tblAreas WHERE areaID = @areaID
	
	END


GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [qaa].[spAuditData]    Script Date: 01/15/2013 11:19:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[spAuditData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [qaa].[spAuditData]
GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [qaa].[spAuditData]    Script Date: 01/15/2013 11:19:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Gabriel Estrada
-- Create date: Ene 11, 2013
-- Description:	Update Defectos
-- =============================================
create PROCEDURE [qaa].[spAuditData]
	-- Add the parameters for the stored procedure here
	@action nchar(3),
	@dataID int = 0,
	@auditDate datetime = '1/1/1900',
	@userID int = 0,
	@areaID int = 0,
	@workOrder varchar(50) = '',
	@partNo varchar(50) = '',
	@lotPlan int = 0,
	@lotQty int = 0,
	@samSize int = 0,
	@comments text = '',
	@dr varchar(50) = '',
	@datecode varchar(50) = '',
	@rewQty int = 0,
	@accQty int = 0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @action = 'ADD' 
	INSERT INTO qaa.tblAuditData
			(auditDate, userID, areaID, workOrder, partNo, lotPlan, lotQty, samSize, comments, dr, datecode, rewQty, accQty)
	VALUES (@auditDate, @userID, @areaID, @workOrder, @partNo, @lotPlan, @lotQty, @samSize, @comments, @dr, @datecode, @rewQty, @accQty)

    IF @action = 'UPD' 
	UPDATE qaa.qaa.tblAuditData 
		SET auditDate = @auditDate, 
			userID = @userID,
			areaID = @areaID,
			workOrder = @workOrder, 
			partNo = @partNo, 
			lotPlan = @lotPlan, 
			lotQty = @lotQty, 
			samSize = @samSize, 
			comments = @comments, 
			dr = @dr, 
			datecode = @dateCode, 
			rewQty = @rewQty, 
			accQty = accQty
		
	WHERE dataID = @dataID
		
	IF @action = 'DEL'
	DELETE qaa.tblAuditData  WHERE dataID = @dataID
	
	END


GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [qaa].[spDefectos]    Script Date: 01/15/2013 11:19:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[spDefectos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [qaa].[spDefectos]
GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [qaa].[spDefectos]    Script Date: 01/15/2013 11:19:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Gabriel Estrada
-- Create date: Ene 11, 2013
-- Description:	Update Defectos
-- =============================================
Create PROCEDURE [qaa].[spDefectos]
	-- Add the parameters for the stored procedure here
	@action nchar(3),
	@defectoID int = 0,
	@defectoDesc varchar(100) = ''

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @action = 'ADD' 
	INSERT INTO qaa.tblDefectos
			(defectoID, defectoDescription)
	VALUES (@defectoID, @defectoDesc)

    IF @action = 'UPD' 
	UPDATE qaa.tblDefectos SET defectoDescription = @defectoDesc
	WHERE defectoID = @defectoID
		
	IF @action = 'DEL'
	DELETE qaa.tblDefectos WHERE defectoID = @defectoID
	
	END


GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [qaa].[spUsers]    Script Date: 01/15/2013 11:20:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[qaa].[spUsers]') AND type in (N'P', N'PC'))
DROP PROCEDURE [qaa].[spUsers]
GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [qaa].[spUsers]    Script Date: 01/15/2013 11:20:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Gabriel Estrada
-- Create date: Ene-11-2013
-- Description:	Procesar tabla de Documentos
-- =============================================
CREATE PROCEDURE [qaa].[spUsers] 
	-- Add the parameters for the stored procedure here
	@action as nchar(3),
	@userID int = 0,
	@privID int = 0
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @action = 'ADD'
	INSERT INTO qaa.tblUsers
		(userID, userPriv)
	VALUES 
		(@userID, @privID)
		 
	IF @action = 'UPD'
	UPDATE qaa.tblUsers
		SET userPriv = @privID
		WHERE userID = @userID
	
	IF @action = 'DEL'
		DELETE FROM qaa.tblUsers WHERE userID = @userID
		
END



GO

