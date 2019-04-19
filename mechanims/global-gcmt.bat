gmtset PLOT_DEGREE_FORMAT dddF

set region=-180/180/-90/90
set width=0.065
set axes="WNes"
set axex="a30f10"
set axey="a30f10"
set msize=0.25
set PS=global_cmts.ps

gmt psbasemap -Rg -Jx%width% -B%axes%+t" "  -Bx%axex% -By%axey% -K > %PS%
gmt pscoast -R -J -Da -K -O >> %PS% 

rem psmeca -Sc
rem example: psmec -Sa  lon lat dep strike dip rake mag x y event
rem example: psmec -Sc  Lon Lat depth strike1 dip1 rake1 strike2 dip2 rake2 mantissa exponent newX newY title
rem          psmec -Sm  Lon Lat depth mrr mtt mff mrt mrf mtf exp newX newY title
rem  colurs: magenta orange  
rem gawk "{print $3,$4,$5,$14,$15,$16,$17,$18,$19,$30}" jan76-oct18_gcmt.dat | gmt  psmeca -R -J -Sm%msize% -Fa0.05c/0.05c -Gblack -W0.25p -K -O >> %PS% 
gawk "{print $3,$4,$5,$14,$15,$16,$17,$18,$19,$30}" nf.dat | gmt psmeca -R -J -Sm%msize% -Fa0.05c/0.05c -Ggreen -W0.25p -K -O >> %PS%
gawk "{print $3,$4,$5,$14,$15,$16,$17,$18,$19,$30}" ns.dat | gmt psmeca -R -J -Sm%msize% -Fa0.05c/0.05c -Ggreen -W0.25p -K -O >> %PS% 
gawk "{print $3,$4,$5,$14,$15,$16,$17,$18,$19,$30}" ts.dat | gmt psmeca -R -J -Sm%msize% -Fa0.05c/0.05c -Gred -W0.25p -K -O >> %PS%
gawk "{print $3,$4,$5,$14,$15,$16,$17,$18,$19,$30}" tf.dat | gmt psmeca -R -J -Sm%msize% -Fa0.05c/0.05c -Gred -W0.25p,black -K -O >> %PS%
gawk "{print $3,$4,$5,$14,$15,$16,$17,$18,$19,$30}" ss.dat | gmt psmeca -R -J -Sm%msize% -Fa0.05c/0.05c -Gblue -W0.25p,black -K -O >> %PS%

gawk "{print $3,$4,$5,$14,$15,$16,$17,$18,$19,$30}" un.dat | gmt psmeca -R -J -Sm%msize% -Fa0.05c/0.05c -Gblack -W0.25p  -O >> %PS%
