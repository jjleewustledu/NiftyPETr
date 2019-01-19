#!/bin/csh
#$Log: dicom_unrename.csh,v $
# Revision 1.2  2017/08/26  01:01:37  avi
# make ln script robust to embedded metacharacters in file names
#
set rcsid       = '$Id: dicom_unrename.csh,v 1.2 2017/08/26 01:01:37 avi Exp $'
echo $rcsid
set program     = $0; set program = $program:t

if ($#argv != 1) goto USAGE
set D = $1
if (! -d $D) then
	echo $program": "$D" is not a directory"
	exit -1
endif

@ k = `echo $D | gawk '{print split($1,a,"/");}'`
echo "k="$k

if (-e DICOM) /bin/rm -rf DICOM
mkdir DICOM
pushd DICOM

find $D >! $$.lst
cat $$.lst | gawk '{m=split($1,a,"/"); if(m==k+3) printf ("ln -s \"%s\" %d_%d.dcm\n", $1, a[k+1], a[k+3]);}' k=$k >! ../ln.cmd
source ../ln.cmd
/bin/rm $$.lst
exit 0

USAGE:
echo "Usage:    "$program" <archive_DICOM_directory>"
echo " e.g.,    "$program" /data/jsp/human2/FirstDose/FD001/MR_2011.02.11"
exit -1
