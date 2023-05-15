sqlldr ninjateam/ninjateam@ninjaprod1 -data=%1 -control=hgu_dsp_request.ctl -bad=hgu_dsp_request.bad -discard=hgu_dsp_request.dsc -errors=256000
pause
