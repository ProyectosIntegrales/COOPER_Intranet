USE [COOPER_Intranet]
GO
/****** Object:  StoredProcedure [cdd].[spDocuments]    Script Date: 09/18/2012 11:32:16 ******/
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
					documentControlNo = @documentControlNo
				WHERE documentID = @documentID
		END
		
		IF @documentAuthLevel = 1
		BEGIN
			UPDATE cdd.tblDocuments 
					SET documentFinalFileName = @documentFinalFileName,
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
			UPDATE cdd.tblDocuments 
					SET documentAuthorizer = @documentAuthorizer,
						documentAuthorized = GETDATE(),
						documentAuthLevel = 3
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
		
	END
		
	IF @action = 'DEL'
		UPDATE cdd.tblDocuments 
					SET documentRejected = GETDATE(),
						documentAuthLevel = -100
					WHERE documentID = @documentID

	IF @action = 'DELF'
		UPDATE cdd.tblDocuments 
					SET documentRejected = GETDATE(),
						documentAuthLevel = -200
					WHERE documentID = @documentID

 	IF @action = 'RACT'
		UPDATE cdd.tblDocuments 
					SET documentAuthLevel = 0
					WHERE documentID = @documentID


	IF @action = 'REJ'
	BEGIN
			UPDATE cdd.tblDocuments 
					SET documentRejecter = @documentRejecter,
						documentRejected = GETDATE(),
						documentAuthLevel = -1,
						documentMessage = @documentMessage
					WHERE documentID = @documentID
	
	END

--	IF @action = 'AUT'

		
END
go


ALTER VIEW [dbo].[vSections]
AS
SELECT -1000 AS sectionID, '[No Seleccionada]' as sectionTitleEsp, '[Not Selected]' as sectionTitleEng, '' as sectionControlName, 0 as sectionLeftMenu, 0 as sectionHasMaster
UNION
SELECT     dbo.tblSections.*
FROM         dbo.tblSections where sectionid >0

GO
