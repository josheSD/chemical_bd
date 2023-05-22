CREATE DATABASE DB_CHEMICAL;

GO

USE DB_CHEMICAL

GO

CREATE SCHEMA staff

GO

-- use__state -> 
-- 0 : Inactive
-- 1 : Active
CREATE TABLE [staff].[user](
	[use__id] INT IDENTITY NOT NULL,
	[use__name] VARCHAR(100) NOT NULL,
	[use__password] VARCHAR(255) NOT NULL,
	[use__state] TINYINT NOT NULL, 
	CONSTRAINT [pk_use__id] PRIMARY KEY CLUSTERED ([use__id])
);

GO

CREATE PROCEDURE UserAdd
  @useName NVARCHAR(100),
  @usePassword NVARCHAR(255),
  @useState TINYINT
AS
BEGIN
	
	DECLARE @Process INT
	
	SELECT @Process = COUNT(use__id)
	FROM [staff].[user]
	WHERE use__name = @useName;

	IF @Process > 0
		BEGIN
			PRINT @Process
		END
	ELSE
		BEGIN
			INSERT INTO [staff].[user](use__name,use__password,use__state)
								VALUES(@useName,@usePassword,@useState);
		END

END;

GO

CREATE PROCEDURE UserUpdate
  @useId INT,
  @useName NVARCHAR(100),
  @usepassword NVARCHAR(255),
  @useState TINYINT
AS
BEGIN
	
	DECLARE @Process INT

	SELECT @Process = COUNT(use__id)
	FROM [staff].[user]
	WHERE use__id = @useId;

	IF @Process = 0
		BEGIN
			PRINT @Process
		END
	ELSE
		BEGIN
			UPDATE [staff].[user] 
			SET use__name = @useName, use__password = @usePassword, use__state = @useState
			WHERE use__id = @useId;
			PRINT @Process
		END
	
END;

GO

CREATE PROCEDURE UserDelete
  @useId INT,
  @useState TINYINT
AS
BEGIN

	DECLARE @Process INT
	DECLARE @Active INT

	SET @Active = 1

	SELECT @Process = COUNT(use__id)
	FROM [staff].[user]
	WHERE use__id = @useId AND use__state = @Active; 

	IF @Process = 0
		BEGIN
			PRINT @Process
		END
	ELSE
		BEGIN
			UPDATE [staff].[user] 
			SET use__state = @useState
			WHERE use__id = @useId;
		END
END;

GO

CREATE PROCEDURE UserListar
AS
BEGIN 

	SELECT use__id as UseId,use__name as UseName,use__state as UseState
	FROM [staff].[user];

END;

GO

EXEC UserAdd 'Marta', '12345', 1;

GO

EXEC UserUpdate 5, 'Carlos33', '123', 1

GO

EXEC UserDelete 1, 0

GO

EXEC UserListar;