/*************** Modificar tblDocTypes de la siguiente manera ****************

CREATE TABLE [cdd].[tblDocTypes](
	[typeID] [int] IDENTITY(1,1) NOT NULL,
	[typeNameESP] [varchar](50) NULL,
	[SelectDept] [bit] NULL,
	[mgrApproval] [bit] NULL,
	[mfgEngApproval] [bit] NULL,
	[calEngApproval] [bit] NULL,
	[typeFolderName] [varchar](50) NULL,
	[typeNameFormat] [varchar](50) NULL,
 CONSTRAINT [PK_tblDocTypes] PRIMARY KEY CLUSTERED 
(
	[typeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

*/



/*****************************************************************

CREATE TABLE [cdd].[tblDocuments](
	[documentID] [int] IDENTITY(1,1) NOT NULL,
	[documentControlNo] [varchar](50) NULL,
	[documentFileName] [varchar](1000) NULL,
	[documentType] [int] NULL,
	[documentFileType] [nchar](10) NULL,
	[documentDeptoID] [int] NULL,
	[documentAreaID] [int] NULL,
	[documentCeldaID] [int] NULL,
	[documentDescriptionEsp] [varchar](max) NULL,
	[documentDate] [datetime] NULL,
	[documentRev] [varchar](50) NULL,
	[documentAuthor] [varchar](50) NULL,
	[documentAuthLevel] [int] NULL,
	[documentRelease] [bit] NULL,
	[documentReleaseDate] [datetime] NULL,
	[documentFinalFilename] [varchar](1000) NULL,
	[documentFinalFileType] [nchar](10) NULL,
	[documentMgrAppr] [varchar](50) NULL,
	[documentMgrApprDate] [datetime] NULL,
	[documentMfgEngAppr] [varchar](50) NULL,
	[documentMfgEngApprDate] [datetime] NULL,
	[documentCalEngAppr] [varchar](50) NULL,
	[documentCalEngApprDate] [datetime] NULL,
	[documentPublisher] [varchar](50) NULL,
	[documentPublished] [datetime] NULL,
	[documentInitializer] [varchar](50) NULL,
	[documentInitialized] [datetime] NULL,
	[documentRejecter] [varchar](50) NULL,
	[documentRejected] [datetime] NULL,
	[documentMessage] [varchar](max) NULL,
	[documentHardCopies] [varchar](200) NULL,
	[documentResponsible] [varchar](50) NULL,
	[documentNumPlano] [varchar](max) NULL,
	[documentTrainer] [varchar](50) NULL,
	[documentTrainingDate] [datetime] NULL,
	[documentObsolete1] [varchar](50) NULL,
	[documentObsolete1d] [datetime] NULL,
	[documentObsolete2] [varchar](50) NULL,
	[documentObsolete2d] [datetime] NULL,
	[documentObsolete3] [varchar](50) NULL,
	[documentObsolete3d] [datetime] NULL,
 CONSTRAINT [PK_tblDocuments] PRIMARY KEY CLUSTERED 
(
	[documentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
