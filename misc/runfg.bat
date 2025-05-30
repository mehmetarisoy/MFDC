C:

cd C:\Program Files\FlightGear 2024.1

SET FG_ROOT=C:\Users\mehme\FlightGear\Downloads\fgdata_2024_1

.\\bin\fgfs.exe --fdm=null --native-fdm=socket,in,30,localhost,5502,udp --native-ctrls=socket,out,30,localhost,5505,udp --enable-terrasync  --aircraft=gripen --fog-fastest --disable-clouds --start-date-lat=2004:06:01:09:00:00 --disable-sound --in-air --airport=LTAE --runway=03 --altitude=3000 --heading=32 --offset-distance=4.72 --offset-azimuth=0
