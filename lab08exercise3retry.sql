-- Drop and recreate the pond database
DROP DATABASE IF EXISTS pond;
CREATE DATABASE pond;
USE pond;

-- SensorType: High-level topic (e.g., Water Temperature)
CREATE TABLE SensorType (
    sensor_type_id INT PRIMARY KEY AUTO_INCREMENT,
    topic VARCHAR(255) NOT NULL
);

-- Device: Physical sensor devices like TEMPW, NO2, etc.
CREATE TABLE Device (
    device_id VARCHAR(10) PRIMARY KEY,
    device_name VARCHAR(255) NOT NULL,
    sensor_type_id INT,
    FOREIGN KEY (sensor_type_id) REFERENCES SensorType(sensor_type_id)
);

-- Measurement: Readings collected from sensors
CREATE TABLE Measurement (
    measurement_id INT PRIMARY KEY AUTO_INCREMENT,
    device_id VARCHAR(10),
    measured_value DECIMAL(10,2),
    measurement_unit VARCHAR(20),
    measurement_date DATETIME,
    description TEXT,
    FOREIGN KEY (device_id) REFERENCES Device(device_id)
);

-- Action: Actions triggered by sensor values (e.g., Add Additives)
CREATE TABLE Action (
    action_id INT PRIMARY KEY AUTO_INCREMENT,
    action_type VARCHAR(255) NOT NULL,
    action_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Measurement_Action: Junction table linking sensor measurements to actions taken
CREATE TABLE Measurement_Action (
    measurement_id INT,
    action_id INT,
    PRIMARY KEY (measurement_id, action_id),
    FOREIGN KEY (measurement_id) REFERENCES Measurement(measurement_id),
    FOREIGN KEY (action_id) REFERENCES Action(action_id)
);

-- Optional: Pond (if multiple ponds are managed)
CREATE TABLE Pond (
    pond_id INT PRIMARY KEY AUTO_INCREMENT,
    pond_name VARCHAR(100)
);

-- Optional: Pond_Action — links actions to specific ponds
CREATE TABLE Pond_Action (
    pond_id INT,
    action_id INT,
    PRIMARY KEY (pond_id, action_id),
    FOREIGN KEY (pond_id) REFERENCES Pond(pond_id),
    FOREIGN KEY (action_id) REFERENCES Action(action_id)
);
