function result = get_costh(yh,hangh,lieh,opts)

result = zeros(hangh,lieh);
for i = 0:hangh-1
    result(i+1,:) = yh(round(opts.NumView/2) +i*opts.NumView,:  );
end
