-- IMPORTANTE!!!: ESSES DROPS SÓ PODEM FICAR AQUI DURANTE DEVELOPMENT
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS passwd;
DROP TABLE IF EXISTS credits;
DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS registrations;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS activities;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  uuid UUID UNIQUE NOT NULL,
  isVerified BOOLEAN DEFAULT FALSE,
  verificationCode VARCHAR(255),
  isAdmin BOOLEAN DEFAULT FALSE
);

CREATE TABLE passwd (
  id INT PRIMARY KEY REFERENCES users(id),
  passwd VARCHAR(255) NOT NULL
);

CREATE TABLE activities (
  id SERIAL PRIMARY KEY NOT NULL,
  spots INT NOT NULL,
  activity_type VARCHAR(255) NOT NULL,
  room VARCHAR(255) NOT NULL,
  speaker VARCHAR(255) NOT NULL,
  topic VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  time TIMESTAMP NOT NULL,
  day INT NOT NULL
);

CREATE TABLE registrations (
  user_id UUID NOT NULL,
  activity_id INT NOT NULL,
  PRIMARY KEY (user_id, activity_id),
  FOREIGN KEY (user_id) REFERENCES users(uuid),
  FOREIGN KEY (activity_id) REFERENCES activities(id)
);

CREATE TABLE purchases (
  purchase_id SERIAL PRIMARY KEY,
  user_id UUID NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(uuid),
  credits INT NOT NULL,
  price REAL NOT NULL
);

CREATE TABLE credits (
  credit_type BOOLEAN NOT NULL,
  purchase_id INT NOT NULL,
  FOREIGN KEY (purchase_id) REFERENCES purchases(purchase_id)
);

ALTER TABLE users
ADD COLUMN uuid UUID UNIQUE NOT NULL;

ALTER TABLE users
ADD COLUMN isVerified BOOLEAN DEFAULT FALSE;

ALTER TABLE users
ADD COLUMN verificationCode VARCHAR(255);

ALTER TABLE users
ADD COLUMN tokens INT CHECK (tokens <= 5) DEFAULT 0;

ALTER TABLE users
ADD COLUMN name VARCHAR(255);
