SELECT * FROM test.user_info;

SELECT * FROM test.user_info WHERE gender = "Female";

SELECT * FROM test.user_info WHERE age >= 20 AND age <= 26 AND gender = "Male";

SELECT * FROM test.user_info WHERE email LIKE '%.com' order by name DESC;

SELECT * FROM test.user_info WHERE id >= 100 and name LIKE '%e%' and age >= 40;

INSERT INTO test.user_info (name, email, gender) values ('Davin Kim' 'davin0706@gmail.com', "Female");

UPDATE test.user_info SET age = 20 WHERE id = 2;

DELETE FROM test.user_info WHERE gender != "Female" and gender != "Male";