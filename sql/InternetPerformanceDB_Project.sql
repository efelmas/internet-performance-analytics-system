--- Efe Elmas 2022205189, INTT48O Term Project


-- PART 1: DATABASE

CREATE DATABASE InternetPerformanceDB;

USE InternetPerformanceDB;


CREATE TABLE Locations (
    location_id INT PRIMARY KEY IDENTITY(1,1),
    city NVARCHAR(50),
    region NVARCHAR(50)
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    location_id INT,
    subscription_type NVARCHAR(50) NOT NULL
);

CREATE TABLE Devices (
    device_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    device_type NVARCHAR(50),
    brand NVARCHAR(50)
);

CREATE TABLE Routers (
    router_id INT PRIMARY KEY IDENTITY(1,1),
    model NVARCHAR(50),
    firmware_version NVARCHAR(50)
);

CREATE TABLE Sessions (
    session_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    router_id INT,
    start_time DATETIME,
    end_time DATETIME
);

CREATE TABLE Network_Logs (
    log_id INT PRIMARY KEY IDENTITY(1,1),
    session_id INT,
    timestamp DATETIME,
    download_speed FLOAT,
    upload_speed FLOAT,
    latency FLOAT,
    signal_strength INT
);

CREATE TABLE Errors (
    error_id INT PRIMARY KEY IDENTITY(1,1),
    session_id INT,
    error_type NVARCHAR(50),
    error_time DATETIME
);


ALTER TABLE Users
ADD CONSTRAINT FK_Users_Locations
FOREIGN KEY (location_id) REFERENCES Locations(location_id);

ALTER TABLE Devices
ADD CONSTRAINT FK_Devices_Users
FOREIGN KEY (user_id) REFERENCES Users(user_id);

ALTER TABLE Sessions
ADD CONSTRAINT FK_Sessions_Users
FOREIGN KEY (user_id) REFERENCES Users(user_id);

ALTER TABLE Sessions
ADD CONSTRAINT FK_Sessions_Routers
FOREIGN KEY (router_id) REFERENCES Routers(router_id);

ALTER TABLE Network_Logs
ADD CONSTRAINT FK_Logs_Sessions
FOREIGN KEY (session_id) REFERENCES Sessions(session_id);

ALTER TABLE Errors
ADD CONSTRAINT FK_Errors_Sessions
FOREIGN KEY (session_id) REFERENCES Sessions(session_id);

ALTER TABLE Network_Logs
ADD CONSTRAINT CK_DownloadSpeed
CHECK (download_speed >= 0);

ALTER TABLE Network_Logs
ADD CONSTRAINT CK_Latency
CHECK (latency >= 0 AND latency <= 1000);

ALTER TABLE Users
ADD CONSTRAINT DF_Subscription
DEFAULT 'Basic' FOR subscription_type;

--

INSERT INTO Locations (city, region)
VALUES 
('Istanbul', 'Marmara'),
('Ankara', 'Central Anatolia'),
('Izmir', 'Aegean'),
('Bursa', 'Marmara'),
('Antalya', 'Mediterranean');

INSERT INTO Locations (city, region)
VALUES
('Adana','Mediterranean'),
('Trabzon','Black Sea'),
('Gaziantep','Southeastern'),
('Eskisehir','Central Anatolia'),
('Konya','Central Anatolia');

--

INSERT INTO Users (location_id, subscription_type)
VALUES
(1, 'Premium'),
(1, 'Basic'),
(2, 'Basic'),
(3, 'Premium'),
(4, 'Basic'),
(5, 'Premium'),
(2, 'Premium'),
(3, 'Basic'),
(1, 'Premium'),
(4, 'Basic'),
(5, 'Basic'),
(2, 'Premium'),
(3, 'Premium'),
(1, 'Basic'),
(4, 'Premium');

INSERT INTO Users (location_id, subscription_type)
VALUES
(1,'Premium'),
(1,'Basic'),
(2,'Basic'),
(3,'Premium'),
(4,'Basic'),
(5,'Premium'),
(6,'Basic'),
(7,'Premium'),
(8,'Basic'),
(9,'Premium'),
(10,'Basic'),
(2,'Premium'),
(3,'Basic'),
(4,'Premium'),
(5,'Basic'),
(6,'Premium'),
(7,'Basic'),
(8,'Premium'),
(9,'Basic'),
(10,'Premium'),
(1,'Basic'),
(2,'Basic'),
(3,'Premium'),
(4,'Basic'),
(5,'Premium'),
(6,'Basic'),
(7,'Premium'),
(8,'Basic'),
(9,'Premium'),
(10,'Basic'),
(1,'Premium'),
(3,'Basic'),
(5,'Premium'),
(7,'Basic'),
(9,'Premium');

-- 

INSERT INTO Routers (model, firmware_version)
VALUES
('TP-Link X', 'v1.0'),
('TP-Link X', 'v2.0'),
('Huawei Z', 'v1.1'),
('Huawei Z', 'v2.1'),
('Asus Pro', 'v3.0'),
('Netgear Ultra', 'v1.5');

INSERT INTO Routers (model, firmware_version)
VALUES
('TP-Link AX55','v2.2'),
('Asus RT-AX86','v3.1'),
('Netgear Nighthawk','v1.7'),
('Huawei AX3','v2.0'),
('Xiaomi Router Pro','v1.5'),
('Cisco Home Hub','v4.0');

-- 

INSERT INTO Devices (user_id, device_type, brand)
VALUES
(1, 'Phone', 'Apple'),
(1, 'Laptop', 'Dell'),
(2, 'Phone', 'Samsung'),
(3, 'Laptop', 'Lenovo'),
(4, 'Tablet', 'Apple'),
(5, 'Phone', 'Xiaomi'),
(6, 'Laptop', 'HP'),
(7, 'Phone', 'Samsung'),
(8, 'Laptop', 'Asus'),
(9, 'Tablet', 'Huawei'),
(10, 'Phone', 'Apple'),
(11, 'Laptop', 'Dell'),
(12, 'Phone', 'Xiaomi'),
(13, 'Laptop', 'HP'),
(14, 'Tablet', 'Samsung'),
(15, 'Phone', 'Apple');

INSERT INTO Devices (user_id,device_type,brand)
VALUES
(16,'Phone','Samsung'),
(16,'Laptop','Dell'),
(17,'Phone','Apple'),
(18,'Tablet','Huawei'),
(19,'Laptop','Lenovo'),
(20,'Phone','Xiaomi'),
(21,'Phone','Apple'),
(21,'Laptop','HP'),
(22,'Tablet','Samsung'),
(23,'Phone','Samsung'),
(24,'Laptop','Asus'),
(25,'Phone','Apple'),
(26,'Laptop','Dell'),
(27,'Tablet','Huawei'),
(28,'Phone','Xiaomi'),
(29,'Laptop','HP'),
(30,'Phone','Samsung'),
(31,'Laptop','Lenovo'),
(32,'Tablet','Apple'),
(33,'Phone','Xiaomi'),
(34,'Laptop','Asus'),
(35,'Phone','Samsung'),
(36,'Laptop','Dell'),
(37,'Tablet','Huawei'),
(38,'Phone','Apple'),
(39,'Laptop','HP'),
(40,'Phone','Samsung'),
(41,'Laptop','Lenovo'),
(42,'Tablet','Apple'),
(43,'Phone','Xiaomi'),
(44,'Laptop','Dell'),
(45,'Phone','Apple'),
(46,'Laptop','HP'),
(47,'Tablet','Samsung'),
(48,'Phone','Huawei'),
(49,'Laptop','Asus'),
(50,'Phone','Apple');

-- 

INSERT INTO Sessions (user_id, router_id, start_time, end_time)
VALUES
(1, 1, '2026-04-01 09:00', '2026-04-01 10:00'),
(1, 2, '2026-04-01 20:00', '2026-04-01 21:00'),
(2, 3, '2026-04-01 14:00', '2026-04-01 15:00'),
(3, 1, '2026-04-01 19:00', '2026-04-01 20:00'),
(4, 4, '2026-04-01 08:00', '2026-04-01 09:00'),
(5, 5, '2026-04-01 22:00', '2026-04-01 23:00'),
(6, 2, '2026-04-01 11:00', '2026-04-01 12:00'),
(7, 3, '2026-04-01 21:00', '2026-04-01 22:00'),
(8, 1, '2026-04-01 13:00', '2026-04-01 14:00'),
(9, 6, '2026-04-01 18:00', '2026-04-01 19:00');

INSERT INTO Sessions (user_id, router_id, start_time, end_time)
VALUES
(10, 1, '2026-04-02 09:00', '2026-04-02 10:00'),
(11, 2, '2026-04-02 10:00', '2026-04-02 11:00'),
(12, 3, '2026-04-02 11:00', '2026-04-02 12:00'),
(13, 4, '2026-04-02 12:00', '2026-04-02 13:00'),
(14, 5, '2026-04-02 13:00', '2026-04-02 14:00'),
(15, 6, '2026-04-02 14:00', '2026-04-02 15:00'),
(16, 7, '2026-04-02 18:00', '2026-04-02 19:00'),
(17, 8, '2026-04-02 19:00', '2026-04-02 20:00'),
(18, 9, '2026-04-02 20:00', '2026-04-02 21:00'),
(19, 10, '2026-04-02 21:00', '2026-04-02 22:00'),

(20, 11, '2026-04-03 09:00', '2026-04-03 10:00'),
(21, 12, '2026-04-03 10:00', '2026-04-03 11:00'),
(22, 1, '2026-04-03 11:00', '2026-04-03 12:00'),
(23, 2, '2026-04-03 12:00', '2026-04-03 13:00'),
(24, 3, '2026-04-03 13:00', '2026-04-03 14:00'),
(25, 4, '2026-04-03 14:00', '2026-04-03 15:00'),
(26, 5, '2026-04-03 18:00', '2026-04-03 19:00'),
(27, 6, '2026-04-03 19:00', '2026-04-03 20:00'),
(28, 7, '2026-04-03 20:00', '2026-04-03 21:00'),
(29, 8, '2026-04-03 21:00', '2026-04-03 22:00'),

(30, 9, '2026-04-04 09:00', '2026-04-04 10:00'),
(31, 10, '2026-04-04 10:00', '2026-04-04 11:00'),
(32, 11, '2026-04-04 11:00', '2026-04-04 12:00'),
(33, 12, '2026-04-04 12:00', '2026-04-04 13:00'),
(34, 1, '2026-04-04 13:00', '2026-04-04 14:00'),
(35, 2, '2026-04-04 14:00', '2026-04-04 15:00'),
(36, 3, '2026-04-04 18:00', '2026-04-04 19:00'),
(37, 4, '2026-04-04 19:00', '2026-04-04 20:00'),
(38, 5, '2026-04-04 20:00', '2026-04-04 21:00'),
(39, 6, '2026-04-04 21:00', '2026-04-04 22:00'),

(40, 7, '2026-04-05 09:00', '2026-04-05 10:00'),
(41, 8, '2026-04-05 10:00', '2026-04-05 11:00'),
(42, 9, '2026-04-05 11:00', '2026-04-05 12:00'),
(43, 10, '2026-04-05 12:00', '2026-04-05 13:00'),
(44, 11, '2026-04-05 13:00', '2026-04-05 14:00'),
(45, 12, '2026-04-05 14:00', '2026-04-05 15:00'),
(46, 1, '2026-04-05 18:00', '2026-04-05 19:00'),
(47, 2, '2026-04-05 19:00', '2026-04-05 20:00'),
(48, 3, '2026-04-05 20:00', '2026-04-05 21:00'),
(49, 4, '2026-04-05 21:00', '2026-04-05 22:00');

INSERT INTO Sessions (user_id, router_id, start_time, end_time)
VALUES
(1,7,'2026-04-06 09:00','2026-04-06 10:00'),
(2,8,'2026-04-06 10:00','2026-04-06 11:00'),
(3,9,'2026-04-06 11:00','2026-04-06 12:00'),
(4,10,'2026-04-06 12:00','2026-04-06 13:00'),
(5,11,'2026-04-06 13:00','2026-04-06 14:00'),
(6,12,'2026-04-06 14:00','2026-04-06 15:00'),

(7,1,'2026-04-06 18:00','2026-04-06 19:00'),
(8,2,'2026-04-06 19:00','2026-04-06 20:00'),
(9,3,'2026-04-06 20:00','2026-04-06 21:00'),
(10,4,'2026-04-06 21:00','2026-04-06 22:00'),

(11,5,'2026-04-07 09:00','2026-04-07 10:00'),
(12,6,'2026-04-07 10:00','2026-04-07 11:00'),
(13,7,'2026-04-07 11:00','2026-04-07 12:00'),
(14,8,'2026-04-07 12:00','2026-04-07 13:00'),
(15,9,'2026-04-07 13:00','2026-04-07 14:00'),

(16,10,'2026-04-07 14:00','2026-04-07 15:00'),
(17,11,'2026-04-07 18:00','2026-04-07 19:00'),
(18,12,'2026-04-07 19:00','2026-04-07 20:00'),
(19,1,'2026-04-07 20:00','2026-04-07 21:00'),
(20,2,'2026-04-07 21:00','2026-04-07 22:00'),

(21,3,'2026-04-08 09:00','2026-04-08 10:00'),
(22,4,'2026-04-08 10:00','2026-04-08 11:00'),
(23,5,'2026-04-08 11:00','2026-04-08 12:00'),
(24,6,'2026-04-08 12:00','2026-04-08 13:00'),
(25,7,'2026-04-08 13:00','2026-04-08 14:00'),

(26,8,'2026-04-08 14:00','2026-04-08 15:00'),
(27,9,'2026-04-08 18:00','2026-04-08 19:00'),
(28,10,'2026-04-08 19:00','2026-04-08 20:00'),
(29,11,'2026-04-08 20:00','2026-04-08 21:00'),
(30,12,'2026-04-08 21:00','2026-04-08 22:00'),

(31,1,'2026-04-09 09:00','2026-04-09 10:00'),
(32,2,'2026-04-09 10:00','2026-04-09 11:00'),
(33,3,'2026-04-09 11:00','2026-04-09 12:00'),
(34,4,'2026-04-09 12:00','2026-04-09 13:00'),
(35,5,'2026-04-09 13:00','2026-04-09 14:00'),

(36,6,'2026-04-09 14:00','2026-04-09 15:00'),
(37,7,'2026-04-09 18:00','2026-04-09 19:00'),
(38,8,'2026-04-09 19:00','2026-04-09 20:00'),
(39,9,'2026-04-09 20:00','2026-04-09 21:00'),
(40,10,'2026-04-09 21:00','2026-04-09 22:00'),

(41,11,'2026-04-10 09:00','2026-04-10 10:00'),
(42,12,'2026-04-10 10:00','2026-04-10 11:00'),
(43,1,'2026-04-10 11:00','2026-04-10 12:00'),
(44,2,'2026-04-10 12:00','2026-04-10 13:00'),
(45,3,'2026-04-10 13:00','2026-04-10 14:00'),

(46,4,'2026-04-10 14:00','2026-04-10 15:00'),
(47,5,'2026-04-10 18:00','2026-04-10 19:00'),
(48,6,'2026-04-10 19:00','2026-04-10 20:00'),
(49,7,'2026-04-10 20:00','2026-04-10 21:00'),
(50,8,'2026-04-10 21:00','2026-04-10 22:00');

-- 

INSERT INTO Network_Logs (session_id, timestamp, download_speed, upload_speed, latency, signal_strength)
VALUES
(1, '2026-04-01 09:10', 60, 15, 20, -50),
(1, '2026-04-01 09:20', 55, 12, 25, -55),

(2, '2026-04-01 20:10', 15, 5, 80, -85),
(2, '2026-04-01 20:20', 10, 4, 100, -90),

(3, '2026-04-01 14:10', 40, 10, 30, -60),

(4, '2026-04-01 19:10', 20, 6, 70, -80),

(5, '2026-04-01 08:10', 70, 20, 15, -45);

INSERT INTO Network_Logs (session_id, timestamp, download_speed, upload_speed, latency, signal_strength)
VALUES
(11, '2026-04-02 09:10', 72, 18, 18, -48),
(11, '2026-04-02 09:30', 70, 17, 20, -50),
(11, '2026-04-02 09:50', 68, 16, 22, -52),

(12, '2026-04-02 10:10', 45, 10, 32, -62),
(12, '2026-04-02 10:30', 42, 9, 35, -65),
(12, '2026-04-02 10:50', 40, 9, 36, -67),

(13, '2026-04-02 11:10', 82, 20, 16, -46),
(13, '2026-04-02 11:30', 79, 19, 18, -48),
(13, '2026-04-02 11:50', 77, 18, 20, -50),

(14, '2026-04-02 12:10', 38, 8, 40, -70),
(14, '2026-04-02 12:30', 35, 7, 43, -72),
(14, '2026-04-02 12:50', 34, 7, 45, -74),

(15, '2026-04-02 13:10', 60, 14, 24, -55),
(15, '2026-04-02 13:30', 58, 13, 25, -57),
(15, '2026-04-02 13:50', 56, 13, 27, -58),

(16, '2026-04-02 14:10', 48, 11, 34, -66),
(16, '2026-04-02 14:30', 46, 10, 36, -68),
(16, '2026-04-02 14:50', 44, 10, 38, -70),

(17, '2026-04-02 18:10', 28, 6, 65, -78),
(17, '2026-04-02 18:30', 25, 5, 72, -82),
(17, '2026-04-02 18:50', 22, 5, 78, -85),

(18, '2026-04-02 19:10', 20, 5, 80, -83),
(18, '2026-04-02 19:30', 18, 4, 88, -86),
(18, '2026-04-02 19:50', 16, 4, 95, -89),

(19, '2026-04-02 20:10', 32, 7, 60, -76),
(19, '2026-04-02 20:30', 28, 6, 68, -80),
(19, '2026-04-02 20:50', 26, 6, 74, -82),

(20, '2026-04-02 21:10', 24, 5, 82, -84),
(20, '2026-04-02 21:30', 21, 5, 90, -87),
(20, '2026-04-02 21:50', 18, 4, 98, -90),

(21, '2026-04-03 09:10', 75, 18, 17, -47),
(21, '2026-04-03 09:30', 73, 18, 18, -49),
(21, '2026-04-03 09:50', 71, 17, 20, -50),

(22, '2026-04-03 10:10', 50, 12, 28, -60),
(22, '2026-04-03 10:30', 48, 11, 30, -62),
(22, '2026-04-03 10:50', 45, 10, 32, -64),

(23, '2026-04-03 11:10', 65, 15, 22, -54),
(23, '2026-04-03 11:30', 63, 15, 24, -56),
(23, '2026-04-03 11:50', 60, 14, 25, -58),

(24, '2026-04-03 12:10', 40, 9, 38, -68),
(24, '2026-04-03 12:30', 38, 8, 40, -70),
(24, '2026-04-03 12:50', 36, 8, 43, -72),

(25, '2026-04-03 13:10', 85, 22, 15, -45),
(25, '2026-04-03 13:30', 82, 21, 16, -47),
(25, '2026-04-03 13:50', 80, 20, 18, -49),

(26, '2026-04-03 14:10', 55, 13, 26, -57),
(26, '2026-04-03 14:30', 53, 12, 28, -59),
(26, '2026-04-03 14:50', 51, 12, 30, -61),

(27, '2026-04-03 18:10', 30, 7, 62, -77),
(27, '2026-04-03 18:30', 27, 6, 70, -81),
(27, '2026-04-03 18:50', 24, 5, 77, -84),

(28, '2026-04-03 19:10', 19, 4, 84, -85),
(28, '2026-04-03 19:30', 17, 4, 92, -88),
(28, '2026-04-03 19:50', 15, 3, 105, -91),

(29, '2026-04-03 20:10', 34, 8, 58, -75),
(29, '2026-04-03 20:30', 30, 7, 66, -79),
(29, '2026-04-03 20:50', 27, 6, 73, -82),

(30, '2026-04-03 21:10', 23, 5, 86, -86),
(30, '2026-04-03 21:30', 20, 4, 94, -89),
(30, '2026-04-03 21:50', 18, 4, 100, -90);

INSERT INTO Network_Logs (session_id, timestamp, download_speed, upload_speed, latency, signal_strength)
VALUES
(31, '2026-04-04 09:10', 78, 19, 16, -46),
(31, '2026-04-04 09:30', 76, 18, 18, -48),
(31, '2026-04-04 09:50', 74, 18, 19, -50),

(32, '2026-04-04 10:10', 47, 11, 30, -61),
(32, '2026-04-04 10:30', 45, 10, 32, -63),
(32, '2026-04-04 10:50', 43, 10, 34, -65),

(33, '2026-04-04 11:10', 88, 22, 14, -44),
(33, '2026-04-04 11:30', 85, 21, 15, -46),
(33, '2026-04-04 11:50', 82, 20, 17, -48),

(34, '2026-04-04 12:10', 52, 12, 27, -58),
(34, '2026-04-04 12:30', 50, 12, 29, -60),
(34, '2026-04-04 12:50', 48, 11, 31, -62),

(35, '2026-04-04 13:10', 62, 15, 24, -55),
(35, '2026-04-04 13:30', 60, 14, 25, -57),
(35, '2026-04-04 13:50', 58, 14, 27, -59),

(36, '2026-04-04 14:10', 42, 10, 37, -69),
(36, '2026-04-04 14:30', 40, 9, 40, -72),
(36, '2026-04-04 14:50', 38, 9, 44, -74),

(37, '2026-04-04 18:10', 29, 7, 63, -78),
(37, '2026-04-04 18:30', 26, 6, 71, -82),
(37, '2026-04-04 18:50', 23, 5, 79, -85),

(38, '2026-04-04 19:10', 21, 5, 82, -84),
(38, '2026-04-04 19:30', 18, 4, 90, -87),
(38, '2026-04-04 19:50', 16, 4, 99, -90),

(39, '2026-04-04 20:10', 35, 8, 59, -75),
(39, '2026-04-04 20:30', 31, 7, 67, -79),
(39, '2026-04-04 20:50', 28, 6, 74, -82),

(40, '2026-04-04 21:10', 25, 6, 80, -83),
(40, '2026-04-04 21:30', 22, 5, 88, -86),
(40, '2026-04-04 21:50', 19, 4, 96, -89),

(41, '2026-04-05 09:10', 80, 20, 15, -45),
(41, '2026-04-05 09:30', 78, 19, 16, -47),
(41, '2026-04-05 09:50', 76, 18, 18, -49),

(42, '2026-04-05 10:10', 46, 11, 31, -62),
(42, '2026-04-05 10:30', 44, 10, 33, -64),
(42, '2026-04-05 10:50', 42, 10, 35, -66),

(43, '2026-04-05 11:10', 68, 16, 21, -53),
(43, '2026-04-05 11:30', 66, 15, 23, -55),
(43, '2026-04-05 11:50', 64, 15, 24, -57),

(44, '2026-04-05 12:10', 39, 9, 41, -70),
(44, '2026-04-05 12:30', 37, 8, 44, -73),
(44, '2026-04-05 12:50', 35, 8, 47, -75),

(45, '2026-04-05 13:10', 90, 23, 13, -43),
(45, '2026-04-05 13:30', 87, 22, 15, -45),
(45, '2026-04-05 13:50', 84, 21, 16, -47),

(46, '2026-04-05 14:10', 57, 14, 26, -58),
(46, '2026-04-05 14:30', 55, 13, 28, -60),
(46, '2026-04-05 14:50', 53, 13, 30, -62),

(47, '2026-04-05 18:10', 31, 7, 61, -77),
(47, '2026-04-05 18:30', 28, 6, 69, -81),
(47, '2026-04-05 18:50', 25, 6, 76, -84),

(48, '2026-04-05 19:10', 22, 5, 83, -85),
(48, '2026-04-05 19:30', 19, 4, 91, -88),
(48, '2026-04-05 19:50', 17, 4, 101, -91),

(49, '2026-04-05 20:10', 33, 8, 60, -76),
(49, '2026-04-05 20:30', 29, 7, 68, -80),
(49, '2026-04-05 20:50', 26, 6, 75, -83),

(50, '2026-04-05 21:10', 24, 5, 85, -86),
(50, '2026-04-05 21:30', 21, 5, 93, -89),
(50, '2026-04-05 21:50', 18, 4, 102, -91);

INSERT INTO Network_Logs (session_id, timestamp, download_speed, upload_speed, latency, signal_strength)
VALUES
(51, '2026-04-06 09:10', 82, 21, 15, -45),
(51, '2026-04-06 09:30', 79, 20, 17, -47),
(51, '2026-04-06 09:50', 77, 19, 18, -49),

(52, '2026-04-06 10:10', 44, 10, 33, -64),
(52, '2026-04-06 10:30', 42, 10, 35, -66),
(52, '2026-04-06 10:50', 40, 9, 37, -68),

(53, '2026-04-06 11:10', 78, 19, 17, -48),
(53, '2026-04-06 11:30', 75, 18, 19, -50),
(53, '2026-04-06 11:50', 73, 18, 20, -52),

(54, '2026-04-06 12:10', 58, 14, 27, -59),
(54, '2026-04-06 12:30', 56, 13, 29, -61),
(54, '2026-04-06 12:50', 54, 13, 31, -63),

(55, '2026-04-06 13:10', 86, 22, 14, -44),
(55, '2026-04-06 13:30', 83, 21, 16, -46),
(55, '2026-04-06 13:50', 81, 20, 17, -48),

(56, '2026-04-06 14:10', 61, 15, 25, -56),
(56, '2026-04-06 14:30', 59, 14, 27, -58),
(56, '2026-04-06 14:50', 57, 14, 29, -60),

(57, '2026-04-06 18:10', 30, 7, 64, -78),
(57, '2026-04-06 18:30', 27, 6, 72, -82),
(57, '2026-04-06 18:50', 24, 5, 80, -85),

(58, '2026-04-06 19:10', 23, 5, 84, -85),
(58, '2026-04-06 19:30', 20, 5, 92, -88),
(58, '2026-04-06 19:50', 18, 4, 101, -91),

(59, '2026-04-06 20:10', 34, 8, 60, -76),
(59, '2026-04-06 20:30', 30, 7, 68, -80),
(59, '2026-04-06 20:50', 27, 6, 76, -83),

(60, '2026-04-06 21:10', 25, 6, 83, -84),
(60, '2026-04-06 21:30', 22, 5, 91, -87),
(60, '2026-04-06 21:50', 19, 4, 99, -90),

(61, '2026-04-07 09:10', 70, 17, 20, -51),
(61, '2026-04-07 09:30', 68, 16, 22, -53),
(61, '2026-04-07 09:50', 66, 16, 24, -55),

(62, '2026-04-07 10:10', 52, 12, 29, -60),
(62, '2026-04-07 10:30', 50, 12, 31, -62),
(62, '2026-04-07 10:50', 48, 11, 33, -64),

(63, '2026-04-07 11:10', 84, 21, 15, -45),
(63, '2026-04-07 11:30', 81, 20, 17, -47),
(63, '2026-04-07 11:50', 79, 19, 18, -49),

(64, '2026-04-07 12:10', 39, 9, 41, -70),
(64, '2026-04-07 12:30', 37, 8, 44, -73),
(64, '2026-04-07 12:50', 35, 8, 47, -75),

(65, '2026-04-07 13:10', 63, 15, 24, -55),
(65, '2026-04-07 13:30', 61, 15, 25, -57),
(65, '2026-04-07 13:50', 59, 14, 27, -59),

(66, '2026-04-07 14:10', 46, 11, 35, -67),
(66, '2026-04-07 14:30', 44, 10, 38, -69),
(66, '2026-04-07 14:50', 42, 10, 40, -71),

(67, '2026-04-07 18:10', 29, 7, 65, -79),
(67, '2026-04-07 18:30', 26, 6, 73, -82),
(67, '2026-04-07 18:50', 23, 5, 81, -86),

(68, '2026-04-07 19:10', 21, 5, 85, -86),
(68, '2026-04-07 19:30', 18, 4, 94, -89),
(68, '2026-04-07 19:50', 16, 4, 103, -92),

(69, '2026-04-07 20:10', 33, 8, 61, -77),
(69, '2026-04-07 20:30', 29, 7, 69, -80),
(69, '2026-04-07 20:50', 26, 6, 77, -84),

(70, '2026-04-07 21:10', 24, 5, 86, -86),
(70, '2026-04-07 21:30', 21, 5, 94, -89),
(70, '2026-04-07 21:50', 18, 4, 102, -91),

(71, '2026-04-08 09:10', 76, 18, 18, -49),
(71, '2026-04-08 09:30', 74, 18, 20, -51),
(71, '2026-04-08 09:50', 72, 17, 21, -53),

(72, '2026-04-08 10:10', 43, 10, 34, -65),
(72, '2026-04-08 10:30', 41, 9, 36, -67),
(72, '2026-04-08 10:50', 39, 9, 38, -69),

(73, '2026-04-08 11:10', 66, 16, 22, -54),
(73, '2026-04-08 11:30', 64, 15, 24, -56),
(73, '2026-04-08 11:50', 62, 15, 25, -58),

(74, '2026-04-08 12:10', 41, 9, 39, -69),
(74, '2026-04-08 12:30', 39, 9, 42, -72),
(74, '2026-04-08 12:50', 37, 8, 45, -74),

(75, '2026-04-08 13:10', 88, 22, 14, -44),
(75, '2026-04-08 13:30', 85, 21, 16, -46),
(75, '2026-04-08 13:50', 83, 20, 17, -48);

INSERT INTO Network_Logs (session_id, timestamp, download_speed, upload_speed, latency, signal_strength)
VALUES

(76,'2026-04-08 14:10',58,14,26,-57),
(76,'2026-04-08 14:30',56,13,28,-59),
(76,'2026-04-08 14:50',54,13,30,-61),

(77,'2026-04-08 18:10',31,7,62,-78),
(77,'2026-04-08 18:30',28,6,71,-82),
(77,'2026-04-08 18:50',25,6,79,-85),

(78,'2026-04-08 19:10',22,5,84,-85),
(78,'2026-04-08 19:30',19,4,93,-88),
(78,'2026-04-08 19:50',17,4,102,-91),

(79,'2026-04-08 20:10',34,8,60,-76),
(79,'2026-04-08 20:30',30,7,68,-80),
(79,'2026-04-08 20:50',27,6,76,-83),

(80,'2026-04-08 21:10',24,5,87,-86),
(80,'2026-04-08 21:30',21,5,95,-89),
(80,'2026-04-08 21:50',18,4,104,-92),

(81,'2026-04-09 09:10',79,20,16,-46),
(81,'2026-04-09 09:30',76,19,18,-48),
(81,'2026-04-09 09:50',74,18,20,-50),

(82,'2026-04-09 10:10',45,10,32,-63),
(82,'2026-04-09 10:30',43,10,34,-65),
(82,'2026-04-09 10:50',41,9,36,-67),

(83,'2026-04-09 11:10',84,21,15,-45),
(83,'2026-04-09 11:30',81,20,17,-47),
(83,'2026-04-09 11:50',79,19,19,-49),

(84,'2026-04-09 12:10',40,9,40,-69),
(84,'2026-04-09 12:30',38,8,43,-72),
(84,'2026-04-09 12:50',36,8,46,-74),

(85,'2026-04-09 13:10',65,16,23,-54),
(85,'2026-04-09 13:30',63,15,24,-56),
(85,'2026-04-09 13:50',61,15,26,-58),

(86,'2026-04-09 14:10',48,11,34,-66),
(86,'2026-04-09 14:30',46,10,37,-68),
(86,'2026-04-09 14:50',44,10,39,-70),

(87,'2026-04-09 18:10',29,7,66,-79),
(87,'2026-04-09 18:30',26,6,74,-82),
(87,'2026-04-09 18:50',23,5,82,-85),

(88,'2026-04-09 19:10',21,5,86,-86),
(88,'2026-04-09 19:30',18,4,95,-89),
(88,'2026-04-09 19:50',16,4,103,-91),

(89,'2026-04-09 20:10',33,8,61,-77),
(89,'2026-04-09 20:30',29,7,69,-80),
(89,'2026-04-09 20:50',26,6,77,-84),

(90,'2026-04-09 21:10',25,6,85,-86),
(90,'2026-04-09 21:30',22,5,94,-89),
(90,'2026-04-09 21:50',19,4,101,-91);

INSERT INTO Network_Logs (session_id, timestamp, download_speed, upload_speed, latency, signal_strength)
VALUES
(91, '2026-04-10 09:10', 78, 19, 17, -47),
(91, '2026-04-10 09:30', 76, 18, 19, -49),
(91, '2026-04-10 09:50', 74, 18, 21, -51),

(92, '2026-04-10 10:10', 46, 11, 32, -63),
(92, '2026-04-10 10:30', 44, 10, 34, -65),
(92, '2026-04-10 10:50', 42, 10, 36, -67),

(93, '2026-04-10 11:10', 69, 16, 22, -54),
(93, '2026-04-10 11:30', 67, 16, 24, -56),
(93, '2026-04-10 11:50', 65, 15, 25, -58),

(94, '2026-04-10 12:10', 43, 10, 38, -68),
(94, '2026-04-10 12:30', 41, 9, 41, -71),
(94, '2026-04-10 12:50', 39, 9, 44, -73),

(95, '2026-04-10 13:10', 87, 22, 14, -44),
(95, '2026-04-10 13:30', 84, 21, 16, -46),
(95, '2026-04-10 13:50', 82, 20, 18, -48),

(96, '2026-04-10 14:10', 55, 13, 27, -59),
(96, '2026-04-10 14:30', 53, 12, 29, -61),
(96, '2026-04-10 14:50', 51, 12, 31, -63),

(97, '2026-04-10 18:10', 30, 7, 63, -78),
(97, '2026-04-10 18:30', 27, 6, 71, -82),
(97, '2026-04-10 18:50', 24, 5, 80, -85),

(98, '2026-04-10 19:10', 22, 5, 85, -86),
(98, '2026-04-10 19:30', 19, 4, 94, -89),
(98, '2026-04-10 19:50', 17, 4, 102, -91),

(99, '2026-04-10 20:10', 34, 8, 60, -76),
(99, '2026-04-10 20:30', 30, 7, 69, -80),
(99, '2026-04-10 20:50', 27, 6, 77, -84),

(100, '2026-04-10 21:10', 25, 6, 86, -86),
(100, '2026-04-10 21:30', 22, 5, 95, -89),
(100, '2026-04-10 21:50', 19, 4, 103, -91);

-- 

INSERT INTO Errors (session_id, error_type, error_time)
VALUES
(2, 'Disconnect', '2026-04-01 20:30'),
(4, 'High Latency', '2026-04-01 19:30'),
(7, 'Timeout', '2026-04-01 21:30');

INSERT INTO Errors (session_id, error_type, error_time)
VALUES
(17, 'Weak Signal', '2026-04-02 18:35'),
(18, 'High Latency', '2026-04-02 19:40'),
(19, 'Slow Connection', '2026-04-02 20:45'),
(20, 'Disconnect', '2026-04-02 21:30'),

(27, 'Weak Signal', '2026-04-03 18:35'),
(28, 'High Latency', '2026-04-03 19:40'),
(29, 'Slow Connection', '2026-04-03 20:45'),
(30, 'Timeout', '2026-04-03 21:30');

INSERT INTO Errors (session_id, error_type, error_time)
VALUES
(37, 'Weak Signal', '2026-04-04 18:35'),
(38, 'High Latency', '2026-04-04 19:40'),
(39, 'Slow Connection', '2026-04-04 20:45'),
(40, 'Timeout', '2026-04-04 21:30'),

(44, 'Weak Signal', '2026-04-05 12:40'),
(47, 'Weak Signal', '2026-04-05 18:35'),
(48, 'High Latency', '2026-04-05 19:40'),
(49, 'Slow Connection', '2026-04-05 20:45'),
(50, 'Disconnect', '2026-04-05 21:30');

INSERT INTO Errors (session_id, error_type, error_time)
VALUES
(57, 'Weak Signal', '2026-04-06 18:35'),
(58, 'High Latency', '2026-04-06 19:40'),
(59, 'Slow Connection', '2026-04-06 20:45'),
(60, 'Timeout', '2026-04-06 21:30'),

(64, 'Weak Signal', '2026-04-07 12:40'),
(67, 'Weak Signal', '2026-04-07 18:35'),
(68, 'High Latency', '2026-04-07 19:40'),
(69, 'Slow Connection', '2026-04-07 20:45'),
(70, 'Disconnect', '2026-04-07 21:30'),

(74, 'Weak Signal', '2026-04-08 12:40');

INSERT INTO Errors (session_id,error_type,error_time)
VALUES

(77,'Weak Signal','2026-04-08 18:35'),
(78,'High Latency','2026-04-08 19:40'),
(79,'Slow Connection','2026-04-08 20:45'),
(80,'Disconnect','2026-04-08 21:30'),

(84,'Weak Signal','2026-04-09 12:40'),

(87,'Weak Signal','2026-04-09 18:35'),
(88,'High Latency','2026-04-09 19:40'),
(89,'Slow Connection','2026-04-09 20:45'),
(90,'Timeout','2026-04-09 21:30');

INSERT INTO Errors (session_id, error_type, error_time)
VALUES
(97, 'Weak Signal', '2026-04-10 18:35'),
(98, 'High Latency', '2026-04-10 19:40'),
(99, 'Slow Connection', '2026-04-10 20:45'),
(100, 'Timeout', '2026-04-10 21:30');


-- PART 2: JOIN QUERIES

-- 1
SELECT
    u.user_id,
    u.subscription_type,
    l.city,
    l.region
FROM Users u
INNER JOIN Locations l
ON u.location_id = l.location_id;

-- 2
SELECT
    u.user_id,
    u.subscription_type,
    d.device_type,
    d.brand
FROM Users u
INNER JOIN Devices d
ON u.user_id = d.user_id;

-- 3
SELECT
    s.session_id,
    u.user_id,
    u.subscription_type,
    r.model,
    r.firmware_version,
    s.start_time,
    s.end_time
FROM Sessions s
INNER JOIN Users u
ON s.user_id = u.user_id
INNER JOIN Routers r
ON s.router_id = r.router_id;

-- 4
SELECT
    u.user_id,
    u.subscription_type,
    l.city,
    l.region,
    s.session_id,
    n.timestamp,
    n.download_speed,
    n.upload_speed,
    n.latency,
    n.signal_strength
FROM Users u
INNER JOIN Locations l
ON u.location_id = l.location_id
INNER JOIN Sessions s
ON u.user_id = s.user_id
INNER JOIN Network_Logs n
ON s.session_id = n.session_id;


-- 5
SELECT
    e.error_id,
    e.error_type,
    e.error_time,
    s.session_id,
    u.user_id,
    u.subscription_type,
    s.start_time,
    s.end_time
FROM Errors e
INNER JOIN Sessions s
ON e.session_id = s.session_id
INNER JOIN Users u
ON s.user_id = u.user_id;

-- 6
SELECT
    l.city,
    l.region,
    AVG(n.download_speed) AS average_download_speed,
    AVG(n.latency) AS average_latency,
    COUNT(n.log_id) AS number_of_logs
FROM Locations l
INNER JOIN Users u
ON l.location_id = u.location_id
INNER JOIN Sessions s
ON u.user_id = s.user_id
INNER JOIN Network_Logs n
ON s.session_id = n.session_id
GROUP BY l.city, l.region;



-- 7
SELECT
    u.subscription_type,
    AVG(n.download_speed) AS average_download_speed,
    AVG(n.upload_speed) AS average_upload_speed,
    AVG(n.latency) AS average_latency,
    COUNT(n.log_id) AS number_of_logs
FROM Users u
INNER JOIN Sessions s
ON u.user_id = s.user_id
INNER JOIN Network_Logs n
ON s.session_id = n.session_id
GROUP BY u.subscription_type;



-- PART 3: VIEWS

-- 1
CREATE VIEW vw_UserLocations
AS
SELECT
    u.user_id,
    u.subscription_type,
    l.city,
    l.region
FROM Users u
INNER JOIN Locations l
ON u.location_id = l.location_id;

-- 2
CREATE VIEW vw_UserDevices
AS
SELECT
    u.user_id,
    u.subscription_type,
    d.device_id,
    d.device_type,
    d.brand
FROM Users u
INNER JOIN Devices d
ON u.user_id = d.user_id;



-- 3
CREATE VIEW vw_SessionDetails
AS
SELECT
    s.session_id,
    u.user_id,
    u.subscription_type,
    r.router_id,
    r.model,
    r.firmware_version,
    s.start_time,
    s.end_time
FROM Sessions s
INNER JOIN Users u
ON s.user_id = u.user_id
INNER JOIN Routers r
ON s.router_id = r.router_id;

-- 4
CREATE VIEW vw_NetworkPerformanceDetails
AS
SELECT
    n.log_id,
    n.session_id,
    u.user_id,
    u.subscription_type,
    l.city,
    l.region,
    n.timestamp,
    n.download_speed,
    n.upload_speed,
    n.latency,
    n.signal_strength
FROM Network_Logs n
INNER JOIN Sessions s
ON n.session_id = s.session_id
INNER JOIN Users u
ON s.user_id = u.user_id
INNER JOIN Locations l
ON u.location_id = l.location_id;



-- 5
CREATE VIEW vw_ErrorDetails
AS
SELECT
    e.error_id,
    e.error_type,
    e.error_time,
    s.session_id,
    u.user_id,
    u.subscription_type,
    l.city,
    l.region
FROM Errors e
INNER JOIN Sessions s
ON e.session_id = s.session_id
INNER JOIN Users u
ON s.user_id = u.user_id
INNER JOIN Locations l
ON u.location_id = l.location_id;


-- 6
CREATE VIEW vw_CityPerformanceSummary
AS
SELECT
    l.city,
    l.region,
    AVG(n.download_speed) AS average_download_speed,
    AVG(n.upload_speed) AS average_upload_speed,
    AVG(n.latency) AS average_latency,
    COUNT(n.log_id) AS number_of_logs
FROM Locations l
INNER JOIN Users u
ON l.location_id = u.location_id
INNER JOIN Sessions s
ON u.user_id = s.user_id
INNER JOIN Network_Logs n
ON s.session_id = n.session_id
GROUP BY l.city, l.region;


-- PART 4: STORED PROCEDURES

-- 1
CREATE PROCEDURE sp_GetAllUserLocations
AS
BEGIN
    SELECT
        u.user_id,
        u.subscription_type,
        l.city,
        l.region
    FROM Users u
    INNER JOIN Locations l
    ON u.location_id = l.location_id;
END;


-- 2
CREATE PROCEDURE sp_GetSessionsByUser
    @UserID INT
AS
BEGIN
    SELECT
        s.session_id,
        s.user_id,
        r.model,
        r.firmware_version,
        s.start_time,
        s.end_time
    FROM Sessions s
    INNER JOIN Routers r
    ON s.router_id = r.router_id
    WHERE s.user_id = @UserID;
END;


-- 3
CREATE PROCEDURE sp_GetPerformanceByCity
    @City NVARCHAR(50)
AS
BEGIN
    SELECT
        l.city,
        u.user_id,
        u.subscription_type,
        s.session_id,
        n.timestamp,
        n.download_speed,
        n.upload_speed,
        n.latency,
        n.signal_strength
    FROM Locations l
    INNER JOIN Users u
    ON l.location_id = u.location_id
    INNER JOIN Sessions s
    ON u.user_id = s.user_id
    INNER JOIN Network_Logs n
    ON s.session_id = n.session_id
    WHERE l.city = @City;
END;



-- 4
CREATE PROCEDURE sp_GetErrorsByType
    @ErrorType NVARCHAR(50)
AS
BEGIN
    SELECT
        e.error_id,
        e.error_type,
        e.error_time,
        s.session_id,
        u.user_id,
        u.subscription_type
    FROM Errors e
    INNER JOIN Sessions s
    ON e.session_id = s.session_id
    INNER JOIN Users u
    ON s.user_id = u.user_id
    WHERE e.error_type = @ErrorType;
END;

-- 5
CREATE PROCEDURE sp_GetLowPerformanceSessions
AS
BEGIN
    SELECT
        s.session_id,
        u.user_id,
        u.subscription_type,
        n.timestamp,
        n.download_speed,
        n.upload_speed,
        n.latency,
        n.signal_strength
    FROM Sessions s
    INNER JOIN Users u
    ON s.user_id = u.user_id
    INNER JOIN Network_Logs n
    ON s.session_id = n.session_id
    WHERE n.download_speed < 30
    OR n.latency > 70;
END;
