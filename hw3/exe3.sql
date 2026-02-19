--include a new column named note of type text in the accounts table
ALTER TABLE accounts
ADD COLUMN note text DEFAULT NULL;

--modify the username column to have a maximum length of 20 characters
ALTER TABLE accounts
ALTER COLUMN username TYPE varchar(20);

select * from accounts;

--enforce a condition that ensures last_login is either null or occurs after created_on
ALTER TABLE accounts
ADD CHECK (last_login ISNULL or last_login>created_on);