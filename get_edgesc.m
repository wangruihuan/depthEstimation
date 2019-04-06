function   edgesc = get_edgesc(min,max,NumberOfBins)
edge = linspace(min,max,NumberOfBins+1); %�õ�ˮƽ�ļ��
binwidth_h = edge(2) - edge(1);
edgesc = edge + eps(edge);
edgesc (1) = -Inf;
edgesc (end) = Inf;