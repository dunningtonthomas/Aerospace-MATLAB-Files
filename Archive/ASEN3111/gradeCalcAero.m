clc;
%% ASEN 3111

% Enter exam grades and lecture quizzes as points in gradebook
e1P1 = 37;
e1P2 = 56;

e2P1 = 26;
e2P2 = 65;

e3P1 = 50;
e3P2 = 45;

lecQ1 = 8;
lecQ2 = 8;
lecQ3 = 10;
lecQ4 = 10;

% Enter lab grades as points in gradebook
CA1 = 105;
labQ1 = 10;

CA2 = 98;
labQ2 = 9;

CA3 = 97;
labQ3 = 10;

CA4 = 100;
labQ4 = 10;

% Enter Hw grade as percent in canvas

Hw = 100;

% Calc grade
% drop lowest reading
read = sort([lecQ1, lecQ2, lecQ3, lecQ4]);
read = read(2:end);

individCurr = 36*(sum([e1P1, e1P2, e2P1, e2P2, e3P1, e3P2])/300) + 5*mean(read)/10 + 10*mean([labQ1, labQ2, labQ3, labQ4])/10;

group = 5*Hw/100 + 20*mean([CA1, CA2, CA3, CA4])/100;

curr = individCurr + group;

fprintf("Current Grade: %s \n", num2str(100*(curr)/(100 - 24)))
fprintf("Current Individual Grade: %s \n", num2str(100*individCurr/(51)))

want = input("Enter desired grade (percent): ");

% find final exam that gives desired grade
finalVec = linspace(1,500,1000);
check = false;
i = 1;
while check == false

    exam1New = e1P1 + e1P2;
    exam2New = e2P1 + e2P2;
    exam3New = e3P1 + e3P2;
    if finalVec(i) > (e1P1 + e1P2)
        exam1New = finalVec(i);
    end
    if finalVec(i) > (e2P1 + e2P2)
        exam2New = finalVec(i);
    end
    if finalVec(i) > (e3P1 + e3P2)
        exam3New = finalVec(i);
    end
    exam_wNew = mean([exam1New, exam2New, exam3New])*0.36;
    curr_gradeNew = exam_wNew + finalVec(i)*0.24 + 5*mean(read)/10 + 10*mean([labQ1, labQ2, labQ3, labQ4])/10 + 5*Hw/100 + 20*mean([CA1, CA2, CA3, CA4])/100;

    if curr_gradeNew >= want
        check = true;
        needed = finalVec(i);
    end
    i = i + 1;
end
fprintf("Need %f percent on the final. \n", needed);

