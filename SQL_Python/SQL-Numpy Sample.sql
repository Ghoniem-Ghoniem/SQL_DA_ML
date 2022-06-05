
EXEC sys.sp_execute_external_script   
@language =N'python',  
@script=N'import numpy as np
a = np.random.randint(5,20,size=9);
b = np.mean(a)
c = np.median(a);
d = np.var(a)
e = np.corrcoef(a)
print(a)
print(b)
print(c)
print(d)
print(e)'
