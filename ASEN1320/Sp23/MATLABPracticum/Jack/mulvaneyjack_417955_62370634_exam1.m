  clc, clear, close all;

  x = input("Enter Accuracy: ");
  if(x <0.001)
      x = input("Enter Accuracy: ");
  end
  
  ee = 1/exp(1);

  if(x < cond)
      for(n = 1:n+1)
      
      aprox = ((1-(1/n))^n);
      end
      cond = ee-aprox;
  end

  fprintf("n: %.d", n)
  fprintf("Approximation: %.5d",aprox)
  fprintf("Actual: %.5d",ee)

