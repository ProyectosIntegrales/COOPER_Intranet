USE [COOPER_Intranet]
GO

/****** Object:  UserDefinedFunction [dbo].[fGetEngAreas]    Script Date: 10/29/2012 12:10:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fGetEngAreas]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fGetEngAreas]
GO


/****** Object:  UserDefinedFunction [dbo].[fGetEngAreas]    Script Date: 10/29/2012 10:51:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fGetEngAreas]
(
      @userid int, @mc NCHAR(3)
)
RETURNS VARCHAR(255)
AS
BEGIN
										 
DECLARE @area nchar(10)
DECLARE @return varchar(255)

SET @return = ''

DECLARE db_cursor CURSOR FOR
SELECT     areaMnemonic
FROM         dbo.tblAreas
WHERE     (areaCalEng = @userid and @mc = 'CAL')  or (areaMfgEng = @userid and @mc = 'MFG')

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @area
WHILE @@FETCH_STATUS = 0
BEGIN
		SET @RETURN = @RETURN + rtrim(@area) + ', '
		FETCH NEXT FROM db_cursor INTO @area
END
CLOSE db_cursor
DEALLOCATE db_cursor

if @return <> ''
	RETURN SUBSTRING(@return,1,LEN(@return)-1)
	
	RETURN NULL

END


GO


/****** Object:  View [cdd].[vUsers]    Script Date: 10/29/2012 10:51:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [cdd].[vUsers]
AS
SELECT     tblUsers_1.userName, tblUsers_1.userFirstName + ' ' + tblUsers_1.userLastName AS userFullname, tblUsers_1.userEmployeeNo, tblUsers_1.userDept, 
                      tblUsers_1.userEMailAddress, cdd.tblUsers.userID, cdd.tblUsers.privLevel, dbo.tblDeptos.deptoMnemonic AS mgrOfDepto, 
                      dbo.fGetEngAreas(tblUsers_1.userEmployeeNo, N'MFG') AS mfgEngOf, dbo.fGetEngAreas(tblUsers_1.userEmployeeNo, N'CAL') AS calEngOf
FROM         dbo.tblAreas RIGHT OUTER JOIN
                      cdd.tblUsers INNER JOIN
                      dbo.tblUsers AS tblUsers_1 ON cdd.tblUsers.userID = tblUsers_1.userId ON dbo.tblAreas.areaCalEng = tblUsers_1.userEmployeeNo LEFT OUTER JOIN
                      dbo.tblDeptos ON tblUsers_1.userEmployeeNo = dbo.tblDeptos.deptoManagerNo
GROUP BY tblUsers_1.userName, tblUsers_1.userFirstName + ' ' + tblUsers_1.userLastName, tblUsers_1.userEmployeeNo, tblUsers_1.userDept, 
                      tblUsers_1.userEMailAddress, cdd.tblUsers.userID, cdd.tblUsers.privLevel, dbo.tblDeptos.deptoMnemonic, dbo.fGetEngAreas(tblUsers_1.userEmployeeNo, N'CAL')

GO



/****** Object:  StoredProcedure [cdd].[spDocTypes]    Script Date: 10/29/2012 11:25:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Gabriel Estrada
-- Create date: Mar-06-2012
-- Description:	Procesar tabla de Documentos
-- =============================================
ALTER PROCEDURE [cdd].[spDocTypes] 
	-- Add the parameters for the stored procedure here
	@action as nchar(3),
	@typeID int = 0,
	@typeNameEsp varchar(50) = '',
	@SelectDept bit = 0,
	@mgrApproval bit = 0,
	@calEngApproval bit = 0,
	@mfgEngApproval bit = 0,
	@typeFolderName varchar(50) = '',
	@typeNameFormat varchar(50) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @action = 'ADD'
	INSERT INTO cdd.tblDocTypes
		(typeNameESP, selectDept, mgrApproval, mfgEngApproval, calEngApproval, typeFolderName, typeNameFormat)
	VALUES 
		(@typeNameEsp, @SelectDept, @mgrApproval, @mfgEngApproval, @calEngApproval, @typeFolderName, @typeNameFormat)
		 
	IF @action = 'UPD'
	UPDATE cdd.tblDocTypes
		SET typeNameEsp = @typeNameEsp,
			selectDept = @selectDept,
			mgrApproval = @mgrApproval,
			mfgEngApproval = @mfgEngApproval,
			calEngApproval = @calEngApproval,
			typeFolderName = @typeFolderName,
			typeNameFormat = @typeNameFormat
		WHERE typeID = @typeID
	
	IF @action = 'DEL'
		DELETE FROM cdd.tblDocTypes WHERE typeID = @typeID
		
END

GO

/****** Object:  UserDefinedFunction [dbo].[getUserFullName]    Script Date: 10/29/2012 15:21:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getUserFullName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[getUserFullName]
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getUserFullName] 
(
	-- Add the parameters for the function here
	@userID varchar(50)
)
RETURNS varchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar varchar(255)

	-- Add the T-SQL statements to compute the return value here
	SET @ResultVar = (SELECT TOP 1 userFirstName + ' ' + userLastName FROM tblUsers 
		WHERE userName = @userID or ltrim(cast(userEmployeeNo as varchar(50))) = @userID)

	-- Return the result of the function
	RETURN @ResultVar

END

GO



USE [COOPER_Intranet]
GO

/****** Object:  View [cdd].[vDocuments]    Script Date: 10/30/2012 15:59:02 ******/
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
                      cdd.tblDocuments.documentMgrAppr, dbo.getUserFullName(cdd.tblDocuments.documentMgrAppr) AS documentMgrApprName, 
                      cdd.tblDocuments.documentMgrApprDate, dbo.tblDeptos.deptoManagerNo, dbo.getUserFullName(dbo.tblDeptos.deptoManagerNo) AS deptoManagerName, 
                      tblUsers_1.userName AS deptoManagerUsername, cdd.tblDocTypes.mfgEngApproval, cdd.tblDocuments.documentMfgEngAppr, 
                      dbo.getUserFullName(cdd.tblDocuments.documentMfgEngAppr) AS documentMfgEngApprName, cdd.tblDocuments.documentMfgEngApprDate, 
                      dbo.tblAreas.areaMfgEng, dbo.getUserFullName(dbo.tblAreas.areaMfgEng) AS areaMfgEngName, dbo.tblUsers.userName AS areaMfgEngUsername, 
                      cdd.tblDocTypes.calEngApproval, cdd.tblDocuments.documentCalEngAppr, dbo.getUserFullName(cdd.tblDocuments.documentCalEngAppr) 
                      AS documentCalEngApprName, cdd.tblDocuments.documentCalEngApprDate, dbo.tblAreas.areaCalEng, dbo.getUserFullName(dbo.tblAreas.areaCalEng) 
                      AS areaCalEngName, tblUsers_2.userName AS areaCalEngUsername, dbo.tblDeptos.deptoMnemonic, dbo.tblDeptos.deptoName, dbo.tblAreas.areaName, 
                      cdd.tblCeldas.celdaName
FROM         dbo.tblUsers RIGHT OUTER JOIN
                      dbo.tblAreas ON dbo.tblUsers.userEmployeeNo = dbo.tblAreas.areaMfgEng LEFT OUTER JOIN
                      dbo.tblUsers AS tblUsers_2 ON dbo.tblAreas.areaCalEng = tblUsers_2.userEmployeeNo RIGHT OUTER JOIN
                      cdd.tblDocTypes INNER JOIN
                      cdd.tblDocuments INNER JOIN
                      cdd.tblAuthLevels ON cdd.tblDocuments.documentAuthLevel = cdd.tblAuthLevels.authLevelID ON 
                      cdd.tblDocTypes.typeID = cdd.tblDocuments.documentType INNER JOIN
                      dbo.tblDeptos ON cdd.tblDocuments.documentDeptoID = dbo.tblDeptos.deptoID LEFT OUTER JOIN
                      dbo.tblUsers AS tblUsers_1 ON dbo.tblDeptos.deptoManagerNo = tblUsers_1.userEmployeeNo LEFT OUTER JOIN
                      cdd.tblCeldas ON cdd.tblDocuments.documentCeldaID = cdd.tblCeldas.celdaId ON dbo.tblAreas.areaID = cdd.tblDocuments.documentAreaID
GO


USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [cdd].[spSelectDocumentsInProc]    Script Date: 10/30/2012 10:54:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[cdd].[spSelectDocumentsInProc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [cdd].[spSelectDocumentsInProc]
GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [cdd].[spSelectDocumentsInProc]    Script Date: 10/30/2012 10:54:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [cdd].[spSelectDocumentsInProc]
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
		   CASE WHEN NOT documentObsolete1 IS NULL AND documentObsolete2 IS NULL THEN 1
				WHEN NOT documentObsolete2 IS NULL AND documentObsolete3 IS NULL THEN 2
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
						 areaCalEngUsername = @username))
				OR
				 (@PrivLevel = 9)
				)
		OR
		    documentAuthLevel = 3 AND NOT documentObsolete1 IS NULL AND 
										  documentObsolete2 IS NULL AND
										  documentObsolete3 IS NULL 
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

/****** Object:  StoredProcedure [cdd].[spDocuments]    Script Date: 10/30/2012 11:32:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[cdd].[spDocuments]') AND type in (N'P', N'PC'))
DROP PROCEDURE [cdd].[spDocuments]
GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [cdd].[spDocuments]    Script Date: 10/30/2012 15:55:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [cdd].[spDocuments] 
	-- Add the parameters for the stored procedure here
	@action as nchar(4),
	@documentID int = 0,
	@documentFileName varchar(1000) = '',
	@documentType int = 0,
	@documentFileType nchar(3) = '',
	@documentDeptoID int = 0,
	@documentAreaID int = 0,
	@documentCeldaID int = 0,
	@documentDescriptionEsp varchar(MAX) = '',
	@documentRev varchar(50) = '',
	@documentAuthor varchar(50) = '',
	@documentAuthLevel int = 0,
	@AuthType nchar(3) = '',
	@documentRelease bit = 0,
	@documentReleaseDate datetime = '1/1/1900',
	@documentControlNo varchar(50) = '',
	@documentFinalFilename varchar(1000) = '',
	@documentFinalFileType nchar(10) = '',
	@documentInitializer varchar(50) = '',
	@documentAuthorizer varchar(50) = '',
	@documentPublisher varchar(50) = '',
	@documentRejecter varchar(50) = '',
	@documentMessage varchar(MAX) = 'No se especificó el motivo del rechazo.',
	@documentHardCopies varchar(200) = '',
	@documentResponsible varchar(50) = '',
	@documentNumPlano varchar(MAX) = ''
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @action = 'ADD'
	INSERT INTO cdd.tblDocuments 
		(documentFileName, documentType, documentFileType,
		 documentDeptoID, documentAreaID, documentCeldaID, documentDescriptionEsp, documentRev,
		 documentAuthor, documentDate, documentAuthLevel, documentControlNo)
	VALUES 
		(@documentFileName, @documentType, @documentFileType,
		 @documentDeptoID, @documentAreaID, @documentCeldaID, @documentDescriptionEsp, @documentRev,
		 @documentAuthor, GETDATE(), 0, @documentControlNo)
		 
	IF @action = 'UPD'
	BEGIN

		IF @documentAuthLevel = 0
		BEGIN
			UPDATE cdd.tblDocuments 
				SET documentFileName = @documentFileName,
					documentType = @documentType,
					documentFileType = @documentFileType,
					documentDeptoID = @documentDeptoID,
					documentAreaID = @documentAreaID,
					documentCeldaId = @documentCeldaID, 
					documentDescriptionEsp = @documentDescriptionEsp,
					documentRev = @documentRev,
					documentDate = GETDATE(),
					documentAuthor = @documentAuthor,
					documentAuthLevel = @documentAuthLevel,
					documentControlNo = @documentControlNo,
					documentMgrAppr = NULL,
					documentMfgEngAppr = NULL,
					documentCalEngAppr = NULL
				WHERE documentID = @documentID
		END
		
		IF @documentAuthLevel = 1
		BEGIN
			UPDATE cdd.tblDocuments 
					SET documentFileName = @documentFileName,
						documentFileType = @documentFileType,
						documentFinalFileName = @documentFinalFileName,
						documentFinalFileType = @documentFinalFileType,
						documentDescriptionEsp = @documentDescriptionEsp,
						documentRev = @documentRev,
						documentInitializer = @documentInitializer,
						documentInitialized = GETDATE(),
						documentHardCopies = @documenthardCopies,
						documentResponsible = @documentResponsible,
						documentNumPlano = @documentNumPlano,
						documentAuthLevel = @documentAuthLevel
					WHERE documentID = @documentID
		END
		
		IF @documentAuthLevel = 2
		BEGIN
			IF @AuthType = 'MGR'
				UPDATE cdd.tblDocuments 
					SET documentMgrAppr = @documentAuthorizer,
						documentMgrApprDate = GETDATE(),
						documentAuthLevel = 3
					WHERE documentID = @documentID
			IF @AuthType = 'MFG'
				UPDATE cdd.tblDocuments 
					SET documentMfgEngAppr = @documentAuthorizer,
						documentMfgEngApprDate = GETDATE(),
						documentAuthLevel = CASE WHEN NOT documentCalEngAppr IS NULL THEN 3 ELSE 1 END
					WHERE documentID = @documentID			
			IF @AuthType = 'CAL'
				UPDATE cdd.tblDocuments 
					SET documentCalEngAppr = @documentAuthorizer,
						documentCalEngApprDate = GETDATE(),
						documentAuthLevel = CASE WHEN NOT documentMfgEngAppr IS NULL THEN 3 ELSE 1 END
					WHERE documentID = @documentID	
		END
		
		IF @documentAuthLevel = 3
		BEGIN
			UPDATE cdd.tblDocuments 
					SET documentPublisher = @documentPublisher,
						documentPublished = GETDATE(),
						documentRev = @documentRev,
						documentDescriptionEsp = @documentDescriptionEsp,
						documentAuthLevel = @documentAuthLevel,
						documentHardCopies = @documenthardCopies,
						documentResponsible = @documentResponsible,
						documentNumPlano = @documentNumPlano,
						documentFinalFileName = @documentFinalFilename,
						documentFinalFileType = @documentFinalFileType
					WHERE documentID = @documentID
		
		END
		
		IF @documentauthLevel = 7
		BEGIN
			UPDATE cdd.tblDocuments 
					SET documentTrainer = @documentAuthorizer,
						documentTrainingDate = GETDATE()
					WHERE documentID = @documentID
		END
		
	END
		
	IF @action = 'DEL'
		DELETE cdd.tblDocuments 
					WHERE documentID = @documentID

 	IF @action = 'RACT'
		UPDATE cdd.tblDocuments 
					SET documentAuthLevel = 0
					WHERE documentID = @documentID


	IF @action = 'REJG'
	BEGIN
			UPDATE cdd.tblDocuments 
					SET documentRejecter = @documentRejecter,
						documentRejected = GETDATE(),
						documentAuthLevel = -1,
						documentMessage = @documentMessage
					WHERE documentID = @documentID
	
	END
	
	IF @action = 'REJD'
	BEGIN
			UPDATE cdd.tblDocuments 
					SET documentRejecter = @documentRejecter,
						documentRejected = GETDATE(),
						documentAuthLevel = -2,
						documentMessage = @documentMessage
					WHERE documentID = @documentID
	
	END
	
	IF @action = 'OBS'
	BEGIN
		IF @documentAuthLevel = 1
			UPDATE cdd.tblDocuments
				SET documentObsolete1 = @documentRejecter,
					documentObsolete1d = GETDATE()
				WHERE documentID = @documentID
				
		IF @documentAuthLevel = 2
			UPDATE cdd.tblDocuments
				SET documentObsolete2 = @documentRejecter,
					documentObsolete2d = GETDATE()
				WHERE documentID = @documentID
				
		IF @documentAuthLevel = 3
			UPDATE cdd.tblDocuments
				SET documentObsolete3 = @documentRejecter,
					documentObsolete3d = GETDATE(),
					documentAuthLevel = -100
				WHERE documentID = @documentID										
	END

		
END

GO

