function result = geth_sum(k,w,Pmin,Pmax,i,opt)

result =0;

x =1;
lie = size(k,2);
for m = i:i+opt.NumView-1
    y=1;
    for n = Pmin:Pmax
        
        if(n>0 && n <= lie)
            result = result + k(m,n)*w(x,y);
        end
        y = y+1;
    end
    x=x+1;
end