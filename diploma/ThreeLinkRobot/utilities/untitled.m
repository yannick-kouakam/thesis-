fig=gcf;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Define Base	
angle=225:15:315;		% get rit of where links overlap
xa=1.125*cos(angle*pi/180);
ya=1.125*sin(angle*pi/180);
xb=[xa .875 .875 2.5  2.5 -2.5 -2.5 -.875 -.875];
yb=[ya -.707107 -1.25 -1.25 -2.875 -2.875 -1.25 -1.25 -.707107];
B=[xb' yb' zeros(size(xb))' ones(size(xb))']';  % Link3 matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Link1 and Link2  
angle=265:-15:105;		% define an arc from 270 to 90 degree r=1.125
xa=1.125*cos(angle*pi/180);
ya=1.125*sin(angle*pi/180);
angle=150:15:210;		% get rit of where links overlap
xc=8.625+1.125*cos(angle*pi/180);
yc=1.125*sin(angle*pi/180);
xL1=[0 7.1875 7.1875 7.72978 xc 7.72978 7.1875 7.1875 0 xa 0];
yL1=[1.125 1.125 .875 .68133 yc -.68133 -.875 -1.125 -1.125 ya 1.125];
Link1=[xL1' yL1' zeros(size(xL1))' ones(size(xL1))']';  % Link1 matrix
Link2=Link1;		

xL3=[0 2.875 3.125 3.125 4.875 6.625 6.6258 4.875 3.125 3.125 2.875 0 xa 0];
yL3=[1.125*ones(1,3) .875 .875 .25 -.25 -.875 -.875 -1.125*ones(1,3) ya 1.125];
Link3=[xL3' yL3' zeros(size(xL3))' ones(size(xL3))']';  % Link3 matrix


pF1=fill(Link1(1,:),Link1(2,:),'*g');	% color fill link1
set(pF1,'FaceColor',[.2 .8 .2]);
pF2=fill(Link2(1,:),Link2(2,:),'y');	% color fill link2
set(pF2,'FaceColor',[.8 .9 .2]);
pF3=fill(Link3(1,:),Link3(2,:),'b');	% color fill link3
set(pF3,'FaceColor',[.2 .2 .8]);
