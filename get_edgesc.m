function   edgesc = get_edgesc(min,max,NumberOfBins)
edge = linspace(min,max,NumberOfBins+1); %得到水平的间隔
binwidth_h = edge(2) - edge(1);
edgesc = edge + eps(edge);
edgesc (1) = -Inf;
edgesc (end) = Inf;