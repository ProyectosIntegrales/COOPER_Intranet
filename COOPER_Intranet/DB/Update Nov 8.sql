			USE [COOPER_Intranet]
GO

/****** Object:  View [cdd].[vDocuments]    Script Date: 11/08/2012 12:15:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [cdd].[vDocuments]
AS
SELECT     cdd.tblDocuments.documentID, cdd.tblDocuments.documentControlNo, cdd.tblDocuments.documentFileName, cdd.tblDocuments.documentType, 
                      cdd.tblDocuments.documentFileType, cdd.tblDocuments.documentDescriptionEsp AS documentDescription, cdd.tblDocuments.documentDate, 
                      cdd.tblDocuments.documentRev, cdd.tblDocuments.documentAuthor, dbo.getUserFullName(cdd.tblDocuments.documentAuthor) AS documentAuthorName, 
                      cdd.tblDocuments.documentAuthLevel, cdd.tblDocuments.documentRelease, cdd.tblDocuments.documentReleaseDate, cdd.tblDocuments.documentDeptoID, 
                      cdd.tblDocuments.documentMessage, cdd.tblDocuments.documentFinalFilename, cdd.tblDocuments.documentFinalFileType, cdd.tblDocuments.documentPublisher, 
                      cdd.tblDocuments.documentPublished, cdd.tblDocuments.documentInitializer, dbo.getUserFullName(cdd.tblDocuments.documentInitializer) 
                      AS documentInitializerName, cdd.tblDocuments.documentInitialized, cdd.tblDocuments.documentRejecter, dbo.getUserFullName(cdd.tblDocuments.documentRejecter) 
                      AS documentRejecterName, cdd.tblDocuments.documentRejected, cdd.tblAuthLevels.authLevelDescription, cdd.tblDocTypes.typeFolderName, 
                      dbo.tblAreas.areaMnemonic, cdd.tblCeldas.celdaMnemonic, cdd.tblDocuments.documentAreaID, cdd.tblDocuments.documentCeldaID, 
                      cdd.tblDocuments.documentHardCopies, cdd.tblDocuments.documentResponsible, cdd.tblDocuments.documentNumPlano, cdd.tblDocuments.documentTrainer, 
                      cdd.tblDocuments.documentTrainingDate, cdd.tblDocuments.documentObsolete1, cdd.tblDocuments.documentObsolete1d, cdd.tblDocuments.documentObsolete2, 
                      cdd.tblDocuments.documentObsolete2d, cdd.tblDocuments.documentObsolete3, cdd.tblDocuments.documentObsolete3d, cdd.tblDocTypes.mgrApproval, 
                      cdd.tblDocuments.documentMgrAppr, cdd.tblDocuments.documentMgrApprDate, dbo.getUserFullName(cdd.tblDocuments.documentMgrAppr) 
                      AS documentMgrApprName, tblDeptos_1.deptoManagerNo, CASE WHEN isnull(cdd.tblDocTypes.mgrApproval, 0) = 1 THEN dbo.tblUsers.userName ELSE NULL 
                      END AS deptoManagerUsername, dbo.getUserFullName(dbo.tblUsers.userName) AS deptoManagerName, cdd.tblDocTypes.mfgEngApproval, 
                      cdd.tblDocuments.documentMfgEngAppr, dbo.getUserFullName(cdd.tblDocuments.documentMfgEngAppr) AS documentMfgEngApprName, 
                      cdd.tblDocuments.documentMfgEngApprDate, dbo.tblAreas.areaMfgEng, dbo.getUserFullName(dbo.tblAreas.areaMfgEng) AS areaMfgEngName, 
                      CASE WHEN isnull(cdd.tblDocTypes.mfgEngApproval, 0) = 1 THEN tblUsers_3.userName ELSE NULL END AS areaMfgEngUsername, 
                      cdd.tblDocTypes.calEngApproval, cdd.tblDocuments.documentCalEngAppr, dbo.getUserFullName(cdd.tblDocuments.documentCalEngAppr) 
                      AS documentCalEngApprName, cdd.tblDocuments.documentCalEngApprDate, dbo.tblAreas.areaCalEng, dbo.getUserFullName(dbo.tblAreas.areaCalEng) 
                      AS areaCalEngName, CASE WHEN isnull(cdd.tblDocTypes.calEngApproval, 0) = 1 THEN tblUsers_2.userName ELSE NULL END AS areaCalEngUsername, 
                      dbo.tblDeptos.deptoMnemonic, dbo.tblDeptos.deptoName, dbo.tblAreas.areaName, cdd.tblCeldas.celdaName, 
                      dbo.getUserFullName(cdd.tblDocuments.documentObsolete1) AS documentObsolete1Name, dbo.getUserFullName(cdd.tblDocuments.documentObsolete2) 
                      AS documentObsolete2Name, cdd.tblDocuments.documentObsolete4, cdd.tblDocuments.documentObsolete4d, 
                      dbo.getUserFullName(cdd.tblDocuments.documentObsolete3) AS documentObsolete3Name, dbo.getUserFullName(cdd.tblDocuments.documentObsolete4) 
                      AS documentObsolete4Name, cdd.tblDocTypes.typeNameESP
FROM         cdd.tblDocTypes INNER JOIN
                      cdd.tblDocuments INNER JOIN
                      cdd.tblAuthLevels ON cdd.tblDocuments.documentAuthLevel = cdd.tblAuthLevels.authLevelID ON 
                      cdd.tblDocTypes.typeID = cdd.tblDocuments.documentType INNER JOIN
                      dbo.tblDeptos ON cdd.tblDocuments.documentDeptoID = dbo.tblDeptos.deptoID INNER JOIN
                      dbo.tblUsers AS tblUsers_1 ON cdd.tblDocuments.documentAuthor = tblUsers_1.userName LEFT OUTER JOIN
                      dbo.tblUsers INNER JOIN
                      dbo.tblDeptos AS tblDeptos_1 ON dbo.tblUsers.userEmployeeNo = tblDeptos_1.deptoManagerNo ON tblUsers_1.userDept = tblDeptos_1.deptoID LEFT OUTER JOIN
                      cdd.tblCeldas ON cdd.tblDocuments.documentCeldaID = cdd.tblCeldas.celdaId LEFT OUTER JOIN
                      dbo.tblUsers AS tblUsers_3 RIGHT OUTER JOIN
                      dbo.tblAreas ON tblUsers_3.userEmployeeNo = dbo.tblAreas.areaMfgEng LEFT OUTER JOIN
                      dbo.tblUsers AS tblUsers_2 ON dbo.tblAreas.areaCalEng = tblUsers_2.userEmployeeNo ON cdd.tblDocuments.documentAreaID = dbo.tblAreas.areaID

GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [cdd].[spSelectDocumentsInProc]    Script Date: 11/08/2012 14:49:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [cdd].[spSelectDocumentsInProc]
	-- Add the parameters for the stored procedure here
	@PrivLevel int,
	@documentDeptoID int = 0,
	@documentAreaID int = 0,
	@documentCeldaID int = 0,
	@documentType int = 0,
	@username varchar(50) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *, 
		   CASE WHEN documentTrainer IS NULL THEN 0 ELSE 1 END AS Training,
		   CASE WHEN (NOT documentObsolete1 IS NULL AND documentObsolete2 IS NULL AND mgrApproval = 1)
		   		  OR (NOT documentObsolete1 IS NULL AND documentObsolete2 IS NULL AND (mfgEngApproval = 1 OR calEngApproval = 1)) THEN 1
				WHEN (NOT documentObsolete2 IS NULL AND mgrApproval = 1)
				  OR (NOT documentObsolete2 IS NULL AND mfgEngApproval = 1 AND NOT documentObsolete2 IS NULL AND calEngApproval = 1) THEN 2
				ELSE 0 END AS ObsoleteLevel
	FROM cdd.vDocuments
	WHERE  (documentDeptoID = @documentDeptoID OR @documentDeptoID = 0) AND
		   (documentAreaID = @documentAreaID OR @documentAreaID = 0) AND
		   (documentCeldaID = @documentCeldaID OR @documentCeldaID = 0) AND
		   (documentType = @documentType OR @documentType = 0) AND

		   (documentAuthLevel >= -2 AND documentAuthLevel <3 AND 
	 			((@PrivLevel = 1 AND documentAuthor = @username) 
	 			OR
				 (@PrivLevel = 3 AND	
						(deptoManagerUsername = @username OR 
						 areaMfgEngUsername = @username OR 
						 areaCalEngUsername = @username OR
						 documentAuthor = @username))
				OR
				 (@PrivLevel = 9)
				)
		OR
		    documentAuthLevel = 3 AND NOT documentObsolete1 IS NULL 
				AND	(
	 					(@PrivLevel = 1 AND documentAuthor = @username) 
	 				 OR
						(@PrivLevel = 3 AND	(deptoManagerUsername = @username OR 
											 areaMfgEngUsername = @username OR 
											 areaCalEngUsername = @username)) 
					 OR 
						(@PrivLevel = 9)
				)
		OR
			documentAuthLevel = 3 AND documentTrainer IS NULL AND @PrivLevel = 7				
			)			 

END



GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [cdd].[tblEmailNotifications]    Script Date: 11/08/2012 15:03:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[cdd].[tblEmailNotifications]') AND type in (N'U'))
DROP TABLE [cdd].[tblEmailNotifications]
GO

USE [COOPER_Intranet]
GO

/****** Object:  Table [cdd].[tblEmailNotifications]    Script Date: 11/08/2012 15:03:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [cdd].[tblEmailNotifications](
	[emailID] [int] IDENTITY(1,1) NOT NULL,
	[emailSubject] [varchar](max) NULL,
	[emailMessage] [varchar](max) NULL,
	[emailToAll] [bit] NULL,
	[emailToDepto] [bit] NULL,
	[emailToMgr] [bit] NULL,
	[emailToOwner] [bit] NULL,
	[emailToDocs] [bit] NULL,
	[emailToEngs] [bit] NULL,
	[emailToNewOwner] [bit] NULL,
	[emailToTrain] [bit] NULL,
	[emailDisabled] [bit] NULL,
 CONSTRAINT [PK_tblEmailNotifications] PRIMARY KEY CLUSTERED 
(
	[emailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

