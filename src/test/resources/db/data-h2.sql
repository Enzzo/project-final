-- Вставка данных в таблицу PROJECT
insert into PROJECT (CODE, TITLE, DESCRIPTION, TYPE_CODE, STARTPOINT, ENDPOINT, PARENT_ID)
values
    ('PROJ001', 'Project 1', 'Description of Project 1', 'Software', '2024-01-01', '2024-12-31', null),
    ('PROJ002', 'Project 2', 'Description of Project 2', 'Hardware', '2024-03-01', '2024-11-30', 1);

-- Вставка данных в таблицу MAIL_CASE
insert into MAIL_CASE (EMAIL, NAME, DATE_TIME, RESULT, TEMPLATE)
values
    ('test1@mail.com', 'Test Email 1', '2024-11-12 10:00:00', 'Success', 'template1'),
    ('test2@mail.com', 'Test Email 2', '2024-11-12 11:00:00', 'Failure', 'template2');

-- Вставка данных в таблицу SPRINT
insert into SPRINT (STATUS_CODE, STARTPOINT, ENDPOINT, TITLE, PROJECT_ID)
values
    ('Active', '2024-01-01', '2024-03-01', 'Sprint 1', 1),
    ('Completed', '2024-04-01', '2024-06-01', 'Sprint 2', 2);

-- Вставка данных в таблицу REFERENCE
insert into REFERENCE (CODE, REF_TYPE, ENDPOINT, STARTPOINT, TITLE, AUX)
values
    ('REF001', 1, '2024-12-31', '2024-01-01', 'Reference 1', 'Auxiliary data'),
    ('REF002', 2, '2024-06-30', '2024-02-01', 'Reference 2', 'More auxiliary data');

-- Вставка данных в таблицу USERS
insert into USERS (DISPLAY_NAME, EMAIL, FIRST_NAME, LAST_NAME, PASSWORD, ENDPOINT, STARTPOINT)
values
    ('User 1', 'user1@mail.com', 'John', 'Doe', 'password123', '2024-12-31', '2024-01-01'),
    ('User 2', 'user2@mail.com', 'Jane', 'Doe', 'password456', '2024-12-31', '2024-01-01');

-- Вставка данных в таблицу PROFILE
insert into PROFILE (ID, LAST_LOGIN, LAST_FAILED_LOGIN, MAIL_NOTIFICATIONS)
values
    (1, '2024-11-11', '2024-11-10', 1),
    (2, '2024-11-12', '2024-11-09', 0);

-- Вставка данных в таблицу CONTACT
insert into CONTACT (ID, CODE, VALUE)
values
    (1, 'phone', '123-456-7890'),
    (2, 'address', '123 Main St');

-- Вставка данных в таблицу TASK
insert into TASK (TITLE, DESCRIPTION, TYPE_CODE, STATUS_CODE, PRIORITY_CODE, ESTIMATE, UPDATED, PROJECT_ID, SPRINT_ID, PARENT_ID, STARTPOINT, ENDPOINT)
values
    ('Task 1', 'Task Description 1', 'Development', 'In Progress', 'High', 5, '2024-11-12', 1, 1, null, '2024-01-01', '2024-02-01'),
    ('Task 2', 'Task Description 2', 'Testing', 'Completed', 'Medium', 3, '2024-11-10', 2, 2, 1, '2024-03-01', '2024-04-01');

-- Вставка данных в таблицу ACTIVITY
insert into ACTIVITY (AUTHOR_ID, TASK_ID, UPDATED, COMMENT, TITLE, DESCRIPTION, ESTIMATE, TYPE_CODE, STATUS_CODE, PRIORITY_CODE)
values
    (1, 1, '2024-11-12', 'Started work on task 1', 'Activity 1', 'Working on Task 1', 2, 'Development', 'In Progress', 'High'),
    (2, 2, '2024-11-10', 'Completed task 2', 'Activity 2', 'Test completed on Task 2', 3, 'Testing', 'Completed', 'Medium');

-- Вставка данных в таблицу TASK_TAG
insert into TASK_TAG (TASK_ID, TAG)
values
    (1, 'Urgent'),
    (2, 'BugFix');

-- Вставка данных в таблицу USER_BELONG
insert into USER_BELONG (OBJECT_ID, OBJECT_TYPE, USER_ID, USER_TYPE_CODE, STARTPOINT, ENDPOINT)
values
    (1, 1, 1, 'Developer', '2024-01-01', '2024-12-31'),
    (2, 2, 2, 'Tester', '2024-03-01', '2024-06-30');

-- Вставка данных в таблицу ATTACHMENT
insert into ATTACHMENT (NAME, FILE_LINK, OBJECT_ID, OBJECT_TYPE, USER_ID, DATE_TIME)
values
    ('Attachment 1', '/files/attachment1.txt', 1, 1, 1, '2024-11-12'),
    ('Attachment 2', '/files/attachment2.jpg', 2, 2, 2, '2024-11-12');

-- Вставка данных в таблицу USER_ROLE
insert into USER_ROLE (USER_ID, ROLE)
values
    (1, 1), -- Admin
    (2, 2); -- User
