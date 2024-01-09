CREATE DATABASE minitailor;

CREATE USER minitailor_user WITH encrypted password 'password';
grant all privileges on database minitailor to minitailor_user;