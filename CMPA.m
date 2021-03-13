% ELEC 4700 PA -8 CMPA 
%Muhammad Shabeeh Raza Abbas
%101092004

set(0,'DefaultFigureWindowStyle','docked')

%Part 1

%given data
Is = 0.01e-12; %A
Ib = 0.1e-12; %A
Vb = 1.3; % V
Gp1 = 0.1; % Ω−1

V = linspace(-1.95,0.7,200);   %V vector creation

ID = (Is*(exp(V*1.2/0.025)-1)) + (Gp1*V) - (Ib*(exp(-1.2*(V+Vb)/0.025)-1));

randomvector = (1.2-0.5).*rand(size(ID)) + 0.5;

Inew = randomvector.*ID;
figure(1)
subplot(2,1,1)
plot(V,ID,V,Inew)
subplot(2,1,2)
semilogy(V,abs(ID),V,abs(Inew))

%Part 2
P4 = polyfit(V,ID,4);
Po4 = polyval(P4,V);

P8 = polyfit(V,ID,8);
Po8 = polyval(P8,V);

figure(2)
subplot(2,2,1)
plot(V,ID,'b',V,Po4,'y')

subplot(2,2,2)
plot(V,ID,'b',V,Po8,'y')

po4 = polyfit(V,Inew,4); 
a = polyval(po4,V);
subplot(2,2,3)
semilogy(V,abs(ID),'b',V,abs(a),'y')


pol8 = polyfit(V,Inew,8);
b = polyval(pol8,V);
subplot(2,2,4)
semilogy(V,abs(ID),'b',V,abs(b),'y')

%Part 3 

fo1 = fittype('A*(exp(1.2*x/0.025)-1) + (0.1*x) - (C*(exp(-1.2*(x+1.3)/0.025)-1))');
ff1 = fit(V',ID',fo1);
If1 = ff1(V);

figure(3)
subplot(3,1,1)
semilogy(V,abs(If1'),'b',V,abs(Inew),'y')

fo2 = fittype('A*(exp(1.2*x/0.025)-1) + (B*x) - (C*(exp(-1.2*(x+1.3)/0.025)-1))');
ff2 = fit(V',ID',fo2);
If2 = ff2(V);

subplot(3,1,2)
semilogy(V,abs(If2'),'b',V,abs(Inew),'y')

fo3 = fittype('A*(exp(1.2*x/0.025)-1) + (B*x) - (C*(exp(-1.2*(x+D)/0.025)-1))');
ff3 = fit(V',ID',fo3);
If3 = ff3(V);

subplot(3,1,3)
semilogy(V,abs(If3'),'b',V,abs(Inew),'y')

%Part 4 

inputs = V.';
targets = ID.';
LayerSize = 10;
net = fitnet(LayerSize); 
net.divideParam.trainRatio = 70/100; 
net.divideParam.valRatio = 15/100; 
net.divideParam.testRatio = 15/100; 
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets); 
performance = perform(net,targets,outputs); 
view(net)
Inn = outputs;

figure(4)
plot(inputs,Inn,'b',inputs,Inew,'y')