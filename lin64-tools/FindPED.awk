BEGIN {
	found = 0
}
{        
	if ( $1 ~ "PhaseEncodingDirectionPositive" ) {
		print $1
	 	found = 1;
	}
	if ( found == 1 && NF == 1) {
	 	if ( $1 == 1 ) {
			print -1;
			exit;
		}
		else if ( $1 == 0) {
			print 1;
			exit;
		}
	}
}



