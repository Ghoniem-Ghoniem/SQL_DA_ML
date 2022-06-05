--Adding session variables to database
--that will help you for the reducing send values over the network
EXEC sp_set_session_context'user_code', 10;
SELECT SESSION_CONTEXT(N'user_code');

EXEC sp_set_session_context'user_name','Salah Ghoniem';
SELECT SESSION_CONTEXT(N'user_name');


