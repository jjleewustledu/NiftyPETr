#$Header: /data/petsun4/data1/solaris/csh_scripts/RCS/find_dvar_crit.awk,v 1.1 2016/05/28 01:11:43 avi Exp $
#$Log: find_dvar_crit.awk,v $
# Revision 1.1  2016/05/28  01:11:43  avi
# Initial revision
#
# Revision 1.1  2016/05/28  01:10:36  avi
# Initial revision
#

BEGIN {
	debug = 0;
	tol = 2.5;	# in units of s.d.
	dvarmax = 10.;	# can be over-ridden on command line
	nval = 0;
}

$1 !~/#/ && NF == 1 {
	vals[nval] = $1;
	nval++;
}

$1 !~/#/ && NF == 2 && $2 == "+" {
	vals[nval] = $1;
	nval++;
}

END {
	nbin = int (nval/25);
	del = dvarmax/nbin;
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
	if (debug) printf ("mode=%f sd=%f mode+tol*sd=%f\n", mode, sd, crit);
	printf ("%f", crit);
}
