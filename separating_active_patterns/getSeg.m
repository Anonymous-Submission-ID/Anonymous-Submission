function seg  = getSeg(BW, Ihsv)

[nRows, nCols, aux] = size(Ihsv);

f_fg = find(BW);

f_bg = find(BW==0);

dimH = 100;
dimS = 25;  %25 
dimV = 10; %10

h = Ihsv(:,:,1);
s = Ihsv(:,:,2);
v = Ihsv(:,:,3);


h = h(f_fg);
s = s(f_fg);
v = v(f_fg);

%transform into euclidean coordinates

hx = (s.*cos(h*2*pi)+1)/2;
hy = (s.*sin(h*2*pi)+1)/2;

h = hx;
s = hy;

h = round(h*(dimH-1)+1);
v = round(v*(dimV-1)+1);
s = round(s*(dimS-1)+1);

col_fg = h + (s-1)*dimH + (v-1)*dimH*dimS;

histCol_fg = col_fg;
histCol_fg = hist(histCol_fg, 1:(dimH*dimS*dimV));
histCol_fg = histCol_fg/(sum(histCol_fg) +eps);

h = Ihsv(:,:,1);
s = Ihsv(:,:,2);
v = Ihsv(:,:,3);

h = h(f_bg);
s = s(f_bg);
v = v(f_bg);

%transform into euclidean coordinates

hx = (s.*cos(h*2*pi)+1)/2;
hy = (s.*sin(h*2*pi)+1)/2;

h = hx;
s = hy;

%--------------------------------------


h = round(h*(dimH-1)+1);
v = round(v*(dimV-1)+1);
s = round(s*(dimS-1)+1);

col_bg = h + (s-1)*dimH + (v-1)*dimH*dimS;

histCol_bg = col_bg;

histCol_bg = hist(histCol_bg, 1:(dimH*dimS*dimV)) + 1;

histCol_bg = histCol_bg/(sum(histCol_bg)+eps);

%-------------------------------------------------------------------------

seg = zeros(nRows, nCols);

seg(f_fg) = histCol_fg(col_fg)./(histCol_fg(col_fg) + histCol_bg(col_fg));

seg(f_bg) = histCol_fg(col_bg)./(histCol_fg(col_bg) + histCol_bg(col_bg));







