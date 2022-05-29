EXEC sys.sp_execute_external_script   
@language =N'python',  
@script=N'import statistics as st
listformean = [1,1,2,3,4,5,6,7,8,9,10,11,100]
print(st.mean(listformean))
print(st.median(listformean))
print(st.median_high(listformean))
print(st.median_low(listformean))
#print(st.harmonic_mean(listformean))
print(st.mode(listformean))
print(st.stdev(listformean))
print(st.variance(listformean))'  
