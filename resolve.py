import pixiedust

# after installing fsl, freesurfer paths
#. $FSLDIR/etc/fslconf/fsl.sh
#. $FREESURFER_HOME/SetUpFreeSurfer.sh
from respet.recon.reconstruction import Reconstruction
import PyConstructResolved

loc = '/ds/HYGLY48/V1/FDG_V1-Converted'

obj = Reconstruction(loc, ac=False, v=True)
out = obj.createDynamicNAC(fcomment='_createDynamicNAC')

pcr = PyConstructResolved.initialize()
out = pcr.construct_resolved('sessionsExpr', 'HYGLY48', 'visitsExpr', 'V1', 'tracer', 'FDG', 'ac', False)

obj = Reconstruction(loc, ac=True, v=True)
out = obj.createDynamic2Carney(fcomment='_createDynamic2Carney')

out = pcr.construct_resolved('sessionsExpr', 'HYGLY48', 'visitsExpr', 'V1', 'tracer', 'FDG', 'ac', True)

