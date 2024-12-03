-- Create Database
CREATE DATABASE IF NOT EXISTS newaudiobook;
USE newaudiobook;

-- Create Roles Table
CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert Default Roles
INSERT INTO roles (role_name) VALUES ('User'), ('Admin') ;

-- Create Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- Create Modifiers Table to Track Changes
CREATE TABLE modifiers (
    modifier_id INT AUTO_INCREMENT PRIMARY KEY,
    modified_table VARCHAR(255),
    modified_by INT,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (modified_by) REFERENCES users(user_id)
);

-- Create Samhita Table
CREATE TABLE samhita (
    samhita_id INT AUTO_INCREMENT PRIMARY KEY,
    samhita_name_sanskrit TEXT NOT NULL,
    slider_image VARCHAR(255),
    samhita_number INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Books Table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    samhita_id INT,
    book_name_sanskrit TEXT NOT NULL,
    book_number INT,
    slider_image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (samhita_id) REFERENCES samhita(samhita_id)
);

-- Create Chapters Table
CREATE TABLE chapters (
    chapter_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    chapter_name_sanskrit TEXT NOT NULL,
    chapter_number INT,
    slider_image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Create Sections Table
CREATE TABLE sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    chapter_id INT,
    section_name_sanskrit TEXT NOT NULL,
    section_number INT,
    slider_image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (chapter_id) REFERENCES chapters(chapter_id)
);

-- Create Shloks Table
CREATE TABLE shloks (
    shlok_id INT AUTO_INCREMENT PRIMARY KEY,
    chapter_id INT,
    section_id INT NULL,
    shlok_number INT,
    shlok_text_sanskrit TEXT NOT NULL,
    explanation_text_hindi TEXT,
    explanation_text_english TEXT,
    shlok_audio VARCHAR(255),
    explanation_audio_hindi VARCHAR(255),
    explanation_audio_english VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (chapter_id) REFERENCES chapters(chapter_id),
    FOREIGN KEY (section_id) REFERENCES sections(section_id)
);

-- Create Disease Table (for tagging shloks based on disease/symptoms)
CREATE TABLE diseases (
    disease_id INT AUTO_INCREMENT PRIMARY KEY,
    disease_name VARCHAR(255) NOT NULL,
    symptom VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Shloks-Disease Relation Table
CREATE TABLE shloks_diseases (
    shlok_id INT,
    disease_id INT,
    PRIMARY KEY (shlok_id, disease_id),
    FOREIGN KEY (shlok_id) REFERENCES shloks(shlok_id),
    FOREIGN KEY (disease_id) REFERENCES diseases(disease_id)
);

-- Create Public Playlists Table (based on symptoms and diseases)
CREATE TABLE public_playlists (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    playlist_name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Public Playlists-Shloks Relation Table
CREATE TABLE public_playlist_shloks (
    playlist_id INT,
    shlok_id INT,
    PRIMARY KEY (playlist_id, shlok_id),
    FOREIGN KEY (playlist_id) REFERENCES public_playlists(playlist_id),
    FOREIGN KEY (shlok_id) REFERENCES shloks(shlok_id)
);

-- Create User Playlists Table
CREATE TABLE user_playlists (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    playlist_name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Create User Playlist-Shloks Relation Table
CREATE TABLE user_playlist_shloks (
    playlist_id INT,
    shlok_id INT,
    PRIMARY KEY (playlist_id, shlok_id),
    FOREIGN KEY (playlist_id) REFERENCES user_playlists(playlist_id),
    FOREIGN KEY (shlok_id) REFERENCES shloks(shlok_id)
);

-- Create Search Keywords Table (for voice and text search)
CREATE TABLE search_keywords (
    keyword_id INT AUTO_INCREMENT PRIMARY KEY,
    keyword VARCHAR(255) NOT NULL,
    book_id INT,
    chapter_id INT,
    shlok_id INT,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (chapter_id) REFERENCES chapters(chapter_id),
    FOREIGN KEY (shlok_id) REFERENCES shloks(shlok_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Set User ID for the Modifier Table (This can be set when the user logs in)
SET @user_id = 1; -- Example User ID

-- Create Trigger for Tracking Modifications on the 'samhita' Table
DELIMITER $$
CREATE TRIGGER after_update_samhita
AFTER UPDATE ON samhita FOR EACH ROW
BEGIN
    INSERT INTO modifiers (modified_table, modified_table_id, modified_by)
    VALUES ('samhita', OLD.samhita_id, @user_id);
END$$
DELIMITER ;

-- Create Trigger for Tracking Modifications on the 'books' Table
DELIMITER $$
CREATE TRIGGER after_update_books
AFTER UPDATE ON books FOR EACH ROW
BEGIN
    INSERT INTO modifiers (modified_table, modified_table_id, modified_by)
    VALUES ('books', OLD.book_id, @user_id);
END$$
DELIMITER ;

-- Create Trigger for Tracking Modifications on the 'chapters' Table
DELIMITER $$
CREATE TRIGGER after_update_chapters
AFTER UPDATE ON chapters FOR EACH ROW
BEGIN
    INSERT INTO modifiers (modified_table, modified_table_id, modified_by)
    VALUES ('chapters', OLD.chapter_id, @user_id);
END$$
DELIMITER ;

-- Create Trigger for Tracking Modifications on the 'sections' Table
DELIMITER $$
CREATE TRIGGER after_update_sections
AFTER UPDATE ON sections FOR EACH ROW
BEGIN
    INSERT INTO modifiers (modified_table, modified_table_id, modified_by)
    VALUES ('sections', OLD.section_id, @user_id);
END$$
DELIMITER ;

-- Create Trigger for Tracking Modifications on the 'shloks' Table
DELIMITER $$
CREATE TRIGGER after_update_shloks
AFTER UPDATE ON shloks FOR EACH ROW
BEGIN
    INSERT INTO modifiers (modified_table, modified_table_id, modified_by)
    VALUES ('shloks', OLD.shlok_id, @user_id);
END$$
DELIMITER ;

-- Create Trigger for Tracking Modifications on the 'diseases' Table
DELIMITER $$
CREATE TRIGGER after_update_diseases
AFTER UPDATE ON diseases FOR EACH ROW
BEGIN
    INSERT INTO modifiers (modified_table, modified_table_id, modified_by)
    VALUES ('diseases', OLD.disease_id, @user_id);
END$$
DELIMITER ;

-- Create Trigger for Tracking Modifications on the 'public_playlists' Table
DELIMITER $$
CREATE TRIGGER after_update_public_playlists
AFTER UPDATE ON public_playlists FOR EACH ROW
BEGIN
    INSERT INTO modifiers (modified_table, modified_table_id, modified_by)
    VALUES ('public_playlists', OLD.playlist_id, @user_id);
END$$
DELIMITER ;

-- Create Trigger for Tracking Modifications on the 'user_playlists' Table
DELIMITER $$
CREATE TRIGGER after_update_user_playlists
AFTER UPDATE ON user_playlists FOR EACH ROW
BEGIN
    INSERT INTO modifiers (modified_table, modified_table_id, modified_by)
    VALUES ('user_playlists', OLD.playlist_id, @user_id);
END$$
DELIMITER ;

-- Create Trigger for Tracking Modifications on the 'search_keywords' Table
DELIMITER $$
CREATE TRIGGER after_update_search_keywords
AFTER UPDATE ON search_keywords FOR EACH ROW
BEGIN
    INSERT INTO modifiers (modified_table, modified_table_id, modified_by)
    VALUES ('search_keywords', OLD.keyword_id, @user_id);
END$$
DELIMITER ;

-- Create Trigger for Tracking Modifications on the 'shloks_diseases' Relation Table
DELIMITER $$
CREATE TRIGGER after_update_shloks_diseases
AFTER UPDATE ON shloks_diseases FOR EACH ROW
BEGIN
    INSERT INTO modifiers (modified_table, modified_table_id, modified_by)
    VALUES ('shloks_diseases', OLD.shlok_id, @user_id);
END$$
DELIMITER ;

-- Setting User ID for the Modifier Table (this would be set based on the logged-in user)
-- Set @user_id when a user logs in using appropriate authentication logic
