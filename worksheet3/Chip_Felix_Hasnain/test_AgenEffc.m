startVal = 3;
endVal = 70;

Time_Agen1 = zeros(1,endVal-startVal+1);
Time_Agen2 = zeros(1,endVal-startVal+1);
Time_Agen3 = zeros(1,endVal-startVal+1);

for i = startVal:endVal
	tic;
	Agen(i,i);
	Time_Agen1(i-startVal+1) = toc;
	
	tic;
	AgenNew(i,i);
	Time_Agen2(i-startVal+1) = toc;
	
	tic;
	Agen3(i,i);
	Time_Agen3(i-startVal+1) = toc;
	
end

x = startVal:endVal;
plot(x,Time_Agen1, 'b',x,Time_Agen2, 'r',x,Time_Agen3, 'g');

