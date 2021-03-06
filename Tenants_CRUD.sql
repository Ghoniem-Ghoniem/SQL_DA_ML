
create procedure GenerateSkill(@EmpID int ,@Skill varchar(20),@SkillName varchar(20),@TenantID varchar(20))
as
begin
insert into empskills      (EmpID,Skill,SkillName,TenantID)
values (@EmpID,@Skill,@SkillName,SUSER_SNAME())
end




exec GenerateSkill 120,'ELEARN','LMS','BB'

CREATE LOGIN BlackBoard WITH PASSWORD = 'abcd_28052';
ALTER LOGIN [BlackBoard] WITH DEFAULT_DATABASE=[DWHDB]
CREATE USER [BlackBoard] FOR LOGIN [BlackBoard]
--drop user [BlackBoard] 
GRANT EXECUTE TO BlackBoard;
GRANT select TO BlackBoard;
revoke select TO BlackBoard;

---the following statements to be used from BlackBoard user
exec GenerateSkill 210,'ELEARN','LMS','BB'
select * from EmpSkills where TenantID =SUSER_SNAME()

exec GenerateSkill 220,'ELEARN','LMS','BB'

--will retrieve BlackBoard data only
GetAllSkill

