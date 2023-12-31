# Databases and SQL

## Objectives

- Relational databases
- SQL

## Main Content

### Training: SQL

- [What is Database & SQL?](https://www.youtube.com/watch?v=FR4QIeZaPeM) - 6:19
- [Relational Database Concepts](https://www.youtube.com/watch?v=NvrpuBAMddw) - 5:24
- [MySQL Tutorial 2 - How Data is Organized and Normalization](https://www.youtube.com/watch?v=IIdfqFxercg) - 6:31
- (Optional) - [MySQL Tutorial (Banas)](https://www.youtube.com/watch?v=yPu6qV5byu4) - 41:09 
- reading: http://en.tekstenuitleg.net/articles/software/database-design-tutorial/intro.html
  

Discuss the above topics!

### Exercise: SQL BOLT

- Complete all challenges here: http://sqlbolt.com/

- optional practice: 
  - https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/courseware/ch-sql/seq-exercise-sql_movie_query_core/
  - https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/courseware/ch-sql/seq-exercise-sql_movie_query_extra/
  - https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/courseware/ch-sql/seq-exercise-sql_social_query_core/
  - https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/courseware/ch-sql/seq-exercise-sql_social_query_extra/
  - https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/courseware/ch-sql/seq-exercise-sql_movie_mod/
  - https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/courseware/ch-sql/seq-exercise-sql_social_mod/


1_____________________________________________________________________2

### Preparation: Setup MySQL-Server via Docker

Since the classic way of setting up a mysql-server can become quite frustraing/long/tedious, we will use a new amazing technology called Docker.

#### About Docker

​	Docker is a platform for developers and sysadmins to **build, run, and share** applications with containers. The use of containers to deploy applications is called *containerization*. Containers are not new, but their use for easily deploying applications is.

Containerization is increasingly popular because containers are:

- **Flexible**: Even the most complex applications can be containerized.
- **Lightweight**: Containers leverage and share the host kernel, making them much more efficient in terms of system resources than virtual machines.
- **Portable**: You can build locally, deploy to the cloud, and run anywhere.
- **Loosely coupled**: Containers are highly self sufficient and encapsulated, allowing you to replace or upgrade one without disrupting others.
- **Scalable**: You can increase and automatically distribute container replicas across a datacenter.
- **Secure**: Containers apply aggressive constraints and isolations to processes without any configuration required on the part of the user.

#### Images and containers

Fundamentally, a container is nothing but a running process, with some added encapsulation features applied to it in order to keep it isolated from the host and from other containers. One of the most important aspects of container isolation is that each container interacts with its own private filesystem; this filesystem is provided by a Docker **image**. An image includes everything needed to run an application - the code or binary, runtimes, dependencies, and any other filesystem objects required.

### Install docker

Windows:
 - Install these updates: https://aka.ms/wsl2kernel (1.-5. points)
 - Then install docker: https://docs.docker.com/docker-for-windows/install/
 - Then: https://docs.docker.com/docker-for-windows/wsl/ (3. point) -> (https://docs.docker.com/desktop/windows/images/wsl2-enable.png)


 
 
 
Linux: 
   - https://docs.docker.com/engine/install/ubuntu/

MAC OS: 
   - https://docs.docker.com/desktop/mac/apple-silicon/


### Workshop: Talk about docker basics, and create your own container

Few docker commands:

**docker ps**  
    List containers

**docker ps -a**  
    List containers ( all, including stopped )

**docker stop <image-name>/<image-hash>**  
    stop container

**docker start**  
    start container

**docker volume create**  
    create volume

**docker run -d --name mysql-server -e MYSQL_ROOT_PASSWORD=test1234 -p 3306:3306 -v mysqldata:/var/lib/mysql mysql:8.0**  
  
    create and run a Mysql-Server image  
    -d : run in background  
    --name : specify container name  
    -e environment variables, we use this to specify our root password  
    -v attach volume to container, this is needed, in order-to keep our database data  
    mysql:8.0 use given image to start container <image-name:tag-name>  
   
 **docker run -d --name mariadb-server2 -e MYSQL_ROOT_PASSWORD=test1234 -p 3306:3306 -v mariadb mariadb:latest**
 
   MySQL doesnt exist in Apple, but there is MariaDB, which is quite the same(some syntax might differ)

**docker exec -t -i <image-name> /bin/bash**  
    Access the shell-terminal of a given image

**docker exec -t -i  /bin/bash -c “mysql -u root -p”**  
    One-liner to access mysql prompt

### Workshop: Running queries from the command line

- play with it in command line client (run it from start menu)
  
```
   CREATE DATABASE mydatabase CHARACTER SET utf8mb4;
   USE mydatabase; 
   CREATE TABLE ...
   INSERT INTO ...
   SELECT * FROM ...
   UPDATE ....
   DELETE FROM ...
   DROP TABLE ...;
   DROP DATABASE mydatabase;   
```

- connect from CLI (command line):
```
    mysql -h localhost -P 3306 -u root -p
```

### Workshop: Connect to MySQL from Intellij IDEA

 - Database Tool Button
 - Create DB connection from IDEA (download driver)

### Tranining: ERD - Entity-Relation Diagram

Simple design methodology: Look for the nouns, those will be the tables and columns. Think them as Excel sheets and use your common sense to draw ERD. 

- Read and solve the exercises: the following: https://opentextbc.ca/dbdesign01/back-matter/appendix-b-erd-exercises/

### Workshop: Database Design - Hospital 

Read the following description:
A hospital consists of many departments, each has a head physician and some senior physicians. 
If there's no head physician, then there is a deputy head physician.  They are the employees of the hospital 
(and not employed in other hospitals) and they all have medical diploma. A hospital has many other employees: 
physicians, nurses, cleaners, helper staff. Physicians and nurses are always working in a department, 
while helper staff can belong directly to the hospital. Every employee has a code, 
but for physicians a registration id is recorded as well. The leader of the hospital (dean) is a physician, 
who has a degree in economics and not employed by any other hospital. 
A patient - if gets to a hospital - may pass through multiple departments and until completely healed might be treated with different problems.

Create an E-R diagram based on this description! Display the functionality of the relationships as well.
Underline the keys!!


## Material Review

- data
- database, relational database, RDBMS
  - MySQL, Oracle, MSSQL, IBM DB2, PostgreSQL
- SQL language
  - primary key (simple and complex)
  - foreign key
  - create, drop database
  - use database
  - create, drop table
  - data types:
     - varchar, int, datetime
- describe
- insert into, update, delete ...
- select
  - where
  - operators (=, -, >, <, <>, IN ...)
  - group by, having
  - SQL functions: sum, max, min ...
- join
  - inner
  - outer
- DML vs DDL commands
  - SQL
    - VIEW
    - SELECT ... FROM (SELECT)
    - SELECT ... WHERE ... IN (SELECT)
    - INSERT INTO ... ON DUPLICATE KEY UPDATE

## See also

- More on Docker:  https://docs.docker.com/get-started/overview/ 

- How to make SQL editor inspect syntax in Intellij IDEA?
http://stackoverflow.com/questions/20865368/how-to-make-sql-editor-inspect-snytax-in-intellij-idea-13 
- Inner joins: http://stackoverflow.com/questions/10195451/sql-inner-join-with-3-tables
- Insert or update (INSERT ... ON DUPLICATE KEY ID): https://mariadb.com/kb/en/mariadb/insert-on-duplicate-key-update/


## Homework

- read or watch: Sequel SQL - JOIN vs Sub-select, aliases, (from 84. slide) https://my.pcloud.com/publink/show?code=XZXChCZIpW8vonTS8Qcm8zHstLXLLJop12y


## License 

Copyright © Progmasters (QTC Kft.), 2016-2019.
All rights reserved. No part or the whole of this Teaching Material (TM) may be reproduced, copied, distributed, publicly performed, disseminated to the public, adapted or transmitted in any form or by any means, including photocopying, recording, or other electronic or mechanical methods, without the prior written permission of QTC Kft. This TM may only be used for the purposes of teaching exclusively by QTC Kft. and studying exclusively by QTC Kft.’s students and for no other purposes by any parties other than QTC Kft.
This TM shall be kept confidential and shall not be made public or made available or disclosed to any unauthorized person.
Any dispute or claim arising out of the breach of these provisions shall be governed by and construed in accordance with the laws of Hungary. 
#   S Q L _ w e e k  
 