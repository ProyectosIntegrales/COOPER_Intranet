USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [adm].[spCreateDBUser]    Script Date: 11/06/2012 14:32:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Gabriel Estrada
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [adm].[spCreateDBUser]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


/****** Object:  User [CooperIntranetUser]    Script Date: 07/09/2012 19:38:11 ******/
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'CooperIntranetUser')
DROP USER [CooperIntranetUser]

CREATE USER [CooperIntranetUser] FOR LOGIN [CooperIntranetUser]
ALTER USER [CooperIntranetUser] WITH DEFAULT_SCHEMA=[dbo]
EXEC sp_addrolemember N'db_datareader', N'CooperIntranetUser'
EXEC sp_addrolemember N'db_datawriter', N'CooperIntranetUser'
GRANT DELETE TO [CooperIntranetUser]
GRANT EXECUTE TO [CooperIntranetUser]
GRANT INSERT TO [CooperIntranetUser]
GRANT SELECT TO [CooperIntranetUser]
GRANT UPDATE TO [CooperIntranetUser]
GRANT SELECT ON [cdd].[vDocuments] TO [CooperIntranetUser]
END
GO


USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [cdd].[spDocuments]    Script Date: 11/06/2012 14:31:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [cdd].[spDocuments] 
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
			BEGIN
			UPDATE cdd.tblDocuments
				SET documentObsolete3 = @documentRejecter,
					documentObsolete3d = GETDATE()
				WHERE documentID = @documentID and NOT documentObsolete2 IS NULL
			UPDATE cdd.tblDocuments
				SET documentObsolete2 = @documentRejecter,
					documentObsolete2d = GETDATE()
				WHERE documentID = @documentID and documentObsolete2 IS NULL
			END				
				
		IF @documentAuthLevel = 3
			UPDATE cdd.tblDocuments
				SET documentObsolete4 = @documentRejecter,
					documentObsolete4d = GETDATE(),
					documentAuthLevel = -100
				WHERE documentID = @documentID										
	END

		
END
GO

USE [COOPER_Intranet]
GO

/****** Object:  StoredProcedure [cdd].[spSelectDocumentsInProc]    Script Date: 11/06/2012 15:01:08 ******/
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
						 areaCalEngUsername = @username))
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


