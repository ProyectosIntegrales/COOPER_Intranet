ALTER PROCEDURE [cdd].[spDocuments] 
	-- Add the parameters for the stored procedure here
	@action as nchar(4),
	@documentID int = 0,
	@documentNameEsp varchar(100) = '',
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
	@documentMessage varchar(MAX) = 'No se especificó el motivo del rechazo.'
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @action = 'ADD'
	INSERT INTO cdd.tblDocuments 
		(documentNameEsp, documentFileName, documentType, documentFileType,
		 documentDeptoID, documentAreaID, documentCeldaID, documentDescriptionEsp, documentRev,
		 documentAuthor, documentDate, documentAuthLevel, documentControlNo)
	VALUES 
		(@documentNameEsp, @documentFileName, @documentType, @documentFileType,
		 @documentDeptoID, @documentAreaID, @documentCeldaID, @documentDescriptionEsp, @documentRev,
		 @documentAuthor, GETDATE(), 0, @documentControlNo)
		 
	IF @action = 'UPD'
	BEGIN

		IF @documentAuthLevel = 0
		BEGIN
			UPDATE cdd.tblDocuments 
				SET documentNameEsp = @documentNameEsp,
					documentFileName = @documentFileName,
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
					SET documentNameEsp = @documentNameEsp,
						documentFinalFileName = @documentFinalFileName,
						documentFinalFileType = @documentFinalFileType,
						documentDescriptionEsp = @documentDescriptionEsp,
						documentRev = @documentRev,
						documentInitializer = @documentInitializer,
						documentInitialized = GETDATE(),
						documentAuthLevel = @documentAuthLevel
					WHERE documentID = @documentID
		END
		
		IF @documentAuthLevel = 2
		BEGIN
			UPDATE cdd.tblDocuments 
					SET documentAuthorizer = @documentAuthorizer,
						documentAuthorized = GETDATE(),
						documentAuthLevel = @documentAuthLevel
					WHERE documentID = @documentID

		END
		
		IF @documentAuthLevel = 3
		BEGIN
			UPDATE cdd.tblDocuments 
					SET documentPublisher = @documentPublisher,
						documentPublished = GETDATE(),
						documentAuthLevel = @documentAuthLevel,
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
					SET documentAuthLevel = 1
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
