function CS5320_runTest()
% CS5320_runTest - finds mean error in depth, rho and normal 
% with the change in number of sources. The number of sources 
% are varied from MinNumOfSources to MaxNumOfSources.
% Do not decrease MinNumOfSources to a value below 3
% else it will throw an error. The plot functions below could be uncommented
% to see the plots
% Call:
% CS5320_runTest();

Q = CS5320_ps_sphere(60);
MinNumOfSources = 3;
MaxNumOfSources = 20;

for NumOfSources = MinNumOfSources:MaxNumOfSources
    S = [];
    for i = 1:NumOfSources
        Stemp = [randn,randn,randn];
        Stemp = Stemp/norm(Stemp);
        Itemp = CS5320_ps_render(Q,Stemp);
        S = [S;Stemp];
        I(:,:,i) = Itemp;
    end
    [rho,N,G,f] = CS5320_pms(I,S);
    [meanError_depth(NumOfSources-2), meanError_rho(NumOfSources-2),meanError_N(NumOfSources-2)] =  CS5320_ps_error(Q,rho,N,G,f);
end
%plotSphere();
% figure;
% plot(3:1:20,meanError_rho);
% xlabel('Number of sources');
% ylabel('Mean error in estimated rho');
% title('This plot shows how the mean error in rho is dependent on the Number of Sources ')
% 
% figure;
% plot(3:1:20,meanError_depth);
% xlabel('Number of sources');
% ylabel('Mean error in estimated depth');
% title('This plot shows how the mean error in depth is dependent on the Number of Sources ')
% 
% figure;
% plot(3:1:20,meanError_N);
% xlabel('Number of sources');
% ylabel('Mean error in estimated N');
% title('This plot shows how the mean error in N is dependent on the Number of Sources ')
