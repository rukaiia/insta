
insert into ROLES(ROLE)
values ( 'USER' );

insert into USERS(email, password, enabled, role_id)
values ('Raimberdieva@gmail.com', '$2a$12$gP0Or6r9vCkQA0SSyNEBquWu2PezHHb2xmXP5CvaUc0NXS5yL0fGu', true,
        (select id from ROLES where ROLES.ROLE = 'USER' limit 1)),
       ('Rayana@gmail.com', '$2a$12$gP0Or6r9vCkQA0SSyNEBquWu2PezHHb2xmXP5CvaUc0NXS5yL0fGu', true,
        (select id from ROLES where ROLES.ROLE = 'USER' limit 1));
