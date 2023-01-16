clc; clear; close all; 
%% ASEN 3113
% enter as percent
exam1 = 100;
exam2 = 80;
exam3 = 100;

% enter as percent
lab1 = 85;
lab2 = 95;
designLab = 95; 

% enter points /30
hw1 = 30;
hw2 = 26;
hw3 = 30;
hw4 = 30; 
hw5 = 30;
hw6 = 29; 
hw7 = 30; 
hw8 = 28;
hw9 = 29; 
hw10 = 29;

% enter as points /10
quiz1 = 8;
quiz2 = 10;
quiz3 = 9;
quiz4 = 9;
quiz5 = 10;
quiz6 = 10;
quiz7 = 9;
quiz8 = 9;
quiz9 = 9;
quiz10 = 9;
quiz11 = 7;
quiz12 = 10;

% enter as percent
clickGrade = 98.1;

% calcing
exam_avg = mean([exam1, exam2, exam3]);
exam_w = exam_avg*3*0.08;
lab_w = lab1*0.1 + lab2*0.1 + designLab*0.08;
hw_w = mean([hw1, hw2, hw3, hw4, hw5, hw6, hw7, hw8, hw9, hw10]/.30)*0.15;
quiz_temp = sort([quiz1, quiz2, quiz3, quiz4, quiz5, quiz6, quiz7, quiz8, quiz9, quiz10, quiz11, quiz12]/.1);
quiz_temp = quiz_temp(4:end); % drop lowest 3
quiz_w = mean(quiz_temp)*0.05;
tot_clickers = 103;
clicker_temp = round(((clickGrade)/100)*tot_clickers)/(tot_clickers-3)*100; % drop lowest 3
if clicker_temp > 100
    clicker_temp = 100;
end
clicker_w = clicker_temp*0.05;
curr_grade = exam_w + lab_w + hw_w + quiz_w + clicker_w;
want = input("Enter desired thermo grade (percent): ");
required_Final = ((want - curr_grade)/23)*100;
fprintf("Need %f percent on the thermo final\n", required_Final);

%% ASEN 3112
% enter as percents
exam1 = ((49)/50)*100;
exam2 = ((50)/50)*100;
exam3 = 100;

lab1 = 92; 
lab2 = 97;
lab3 = 90;
lab4 = 95;

% enter as percent
hw1 = (50/50)*100;
hw2 = (49/50)*100;
hw3 = (50/50)*100;
hw4 = (50/50)*100;
hw5 = (50/50)*100;
hw6 = (50/50)*100;
hw7 = (50/50)*100;
hw8 = (50/50)*100;
hw9 = (50/50)*100;
hw10 = (50/50)*100;
hw11 = (50/50)*100;

% enter as percent
quizAvg = 100;

% enter as percent
clickerGrade = 90;

% calcing
exam_w = mean([exam1, exam2, exam3])*0.3;
lab_w = lab1*0.05 + lab2*0.1 + lab3*0.05 + lab4*0.05;
hw_temp = sort([hw1,hw2,hw3,hw4,hw5,hw6,hw7,hw8,hw9,hw10,hw11]);
hw_temp = hw_temp(3:end); % drop lowest 2
hw_w = mean(hw_temp)*0.15;
quiz_w = quizAvg*0.05;
clicker_w = clickerGrade*0.05;
curr_grade = exam_w + lab_w + hw_w + quiz_w + clicker_w;
want = input("Enter desired structures grade (percent): ");
required_Final = ((want - curr_grade)/20)*100;
fprintf("Need %f percent on the structres final (doesnt consider dropping midterms, uncomment code below if want)\n", required_Final);

% finalTest = input("Enter a projected final grade (percent): ");
% exam1New = exam1;
% exam2New = exam2;
% exam3New = exam3;
% if finalTest > exam1
%     exam1New = finalTest;
% elseif finalTest > exam2
%     exam2New = finalTest;
% elseif finalTest > exam3
%     exam3New= finalTest;
% end
% exam_wNew = mean([exam1New, exam2New, exam3New])*0.3;
% curr_gradeNew = exam_wNew + lab_w + hw_w + quiz_w + clicker_w + finalTest*0.2;
% fprintf("Would get a %f percent in the class\n", curr_gradeNew

%% ASEN 3128
% enter as percent
exam1 = (36/40)*100;
exam2 = (40/40)*100;

% enter as percent
lab1 = 50*2;
lab2 = 45*2;
lab3 = 46*2;
lab4 = 50*2; 
lab5 = 50*2;
lab6 = 48.5*2;
lab7 = 45*2;

% enter as percent
hw1 = 100;
hw2 = 100;
hw3 = 97.22;
hw4 = (11/12)*100;
hw5 = (13.5/14)*100;
hw6 = 92;
hw7 = 92;

% enter as percent
quizAvg = 97.5;

% calcing:
exam_w = exam1*0.18 + exam2*0.18;
lab_w = mean([lab1,lab2,lab3,lab4,lab5,lab6,lab7])*0.28;
hw_w = mean([hw1,hw2,hw3,hw4,hw5,hw6,hw7])*0.12;
quiz_w = quizAvg*0.06;
curr_grade = exam_w + lab_w + hw_w + quiz_w;
want = input("Enter desired aircraft grade (percent): ");
required_Final = ((want - curr_grade)/18)*100;
fprintf("Need %f percent on the aircraft final\n", required_Final);
