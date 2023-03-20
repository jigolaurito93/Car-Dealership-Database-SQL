# Car-Dealership-Database-SQL
kekembas-111_Week5_Day5 

You have been hired by a local car dealership to design and implement the database system for their company. They have sent the attached business rules abour their dealership. Using those business rules, you are asked to complete the following:

- Create an Entity Relationship Diagram (ERD) using lucidchart.com that has all of the entities and relationships (cardinal and ordinal) mentioned in the business rules. Feel free to add to it how you see fit (no removing anything though). Once finalized, save the ERD as a PDF (File->Export->PDF) and save to a project folder.

- Using dBeaver and your ERD, create the tables in a database. The client will be unable to see your database so you will need to save your DDL statements in a .sql file. (Set up the file where if the client ran every statement from top to bottom in their database it would create the necessary tables with the correct keys, constraints, etc.)

- Once all of the tables are created, each table should have at least 2 rows of data. At least 2 of the inserts should come from a stored procedure (you can always add more if you want). Similar to the DDL statements, you will also need to save your DML statemets in a .sql file. You may keep this in the same file as the DDL statements or create a new .sql file.
Your Final Repository should include the following:
- 1 Entity Relationship Diagram PDF
- 1-2 .sql file(s) containing the DDL & DML statements

The project will not be considered turned in until you push to GitHub and share the link to the repository here.

==============================================================================================================================================================

Car Dealership
Create an ERD for a car dealership. The dealership sells both new and used cars, and it operates a service facility. Base your design on the following business rules:

A salesperson may sell many cars, but each car is sold by only one salesperson.
A customer may buy many cars, but each car is purchased by only one customer.
A salesperson writes a single invoice for each car he or she sells.
A customer gets an invoice for each car he or she buys.
A customer may come in just to have his or her car serviced; that is, a customer need not buy a car to be classified as a customer.
When a customer takes one or more cars in for repair or service, one service ticket is written for each car.
The car dealership maintains a service history for each of the cars serviced. The service  records are referenced by the car’s serial number.
A car brought in for service can be worked on by many mechanics, and each mechanic may work on many cars.

After the tables have been created, use SQL to add data to the database

Each person will need to create their own SQL database.
