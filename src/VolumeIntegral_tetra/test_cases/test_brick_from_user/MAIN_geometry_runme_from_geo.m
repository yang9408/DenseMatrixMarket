%%
clear 
close all
clc
%%
nx=80; lx=10;
ny=8; ly=1;
nz=2; lz=0.1;
%%
[VP,Matrix_P0] = regular_tetrahedral_mesh(nx,ny,nz); VP=VP.';
Matrix_P0=[Matrix_P0(:,1)*lx,Matrix_P0(:,2)*ly,Matrix_P0(:,3)*lz];
%% reordering
if 1
a = zeros(size(VP,2),1);
for ii = 1:size(VP,2)
    e12 = Matrix_P0(VP(2,ii),:)-Matrix_P0(VP(1,ii),:);
    e13 = Matrix_P0(VP(3,ii),:)-Matrix_P0(VP(1,ii),:);
    e14 = Matrix_P0(VP(4,ii),:)-Matrix_P0(VP(1,ii),:);
    vec1=cross(e12,e13);
    a(ii,1) = dot(vec1,e14);
    if a(ii,1) < 0
        VP(:,ii) = VP([1,2,4,3],ii);
    end
end
end
%%
dad=pwd;
cd ..
[G1,C1,D1,F1,Matrix_C,Matrix_G,Matrix_D] = fun_create_data(VP);
cd(dad);
%%
ind_face_free=find(F1(5,:)==0);
figure
patch('Faces',F1(1:3,ind_face_free).','Vertices',Matrix_P0,'Facecolor','b','FaceAlpha',0.2)
axis equal
view(3)
title('tetrahedra')
figure
patch('Faces',F1(1:3,ind_face_free).','Vertices',Matrix_P0,'Facecolor',[0.7,0.7,0.7],'FaceAlpha',1)
axis equal
view(3)
title('tetrahedra')

%%
save data.mat Matrix_G  C1 D1 F1 G1 Matrix_C Matrix_D Matrix_P0 VP 