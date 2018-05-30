s1 = serial('COM7')

fopen(s1)

fprintf(s1,'%s','$Debug')
fprintf(s1,'%s','$Help')
fprintf(s1,'%s','$StartTrack=[499]')


s1
% idn = fscanf(s1);

s1.BytesAvailable


fclose(s1)