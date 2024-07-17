# Banking Application

Welcome to the Banking Application repository! This Java web application provides a comprehensive banking system with functionalities for both administrators and customers. Built using JSP, servlets, and MySQL, the application ensures secure and seamless banking operations.

## Key Features

### Admin Dashboard
- **Secure Login:** Authentication with username and password.
- **Customer Management:** Register, view, modify (excluding sensitive details), and delete customers.
- **Account Management:** Create accounts with generated numbers and temporary passwords.

### Customer Portal
- **Account Setup:** Initial password setup upon registration.
- **Password Management:** Change password functionality.
- **Account Operations:** View account details, transaction history (last 10 transactions), deposit, and withdrawal.
- **Self-Service:** Account closure after withdrawing all funds.

### Additional Features
- **PDF Generation:** Customers can download PDFs of their last 10 transactions.
- **Responsive Design:** Functional UI prioritizing usability.

## Technology Stack

- **Backend:** Java, Servlets, JSP
- **Database:** MySQL
- **Tools:** Eclipse IDE, Tomcat 9 Server, MySQL Server, MySQL Workbench


## Usage

- **Admin Login:** Use provided credentials to access admin functionalities.
- **Customer Registration:** Admin registers customers and provides initial login details.
- **Customer Operations:** Customers manage accounts, perform transactions, and download transaction PDFs.

## Notes

- This application focuses on functionality over UI design.
- Ensure proper authentication and session management for secure user interactions.
