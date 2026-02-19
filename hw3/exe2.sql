DROP TABLE IF EXISTS account_roles;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS accounts;
--remove the existing "accounts" table if it exists
CREATE TABLE accounts (
	user_id serial PRIMARY KEY,
	username VARCHAR ( 50 ) UNIQUE NOT NULL,
	password VARCHAR ( 50 ) NOT NULL,
	email VARCHAR ( 255 ) UNIQUE NOT NULL,
	created_on DATE NOT NULL,
        last_login TIMESTAMP DEFAULT NULL
);

--initialize the "roles" table
CREATE TABLE roles(
   role_id serial PRIMARY KEY,
   role_name VARCHAR (255) UNIQUE NOT NULL
);

--establish the "account_roles" table
CREATE TABLE account_roles (
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  grant_date TIMESTAMPTZ,
  PRIMARY KEY (user_id, role_id),
  FOREIGN KEY (role_id)
      REFERENCES roles (role_id),
  FOREIGN KEY (user_id)
      REFERENCES accounts (user_id)
);

--remove the column named last_login from the 'accounts' table
ALTER TABLE accounts
DROP COLUMN last_login;

--insert a new column named last_login into the 'accounts' table
ALTER TABLE accounts
ADD COLUMN last_login TIMESTAMPTZ;

--assign a default value of NULL to the last_login column in 'accounts'
ALTER TABLE accounts
ALTER COLUMN last_login
SET DEFAULT NULL;

select * from accounts;
select * from roles;
select * from account_roles;
