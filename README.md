---

# 🚗 Cars App 🚗

Application for managing vehicles and customers. This project has been developed using Java and Maven, with deployment on an Apache Tomcat server. The database is managed with MariaDB and visually administered via DBeaver.

---

## Technologies Used

**Java** (recommended version: 17 or higher)
**Apache Tomcat** v11.0.4
**Maven** as the dependency manager and packaging tool
**MariaDB** as the database management system
**DBeaver** for visual database administration
**Lombok** for automatic code generation (requires plugin in the IDE)
**IntelliJ IDEA** as the main development environment

---

## Database Structure

The database contains the `car` schema with two main tables:

* **cars**: vehicle information
* **users**: customer or registered user information

---

## Getting Started with the Project

### 1. Prerequisites

* Java JDK 17+
* Apache Tomcat 11.0.4
* Maven installed (`mvn -v`)
* MariaDB (running)
* DBeaver (optional, for database management)

---

### 2. Database Configuration

1. Create the database and tables (cars, users) in MariaDB.
2. Adjust the credentials in the `application.properties` file or the corresponding file for your setup (depending on how your project is structured).

---

### 3. Building and Deploying the Project

* `mvn tomcat7:deploy` → to deploy
* `mvn tomcat7:undeploy` → to undeploy
* `mvn tomcat7:redeploy` → to redeploy
* `mvn clean tomcat7:redeploy`

---
