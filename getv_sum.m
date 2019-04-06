function result = getv_sum(kv,wv,Pmin,Pmax,i,opt)
result =0;

x =1;
hang = size(kv,1);
for m = i:i+opt.NumView-1
    y=1;
    for n = Pmin:Pmax
        
        if(n>0 && n <= hang)
            result = result + kv(n,m)*wv(y,x);
        end
        y = y+1;
    end
    x=x+1;
end