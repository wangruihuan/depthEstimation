function kh = geth_bins_color(img_h ,k,edgesch)

kh = img_h;
h1 = kh(:,:,1);
h2 = kh(:,:,2);
h3 = kh(:,:,3);


h1( h1<=edgesch(k) |  h1 >edgesch(k+1) ) = 0;
h1( h1 > edgesch(k) &  h1<=edgesch(k+1) ) = 1;

h2( h2<=edgesch(k) |  h2 >edgesch(k+1) ) = 0;
h2( h2 > edgesch(k) &  h2<=edgesch(k+1) ) = 1;

h3( h3<=edgesch(k) |  h3 >edgesch(k+1) ) = 0;
h3( h3 > edgesch(k) &  h3<=edgesch(k+1) ) = 1;

kh(:,:,1) = h1;
kh(:,:,2) = h2;
kh(:,:,3) = h3;

