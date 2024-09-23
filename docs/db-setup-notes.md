## Setting Up the Database

### Developer Setup

1. Install PostgreSQL to the 'postgres' Unix user.
2. Start psql as the OS user 'postgres': `sudo -u postgres psql`
3. Create a new user with create database rights: `CREATE USER myuser WITH PASSWORD 'mypassword';`
4. Give the new user rights to create databases: `ALTER USER myuser CREATEDB;`

'myuser' above should be the logged in user's username, i.e. the value returned by running `whoami` in the terminal.

Now you can run the database setup script as the new user:

```bash
rails db:setup
```
