Create database db_TestCurd
use db_TestCurd

create table tblemployee
(
eid int primary key identity,
firstname varchar(50),
lastname varchar(50),
gender int,
contactno bigint,
Email varchar(100),
Country varchar(50),
state int,
TandC bit
)

--drop column status from  tblemployee 
alter table tblemployee drop column status

create table tblCountry
( cid int primary key identity,
  cname varchar(50)
)

create table tblstate
(
sid int primary key identity,
cid int,
sname varchar(50)
)

insert into tblCountry(cname)values('INDIA')
insert into tblCountry(cname)values('PAKISTAN')
insert into tblCountry(cname)values('CHINA')
insert into tblCountry(cname)values('NEPAL')

insert into tblstate(cid,sname)values(1,'UP')
insert into tblstate(cid,sname)values(1,'M.P')
insert into tblstate(cid,sname)values(1,'BIHAR')

insert into tblstate(cid,sname)values(2,'LAHORE')
insert into tblstate(cid,sname)values(2,'KARACHI')
insert into tblstate(cid,sname)values(2,'PUNJAB')

insert into tblstate(cid,sname)values(3,'BIJING')
insert into tblstate(cid,sname)values(3,'HUAN')
insert into tblstate(cid,sname)values(3,'BUHAN')

insert into tblstate(cid,sname)values(4,'KATHMANDU')
insert into tblstate(cid,sname)values(4,'LUMBANI')
insert into tblstate(cid,sname)values(4,'Pokhra')

create table tblgender
(
gid int primary key identity,
gname varchar(50)
)
insert into tblgender(gname)values('Male')
insert into tblgender(gname)values('Female')
insert into tblgender(gname)values('Others')
-----------------Display Country---------------------
create proc sp_countrydata
as
begin
select * from tblcountry
end
-----------------Display State---------------------
create proc sp_statedata
as
begin
select * from tblstate
end

     --after then
alter proc sp_statedata
@cid int
as
begin
select * from tblstate where cid=@cid
end

-----------------Display Gender---------------------
create proc sp_genderdata
as
begin
select * from tblgender
end

--===========Operation for curd===========--
alter proc sp_InsertUpdate
@eid int=null,
@firstname varchar(50)=null,
@lastname varchar(50)=null,
@gender int, --1-Male,2-Female
@contactno bigint,
@Email varchar(100)=null,
@Country varchar(50)=null,
@state int=null,
--@Status bit,--0 InActive,1Active,
@TandC bit=0 --1 Agree,0-Disagree
as
begin
if @eid is null or @eid<0
begin
insert into tblemployee(firstname,lastname,gender,contactno,email,country,state,TandC) values(@firstname,@lastname,@gender,@contactno,@email,@country,@state,@TandC)
end

else 
begin
update tblemployee set firstname=@firstname,lastname=@lastname,gender=@gender,contactno=@contactno,email=@email,country=@country,state=@state,TandC=@TandC where eid=@eid
end
end

create proc sp_Displaydata
as
begin
select * from tblemployee
end

create procedure sp_DeleteRecord
@eid int
as
begin
delete from tblemployee where eid =@eid 
end

create proc sp_Editrecord
@eid int
as
begin
select * from tblemployee where eid=@eid
end
--------------------------------------
--truncate table tblemployee
alter proc sp_showAlldata
as
begin
--select * from tblemployee
select * from tblemployee
join tblcountry on tblemployee.country=tblcountry.cid
join tblstate on tblemployee.state=tblstate.sid
join tblgender on tblemployee.gender=tblgender.gid
end

select * from tblemployee
select * from tblstate
select * from tblcountry

select * from tblemployee
join tblcountry on tblemployee.country=tblcountry.cid
join tblstate on tblemployee.state=tblstate.sid
join tblgender on tblemployee.gender=tblgender.gid