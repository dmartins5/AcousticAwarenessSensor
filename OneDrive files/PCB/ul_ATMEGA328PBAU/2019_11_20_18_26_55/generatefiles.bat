rem --- Component "ATMEGA328PB-AU" ---
newgenasym.exe -i "%cd%\exported\atmega328pb_au" -n "atmega328pb_au"
van.exe -q -nolinks -sironly "%cd%\exported\atmega328pb_au\entity\verilog.v" -lib "exported_lib" -view entity -cdslib "%cd%\exported_lib.lib"

Pause
