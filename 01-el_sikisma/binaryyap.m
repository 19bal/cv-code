function bw = binaryyap(I, esik)
	[R C] = size(I);
	bw = logical(zeros(R,C));
	bw(esik < I) = 1;
