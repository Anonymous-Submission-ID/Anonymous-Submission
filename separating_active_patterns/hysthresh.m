function bw = hysthresh(im, T1, T2)

    if T1 < T2    % T1 and T2 reversed - swap values 
	tmp = T1;
	T1 = T2; 
	T2 = tmp;
    end
    
    aboveT2 = im > T2;                     % Edge points above lower
                                           % threshold. 
    [aboveT1r, aboveT1c] = find(im > T1);  % Row and colum coords of points
                                           % above upper threshold.
					   
    % Obtain all connected regions in aboveT2 that include a point that has a
    % value above T1 
    bw = bwselect(aboveT2, aboveT1c, aboveT1r, 8);

