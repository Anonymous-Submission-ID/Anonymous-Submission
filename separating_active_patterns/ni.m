function I = ni(I)
   
I = single(I);

I = I - min(I(:));

I = I./(max(I(:))+eps);

end