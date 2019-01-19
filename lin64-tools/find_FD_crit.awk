#$Header: /data/petsun4/data1/solaris/csh_scripts/RCS/find_FD_crit.awk,v 1.1 2017/09/28 03:06:00 avi Exp $
#$Log: find_FD_crit.awk,v $
# Revision 1.1  2017/09/28  03:06:00  avi
# Initial revision
#

BEGIN {
	debug = 0;
	tol = 4.;	# in units of s.d.
	FDmax = 1.;	# can be over-ridden on command line
	nval = 0;
}

$1 !~/#/ && $1 < 100. {
	vals[nval] = $1;
	nval++;
}

END {
	nbin = int (nval/25);
	del = FDmax/nbin;
	if (debug) printf ("nval=%d nbin=%d del=%.4f\n", nval, nbin, del);

	for (i = 0; i < nval; i++) {
		k = int (vals[i]/del);
		y[k]++;	# y has histogram
	}
	m = 0;		# index of max bin
	for (k = 0; k < nbin; k++) if (y[k] > y[m]) m = k;
	if (m == 0 || m == nbin - 1) {
		print "invalid histogram";
		exit -1;
	}
	mode = del*(m + 0.5 - 0.5*((y[m + 1] - y[m - 1])/(y[m + 1] + y[m - 1] - 2.*y[m])));

	mval = 0; ss = 0;
	for (i = 0; i < nval; i++) if (vals[i] < mode) {
		ss += (mode - vals[i])^2;
		mval++;
	}
	sd = sqrt (ss/mval);
	crit = mode + tol*sd;
	if (debug) {
		m = 0;
		for (i = 0; i < nval; i++) if (vals[i] > crit) m++;
		printf ("mode=%f sd=%f mode+tol*sd=%f\n", mode, sd, crit);
		printf ("censored fraction = %.4f\n", m/nval);
	} else {
		printf ("%f", crit);
	}
}
