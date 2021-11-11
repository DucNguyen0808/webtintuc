use demoseverletdatabase;
Create table role(
  id bigint not null primary key auto_increment,
  name varchar(255) not null,
  code varchar(255) not null,
  createddate timestamp  null,
  modifieddate timestamp null,
  createdby varchar(255)  null,
  mofdifiedby varchar(255)  null
);
Create table user(
id bigint not null primary key auto_increment ,
name varchar(255) not null,
password varchar(255) not null,
fullname varchar(255) not null,
roleid bigint not null,
status int not null,
  createddate timestamp  null,
  modifieddate timestamp null,
  createdby varchar(255)  null,
  mofdifiedby varchar(255)  null
);
alter table user ADD Constraint fk_userrole Foreign key (roleid ) references role(id);
Create table news(
id bigint not null primary key auto_increment,
title varchar(255)  null,
thumbnail varchar(255) null,
shortdescription text  null,
content text  null,
categoryid bigint not null,
  createddate timestamp  null,
  modifieddate timestamp null,
  createdby varchar(255)  null,
  mofdifiedby varchar(255)  null
);
Create table category(
id bigint not null primary key auto_increment,
name varchar(255) not  null,
code varchar(255)  not null,
  createddate timestamp  null,
  modifieddate timestamp null,
  createdby varchar(255)  null,
  mofdifiedby varchar(255)  null
);
alter table news ADD Constraint fk_catery Foreign key (categoryid ) references category(id);
Create table comment(
id bigint not null primary key auto_increment,
content text not  null,
user_id bigint not null,
news_id bigint not null,
  createddate timestamp  null,
  modifieddate timestamp null,
 createdby varchar(255)  null,
  mofdifiedby varchar(255)  null
);
alter table comment ADD Constraint fk_user_comment Foreign key (user_id ) references user(id);
alter table comment ADD Constraint fk_news_commen Foreign key (news_id ) references news(id);