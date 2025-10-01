-- Database: db_wifi_pineapple

CREATE DATABASE IF NOT EXISTS db_wifi_pineapple;
USE db_wifi_pineapple;

-- Table: networks
DROP TABLE IF EXISTS networks;
CREATE TABLE networks (
    ssid VARCHAR(255) PRIMARY KEY,
    bssid VARCHAR(17) UNIQUE,
    channel INT,
    `signal` INT,
    encryption VARCHAR(50),
    client_count INT
) ENGINE=InnoDB;

-- Table: clients
DROP TABLE IF EXISTS clients;
CREATE TABLE clients (
    mac VARCHAR(17) PRIMARY KEY,
    vendor VARCHAR(255),
    packets INT,
    `signal` INT,
    connected_ssid VARCHAR(255),
    CONSTRAINT fk_clients_networks FOREIGN KEY (connected_ssid) REFERENCES networks(ssid)
) ENGINE=InnoDB;

-- Table: interfaces
DROP TABLE IF EXISTS interfaces;
CREATE TABLE interfaces (
    name VARCHAR(50) PRIMARY KEY,
    status VARCHAR(10),
    ip VARCHAR(15),
    mac VARCHAR(17),
    mode VARCHAR(20)
) ENGINE=InnoDB;

-- Table: dhcp_leases
DROP TABLE IF EXISTS dhcp_leases;
CREATE TABLE dhcp_leases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ip VARCHAR(15),
    mac VARCHAR(17),
    lease_start DATETIME,
    lease_end DATETIME
) ENGINE=InnoDB;

-- Table: routing
DROP TABLE IF EXISTS routing;
CREATE TABLE routing (
    id INT AUTO_INCREMENT PRIMARY KEY,
    destination VARCHAR(50),
    gateway VARCHAR(15),
    interface_name VARCHAR(50),
    metric INT,
    CONSTRAINT fk_routing_interfaces FOREIGN KEY (interface_name) REFERENCES interfaces(name)
) ENGINE=InnoDB;

-- Table: ssid_pool
DROP TABLE IF EXISTS ssid_pool;
CREATE TABLE ssid_pool (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    count INT,
    added DATETIME
) ENGINE=InnoDB;

-- Table: pineapple_settings
DROP TABLE IF EXISTS pineapple_settings;
CREATE TABLE pineapple_settings (
    id INT PRIMARY KEY DEFAULT 1,
    enabled TINYINT(1),
    pool_size INT,
    beacon_interval INT,
    response_interval INT,
    broadcast_ssid TINYINT(1),
    log_associations TINYINT(1),
    karma_mode VARCHAR(50)
) ENGINE=InnoDB;

-- Table: modules
DROP TABLE IF EXISTS modules;
CREATE TABLE modules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    version VARCHAR(20),
    description TEXT,
    enabled TINYINT(1),
    author VARCHAR(255),
    size INT,
    type ENUM('installed', 'available')
) ENGINE=InnoDB;

-- Table: campaign_modes
DROP TABLE IF EXISTS campaign_modes;
CREATE TABLE campaign_modes (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255),
    description TEXT
) ENGINE=InnoDB;

-- Table: campaigns
DROP TABLE IF EXISTS campaigns;
CREATE TABLE campaigns (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    status VARCHAR(50),
    mode VARCHAR(50),
    results INT,
    description TEXT,
    created DATETIME,
    last_run DATETIME
) ENGINE=InnoDB;

-- Table: reports
DROP TABLE IF EXISTS reports;
CREATE TABLE reports (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(50),
    generated DATETIME,
    size VARCHAR(20)
) ENGINE=InnoDB;

-- Table: activity_logs
DROP TABLE IF EXISTS activity_logs;
CREATE TABLE activity_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50),
    message TEXT,
    timestamp DATETIME,
    client_mac VARCHAR(17),
    CONSTRAINT fk_activitylogs_clients FOREIGN KEY (client_mac) REFERENCES clients(mac)
) ENGINE=InnoDB;
