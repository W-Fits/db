CREATE TABLE language (
    language_id SERIAL PRIMARY KEY,
    language_name VARCHAR(30)
);

CREATE TYPE temp_num AS ENUM ('C', 'F'); -- Celcius or Fahrenheit
CREATE TYPE theme_num AS ENUM ('Light', 'Dark', 'System');

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    language_id INT NOT NULL,
    username VARCHAR(60) NOT NULL,
    password TEXT,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(150) NOT NULL,
    set_temp temp_num DEFAULT 'C',
    set_theme theme_num DEFAULT 'Light',
    FOREIGN KEY (language_id) REFERENCES language (language_id)
);


CREATE TABLE colour (
    colour_id SERIAL PRIMARY KEY,
    colour_name VARCHAR(35) NOT NULL UNIQUE,
    colour_value VARCHAR(7) NOT NULL UNIQUE
);

CREATE TABLE size_tag (
    size_id SERIAL PRIMARY KEY,
    size_name VARCHAR(35) NOT NULL UNIQUE
);

CREATE TABLE category_tag (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(35) NOT NULL UNIQUE
);


CREATE TYPE environment_num AS ENUM ('Warm', 'Cold');

CREATE TABLE item (
    item_id SERIAL PRIMARY KEY,
    colour_id INT NOT NULL,
    category_id INT NOT NULL,
    size_id INT NOT NULL,
    item_name VARCHAR(50) NOT NULL,
    item_url TEXT NOT NULL,
    waterproof BOOLEAN,
    available BOOLEAN,
    slot INT NOT NULL,
    enviroment environment_num NOT NULL,
    FOREIGN KEY (colour_id) REFERENCES colour(colour_id),
    FOREIGN KEY (size_id) REFERENCES size_tag(size_id),
    FOREIGN KEY (category_id) REFERENCES category_tag(category_id)
);

CREATE TABLE outfit (
    outfit_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    created_at DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE outfit_item (
    outfit_id INT NOT NULL,
    item_id INT NOT NULL,
    FOREIGN KEY (outfit_id) REFERENCES outfit(outfit_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES item(item_id)
);
