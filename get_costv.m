function result = get_costv(yv,hangv,liev ,opts)

result = zeros(hangv,liev);
for i = 0:liev-1
    result(:,i+1) = yv(: ,round(opts.NumView/2) +i*opts.NumView  );
end
