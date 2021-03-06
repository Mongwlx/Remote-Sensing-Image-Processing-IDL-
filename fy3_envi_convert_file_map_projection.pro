;forward_function 　envi_proj_create
PRO FY3_ENVI_CONVERT_FILE_MAP_PROJECTION
　ENVI,/RESTORE_BASE_SAVE_FILES
  ENVI_BATCH_INIT,LOG_FILE=’BATCH.TXT’
  
  FY3MERSI_TIF_FILE_FILE=DIALOG_PICKFILE(/READ,PATH=DEFAULTPATH,DEFAULT_EXTENSION=’.TIF’,FILTER=’*.TIF’,TITLE=’PLEASE SELECT THE CORRECTED FY3-MERSI FILE’)
  TARGET_DIRECTORY=DIALOG_PICKFILE(PATH=DEFAULTPATH, /DIRECTORY TITLE=’PLEASE SELECT THE RESULT SAVING DIRECTORY’ )
  FILENAME=FILE_BASENAME(FY3MERSI_TIF_FILE ,’.TIF’)
  OUT_NAME= TARGET_DIRECTORY+FILENAME+’.IMG’
  ENVI_OPEN_FILE, FY3MERSI_TIF_FILE,R_FID=FID
  IF(FID EQ-1) THEN BEGIN
    ENVI_BATCH_EXIT
    RETURN
  ENDIF
  ENVI_FILE_QUERY,FID,DIMS=DIMS,NB=NB,POS=LINDGEN(NB)
  O_PROJ=ENVI_PROJ_CREATE(/GEOGRAPHIC)
  O_PIXEL_SIZE=[0.0025,0.0025]
  ENVI_CONVERT_FILE_MAP_PROJECTION,FID=FID,POS=POS,DIMS=DIMS,O_PROJ=O_PROJ,O_PIXEL_SIZE= O_PIXEL_SIZE,$
  OUT_NAME=OUT_NAME,WARP_METHOD=0,RESAMPLING=1,BACKGROUND=0
  ENVI_FILE_MNG,ID=FID,/REMOVE
  ENVI_BATCH_EXIT
  EXIT ENVI
END
