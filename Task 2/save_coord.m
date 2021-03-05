 T_aut = table2array(readtable('SURF_Correspondences.xlsx'));
 
 xL_eig = T_aut(2:3,:);
 xR_eig = T_aut(4:5,:);
 
 xL_SURF = T_aut(8:9,:);
 xR_SURF = T_aut(10:11,:);
 
 xL_FAST = T_aut(14:15,:);
 xR_FAST = T_aut(16:17,:);
 
 save('Autom.mat', 'xL_eig', 'xR_eig', 'xL_SURF', 'xR_SURF', 'xL_FAST', 'xR_FAST');
 