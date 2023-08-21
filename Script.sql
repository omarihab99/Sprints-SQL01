-- Create tables
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(50)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(50)
);

CREATE TABLE BooksGenres (
    BookID INT,
    GenreID INT,
    PRIMARY KEY (BookID, GenreID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

-- Insert sample data
INSERT INTO Authors (AuthorID, AuthorName)
VALUES (1, 'J.K. Rowling'),
       (2, 'Stephen King');

INSERT INTO Books (BookID, Title, AuthorID)
VALUES (1, 'Harry Potter and the Sorcerer''s Stone', 1),
       (2, 'The Shining', 2),
       (3, 'Harry Potter and the Chamber of Secrets', 1);

INSERT INTO Genres (GenreID, GenreName)
VALUES (1, 'Fantasy'),
       (2, 'Horror');

INSERT INTO BooksGenres (BookID, GenreID)
VALUES (1, 1),
       (1, 2),
       (2, 2);

-- Sample queries
-- One-to-One: Each book has one author
SELECT Title, AuthorName
FROM Books
INNER JOIN Authors ON Books.AuthorID = Authors.AuthorID;

-- One-to-Many: Each author can write multiple books
SELECT AuthorName, GROUP_CONCAT(Title) AS BooksWritten
FROM Authors
LEFT JOIN Books ON Authors.AuthorID = Books.AuthorID
GROUP BY Authors.AuthorID;

-- Many-to-Many: Books can belong to multiple genres, and genres can have multiple books
SELECT Title, GROUP_CONCAT(GenreName) AS Genres
FROM Books
INNER JOIN BooksGenres ON Books.BookID = BooksGenres.BookID
INNER JOIN Genres ON BooksGenres.GenreID = Genres.GenreID
GROUP BY Books.BookID;
