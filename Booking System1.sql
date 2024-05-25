CREATE DATABASE BOOKING_PROJECT;
USE BOOKING_PROJECT;

-- ######################################################################################################################################################
-- ###################################################################### TABLE CREATION ################################################################
-- ######################################################################################################################################################

-- --------------Create Persons table-----------------------
 CREATE TABLE Persons (
        PersonID INT AUTO_INCREMENT PRIMARY KEY,
        Role ENUM('User', 'Host', 'Admin') NOT NULL
    );

-- --------------Create Users table--------------------------
   CREATE TABLE Users (
        UserID INT PRIMARY KEY AUTO_INCREMENT,
        PersonID INT,
        Username VARCHAR(255) NOT NULL,
        Password VARCHAR(255) NOT NULL,
        Email VARCHAR(255) NOT NULL,
        FirstName VARCHAR(255),
        LastName VARCHAR(255),
        ProfilePicture VARCHAR(255),
        RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
        LastLoginDate DATETIME DEFAULT NULL,
        FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
    );

-- -------------Create Hosts table----------------------


-- ALTER TABLE hosts
-- ADD COLUMN Password VARCHAR(255);

   CREATE TABLE Hosts (
        HostID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
        PersonID INT,
        Email VARCHAR(255) NOT NULL,
        Password VARCHAR(255) NOT NULL,
        HostApprovalStatus VARCHAR(50),
        PropertyAddress VARCHAR(255),
        PropertyType VARCHAR(100),
        Description TEXT,
        Amenities TEXT,
        PropertyName VARCHAR(255),
        FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
    );

-- ---------------Create Admins table------------------
    CREATE TABLE Admins (
            AdminID INT PRIMARY KEY,
            PersonID INT,
            Username VARCHAR(255) NOT NULL,
            Password VARCHAR(255) NOT NULL,
            Email VARCHAR(255) NOT NULL,
            FirstName VARCHAR(255),
            LastName VARCHAR(255),
            FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
    );

-- Create HostRequests table
        CREATE TABLE HostRequests (
            RequestID INT AUTO_INCREMENT PRIMARY KEY,
            UserID INT,
            RequestStatus ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
            RequestDate DATETIME DEFAULT CURRENT_TIMESTAMP,
            AdminID INT,
            ResponseDate DATETIME,
            FOREIGN KEY (UserID) REFERENCES Users(UserID),
            FOREIGN KEY (AdminID) REFERENCES Admins(AdminID)
        );

-- Create Bookings table
        CREATE TABLE Bookings (
            BookingID INT AUTO_INCREMENT PRIMARY KEY,
            UserID INT,
            HostID INT,
            BookingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
            CheckInDate DATETIME,
            CheckOutDate DATETIME,
            TotalPrice DECIMAL(10,2),
            BookingStatus VARCHAR(50),
            AdvertID INT,
            FOREIGN KEY (UserID) REFERENCES Users(UserID),
            FOREIGN KEY (HostID) REFERENCES Hosts(HostID)
    );

-- ---------------Create Transactions table---------------------
        CREATE TABLE Transactions (
            TransactionID INT AUTO_INCREMENT PRIMARY KEY,
            BookingID INT,
            PaymentAmount DECIMAL(10,2),
            PaymentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
            PaymentStatus VARCHAR(50),
            FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
    );

-- ----------------Create Reviews table---------------------
        CREATE TABLE Reviews (
            ReviewID INT AUTO_INCREMENT PRIMARY KEY,
            BookingID INT,
            Rating INT,
            Comment TEXT,
            ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,
            userID INT,
            FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
    );

-- ----------------------Create Wishlist table--------------------
        CREATE TABLE Wishlist (
            WishlistID INT AUTO_INCREMENT PRIMARY KEY,
            UserID INT,
            HostID INT,
            WishlistDate DATETIME DEFAULT CURRENT_TIMESTAMP,
            AdvertisementID INT,
            FOREIGN KEY (UserID) REFERENCES Users(UserID),
            FOREIGN KEY (HostID) REFERENCES Hosts(HostID)
    );

-- -----------------------------Create HostAdvertisements table---------------------------------

        CREATE TABLE HostAdvertisements (
            AdvertID INT AUTO_INCREMENT PRIMARY KEY,
            HostID INT,
            AdvertisementContent TEXT,
            AdvertisementDate DATETIME DEFAULT CURRENT_TIMESTAMP,
            Title VARCHAR(255),
            Price INT,
            Place VARCHAR(255),
            Availability VARCHAR(250),
            FOREIGN KEY (HostID) REFERENCES Hosts(HostID)
    );



-- ######################################################################################################################################################
-- ###################################################################### QUERIES #######################################################################
-- ######################################################################################################################################################

-- -------------------------registration----------------------------------------------
INSERT INTO Persons (Role) VALUES ('User');

-- Get the PersonID of the newly inserted user
SET @personID = LAST_INSERT_ID();
SET @userID = LAST_INSERT_ID();
INSERT INTO Users (userID, PersonID, Username, Password, Email, FirstName, LastName) 
VALUES (@userID,@personID, 'Mahbub', '123', 'mahbub@gmail.com', 'mahbub', 'ahmed');

-- --------------------------------------login--------------------------------------
SELECT 
    CASE
        WHEN Users.PersonID IS NULL AND Hosts.PersonID IS NULL AND Admins.PersonID IS NULL THEN 'Incorrect credentials'
        ELSE Persons.PersonID
    END AS PersonID,
    CASE
        WHEN Users.PersonID IS NULL AND Hosts.PersonID IS NULL AND Admins.PersonID IS NULL THEN NULL
        ELSE Persons.Role
    END AS Role,
    CASE
        WHEN Users.PersonID IS NULL AND Hosts.PersonID IS NULL AND Admins.PersonID IS NULL THEN NULL
        ELSE users.FirstName
    END AS FirstName,
    CASE
        WHEN Persons.Role = 'User' THEN Users.UserID
        WHEN Persons.Role = 'Host' THEN Hosts.HostID
        WHEN Persons.Role = 'Admin' THEN Admins.AdminsID
        ELSE NULL
    END AS IdentityID
FROM Persons
LEFT JOIN Users ON Persons.PersonID = Users.PersonID
LEFT JOIN Hosts ON Persons.PersonID = Hosts.PersonID
LEFT JOIN Admins ON Persons.PersonID = Admins.PersonID
WHERE
    (Users.Email = 'ahmed@example.com' OR Hosts.Email = 'ahmed@example.com' OR Admins.Email = 'ahmed@example.com') AND
    (Users.Password = '123' OR Hosts.Password = '123' OR Admins.Password = '123');



-- --------------------------------------------------------------------------------------------------
-- ---------------------------------------User Experiences ------------------------------------------
-- --------------------------------------------------------------------------------------------------

-- -------------Search posts------------------
SELECT * 
FROM HostAdvertisements 
WHERE Place LIKE '%beachfront%' 
    AND Availability = 'Yes' 
    AND DATE(AdvertisementDate) <= '2024-05-02';



----------------- Add to wishlist-------------
INSERT INTO Wishlist (UserID, HostID,AdvertisementID) 
VALUES (21, 7,80);


-- -----------------View Wishlist----------
SELECT * 
FROM Wishlist 
WHERE UserID = 9;

-- --------add booking -------------------

INSERT INTO Bookings (UserID, HostID, CheckInDate, CheckOutDate, TotalPrice, BookingStatus,AdvertID)
SELECT 
    9, -- UserID of the user making the booking
    HA.hostID, -- HostID of the host whose accommodation is being booked
    '2024-05-01', -- Check-in date
    '2024-05-05', -- Check-out date
    HA.Price, -- Total price retrieved from the HostAdvertisements table
    'Not Yet Confirmed', -- Booking status
    HA.AdvertID
FROM 
    HostAdvertisements HA
WHERE 
    HA.AdvertID = 91; -- ID of the advertisement whose accommodation is being booked


-- -----------View User Bookings--------------
SELECT * 
FROM Bookings 
-- WHERE UserID = 'user_id';
WHERE UserID = 9;

-- -------------getting booking details----------------
SELECT * 
FROM Bookings 
WHERE BookingID = 'booking_id';

-- ----------------Cancel Bookinig--------------------
UPDATE Bookings 
SET BookingStatus = 'Cancelled' 
WHERE BookingID = 'booking_id';

-- -----------------confirm bookings with payments---------------

SET @bID = 12; 
-- Update booking status to 'Confirmed'
UPDATE Bookings 
SET BookingStatus = 'Confirmed' 
WHERE BookingID = @bID;

-- Get the advertID associated with the booking
SET @advertID = (
    SELECT AdvertID
    FROM Bookings
    WHERE BookingID = @bID
);

-- Update advertisement availability to 'No'
UPDATE HostAdvertisements
SET Availability = 'No'
WHERE AdvertID = @advertID;

-- Insert data into Transactions table with payment amount from HostAdvertisements
INSERT INTO Transactions (BookingID, PaymentAmount, PaymentStatus)
SELECT @bID, Price, 'Confirmed'
FROM HostAdvertisements
WHERE AdvertID = @advertID;


-- --------------------------Leave Review-------------------------
INSERT INTO Reviews (BookingID, Rating, Comment) 
VALUES ('booking_id', 'rating_value', 'comment_text');

-- ---------------Add a request to become a host-------------------
INSERT INTO HostRequests (UserID, RequestStatus) 
VALUES (6, 'Pending');



-- --------------------------------------------------------------------------------------------------
-- ---------------------------------------HOST Experiences ------------------------------------------
-- --------------------------------------------------------------------------------------------------

-- ------------------Create a rent post------------------

INSERT INTO HostAdvertisements (HostID, AdvertisementContent, Title, Price, Place, Availability) 
VALUES ('host_id','advertisement_content','title','Price','Place','Yes/No');

-- ------------------Edit rent post--------------
UPDATE HostAdvertisements 
SET AdvertisementContent = 'new_content' 
WHERE AdvertID = 'advert_id';

-- -------------------Delete post----------------
DELETE FROM HostAdvertisements 
WHERE AdvertID = 'advert_id';

--  --------------View All post of a host-----------------
SELECT *
FROM HostAdvertisements
WHERE HostAdvertisements.HOSTID = 1;

-- ------------------View all bookings------------------
SELECT * FROM Bookings 
WHERE HostID = 'host_id';

-- -------------------Manage Availablity--------------------
UPDATE Hosts SET AvailabilityStatus = 'Available' WHERE HostID = 'host_id';
-- and
UPDATE Hosts SET AvailabilityStatus = 'Unavailable' WHERE HostID = 'host_id';

-- ---------------------View reviews------------------
SELECT * 
FROM Reviews INNER JOIN Bookings ON Reviews.BookingID = Bookings.BookingID 
WHERE Bookings.HostID = 9;

-- --------------View all earnings-------------------------
SELECT SUM(PaymentAmount) AS TotalEarnings 
FROM Transactions INNER JOIN Bookings ON Transactions.BookingID = Bookings.BookingID 
WHERE Bookings.HostID = 9;


-- --------------------------------------------------------------------------------------------------
-- ---------------------------------------ADMIN EXPERIENCES------------------------------------------
-- --------------------------------------------------------------------------------------------------

-- -------------------View host requests---------------------
SELECT * 
FROM HostRequests 
WHERE RequestStatus = 'Pending';

-- ------------------Approve host request------------------
-- Get the UserID associated with the user from the HostRequests table
SET @UserID = (
	SELECT UserID 
	FROM HostRequests 
	WHERE RequestID = 12)
;
-- Update the Persons table to change the role from User to Host
UPDATE Persons 
SET Role = 'Host'
WHERE PersonID = @UserID;

INSERT INTO Hosts (HostID, PersonID, Email, Password, HostApprovalStatus, PropertyAddress, PropertyType, Description, Amenities, PropertyName)
SELECT 
    NULL, 
    PersonID,
    Email,
    Password,
    'Approved', 
    '1314 Cedar Lane', 
    'Cottage',
    'Quaint cottage near the lake',
    'Lake access, Kayaks, BBQ Grill', 
    'Lakeside Haven'
FROM Users u
JOIN HostRequests hr ON u.PersonID = hr.UserID 
WHERE hr.RequestID = 12;

-- Delete the host requests associated with the user
DELETE FROM HostRequests
WHERE UserID = @UserID;

-- Delete the user from the Users table
DELETE FROM Users
WHERE PersonID = @userID;

-- ---------------------Reject host Request---------------------
UPDATE HostRequests 
SET RequestStatus = 'Rejected', AdminID = 'admin_id', ResponseDate = CURRENT_TIMESTAMP 
WHERE RequestID = 'request_id';

-- ----------------------Upgrade user to host----------------------
UPDATE Persons 
SET Role = 'Host' 
WHERE PersonID = 'person_id';

--------------------------- view hosts-------------------------
SELECT * 
FROM Hosts;

-- ------------------View host Advertisements--------------------
SELECT * 
FROM HostAdvertisements;

-- -----------------Approve host advertisements------------------
-- UPDATE HostAdvertisements 
-- SET ApprovalStatus = 'Approved' 
-- WHERE AdvertID = 'advert_id';

-- ----------------------Reject host advertisemets----------------
-- UPDATE HostAdvertisements 
-- SET ApprovalStatus = 'Rejected' 
-- WHERE AdvertID = 'advert_id';

-- --------------------View user bookings--------------
SELECT * 
FROM Bookings 
WHERE UserID = '9';

-- ----------------------view reviews------------------
SELECT * 
FROM Reviews;

-- ----------------------delete reviews--------------------------
DELETE FROM Reviews 
WHERE ReviewID = 'review_id';

-- --------------------view transactions--------------------
SELECT * 
FROM Transactions;

-- -----------------delete transactions-----------------
DELETE FROM Transactions 
WHERE TransactionID = 'transaction_id';


-- ######################################################################################################################################################
-- ###################################################################### SAMPLE DATA ################################################################
-- ######################################################################################################################################################


-- ----------------------------------USER INSERTION --------------------------
INSERT INTO Persons (Role) VALUES ('User');

-- Get the PersonID of the newly inserted user
SET @personID = LAST_INSERT_ID();
SET @userID = LAST_INSERT_ID();
INSERT INTO Users (userID, PersonID, Username, Password, Email, FirstName, LastName) 
VALUES (@userID,@personID, 'tom', '123', 'tom@gmail.com', 'Tom', 'holand');
-- (@userID,@personID, 'mahbub', '123', 'mahbub@gmail.com', 'mahbub', 'ahmed')
-- (@userID,@personID, 'ahmed', '123', 'ahmed@gmail.com', 'ahmed', 'turza'),
-- (@userID,@personID, 'tonmay', '123', 'tonmay@example.com', 'tonmay', 'bissas'),
-- (@userID,@personID, 'rahul', '123', 'rahul@gmail.com', 'mahfuz', 'rahul'),
-- (@userID,@personID, 'ruman', '123', 'ruman@gmail.com', 'ruman', 'sarkar'),
-- (@userID,@personID, 'shejan', '123', 'shejan@gmail.com', 'abu', 'sayeam'),
-- (@userID,@personID, 'dipu', '123', 'dipu@gmail.com', 'maqsud', 'jamil'),
-- (@userID,@personID, 'arif', '123', 'arif@gmail.com', 'arif', 'hasan'),
-- (@userID,@personID, 'tahsin', '123', 'tahsin@gmail.com', 'tahsin', 'hasan'),
-- (@userID, @personID, 'jane_smith', 'pass123', 'jane.smith@example.com', 'Jane', 'Smith'),
-- (@userID, @personID, 'william_miller', 'will123', 'william.miller@example.com', 'William', 'Miller'),
-- (@userID, @personID, 'sophia_carter', 'sophia456', 'sophia.carter@example.com', 'Sophia', 'Carter'),
-- (@userID, @personID, 'emily', 'password123', 'emily@gmail.com', 'Emily', 'Wilson'),
-- (@userID, @personID, 'michael', 'password456', 'michael@gmail.com', 'Michael', 'Brown')
-- (@userID, @personID, 'sophie', 'password789', 'sophie@gmail.com', 'Sophie', 'Taylor')
-- (@userID, @personID, 'alexander', 'password123', 'alexander@gmail.com', 'Alexander', 'Clark')
-- (@userID, @personID, 'olivia', 'password456', 'olivia@gmail.com', 'Olivia', 'Martinez')
-- (@userID, @personID, 'jacob', 'password789', 'jacob@gmail.com', 'Jacob', 'Lee')
-- (@userID, @personID, 'emma', 'password123', 'emma@gmail.com', 'Emma', 'Garcia')
-- (@userID, @personID, 'ava', 'password789', 'ava@gmail.com', 'Ava', 'Lopez')
-- (@userID, @personID, 'ethan', 'password123', 'ethan@gmail.com', 'Ethan', 'Gonzalez')
-- (@userID, @personID, 'james', 'password789', 'james@gmail.com', 'James', 'Hernandez')
-- (@userID, @personID, 'lucas', 'password123', 'lucas@gmail.com', 'Lucas', 'Garcia')
-- (@userID, @personID, 'natalie', 'password123', 'natalie@gmail.com', 'Natalie', 'Portman')
-- (@userID, @personID, 'isabella', 'password456', 'isabella@gmail.com', 'Isabella', 'Martinez')

-- --------------------------------------ADVERTISEMENTS------------------------

INSERT INTO HostAdvertisements (HostID, AdvertisementContent, Title, Price, Place) 
VALUES 
(1, 'Cozy apartment in the heart of the city', 'City Apartment', 100, 'Downtown'),
(1, 'Spacious house with garden and pool', 'Family Home', 200, 'Suburbs'),
(1, 'Luxury villa with panoramic sea view', 'Sea View Villa', 500, 'Coast'),
(2, 'Stylish beachfront villa with breathtaking views', 'Beachfront Villa', 300, 'Beachfront'),
(2, 'Cozy beach house steps away from the ocean', 'Beach House Retreat', 150, 'Beachfront'),
(2, 'Modern condo with ocean view balcony', 'Ocean View Condo', 200, 'Oceanfront'),
(3, 'Elegant mansion with private pool and beach access', 'Luxury Mansion', 800, 'Beachfront'),
(3, 'Secluded beach house surrounded by lush gardens', 'Seaside Escape', 250, 'Beachfront'),
(3, 'Contemporary apartment with stunning coastal views', 'Coastal Apartment', 120, 'Coast'),
(4, 'Rustic log cabin nestled in the mountains', 'Mountain Cabin', 180, 'Mountains'),
(4, 'Charming chalet with ski-in/ski-out access', 'Ski Chalet Retreat', 250, 'Mountains'),
(4, 'Tranquil mountain lodge with panoramic views', 'Mountain Lodge', 300, 'Mountains'),
(5, 'Idyllic lakeside cottage with private dock', 'Lakeside Cottage', 150, 'Lakeside'),
(5, 'Serene cabin retreat with stunning lake views', 'Lakeview Cabin', 180, 'Lakeside'),
(5, 'Cozy log cabin nestled in the woods', 'Woodsy Retreat', 120, 'Forest'),
(6, 'Charming countryside cottage with garden views', 'Country Cottage', 100, 'Countryside'),
(6, 'Peaceful farmhouse retreat surrounded by nature', 'Farmhouse Retreat', 200, 'Countryside'),
(6, 'Tranquil retreat with scenic views of rolling hills', 'Hilltop Hideaway', 150, 'Hills'),
(7, 'Quaint village house with rustic charm', 'Village House', 80, 'Village'),
(7, 'Historic cottage in the heart of the village', 'Historic Cottage', 120, 'Village'),
(7, 'Traditional farmhouse with modern amenities', 'Farmhouse Getaway', 150, 'Countryside'),
(8, 'Modern loft with urban chic decor', 'Urban Loft', 200, 'City Center'),
(8, 'Luxury penthouse with skyline views', 'City Skyline Penthouse', 500, 'City Center'),
(8, 'Sleek apartment in the heart of downtown', 'Downtown Apartment', 150, 'City Center'),
(9, 'Cozy studio apartment with city views', 'City View Studio', 100, 'City Center'),
(9, 'Chic urban apartment in trendy neighborhood', 'Trendy Apartment', 120, 'Trendy District'),
(9, 'Spacious loft with industrial-chic design', 'Industrial Loft', 180, 'City Center'),
(10, 'Elegant townhouse in historic district', 'Historic Townhouse', 250, 'Historic District'),
(10, 'Classic brownstone with charming character', 'Brownstone Retreat', 200, 'City Center'),
(10, 'Luxurious mansion with period details', 'Period Mansion', 800, 'Estate'),
(11, 'Stunning waterfront estate with private beach', 'Waterfront Estate', 1000, 'Waterfront'),
(11, 'Exclusive island retreat with panoramic ocean views', 'Island Paradise', 1500, 'Island'),
(11, 'Magnificent castle overlooking the sea', 'Seaside Castle', 2000, 'Coast');

-- ######################################################################################################################################################
-- ######################################################################  OTHER COMMANDS ################################################################
-- ######################################################################################################################################################


-- -------------------FOR FORIEGN KEY ENABLE-DISABLE---------------
SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;

-- -------------------FOR UPDATE ENABLE-DISABLE---------------
SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

-- ------------------ ADD COLUMN --------------------------
ALTER TABLE reviews
ADD COLUMN userID INT;


-- ------------------- DROP COLUMN ----------------------
ALTER TABLE TABLENAME
DROP COLUMN COLUMNNAME;


