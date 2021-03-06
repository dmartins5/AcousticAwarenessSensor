PULSONIX_LIBRARY_ASCII "SamacSys ECAD Model"
//323433/145725/2.44/32/4/Integrated Circuit

(asciiHeader
	(fileUnits MM)
)
(library Library_1
	(padStyleDef "r150_60"
		(holeDiam 0)
		(padShape (layerNumRef 1) (padShapeType Rect)  (shapeWidth 0.6) (shapeHeight 1.5))
		(padShape (layerNumRef 16) (padShapeType Ellipse)  (shapeWidth 0) (shapeHeight 0))
	)
	(textStyleDef "Normal"
		(font
			(fontType Stroke)
			(fontFace "Helvetica")
			(fontHeight 1.27)
			(strokeWidth 0.127)
		)
	)
	(patternDef "QFP80P900X900X120-32N" (originalName "QFP80P900X900X120-32N")
		(multiLayer
			(pad (padNum 1) (padStyleRef r150_60) (pt -4.25, 2.8) (rotation 0))
			(pad (padNum 2) (padStyleRef r150_60) (pt -4.25, 2) (rotation 0))
			(pad (padNum 3) (padStyleRef r150_60) (pt -4.25, 1.2) (rotation 0))
			(pad (padNum 4) (padStyleRef r150_60) (pt -4.25, 0.4) (rotation 0))
			(pad (padNum 5) (padStyleRef r150_60) (pt -4.25, -0.4) (rotation 0))
			(pad (padNum 6) (padStyleRef r150_60) (pt -4.25, -1.2) (rotation 0))
			(pad (padNum 7) (padStyleRef r150_60) (pt -4.25, -2) (rotation 0))
			(pad (padNum 8) (padStyleRef r150_60) (pt -4.25, -2.8) (rotation 0))
			(pad (padNum 9) (padStyleRef r150_60) (pt -2.8, -4.25) (rotation 0))
			(pad (padNum 10) (padStyleRef r150_60) (pt -2, -4.25) (rotation 0))
			(pad (padNum 11) (padStyleRef r150_60) (pt -1.2, -4.25) (rotation 0))
			(pad (padNum 12) (padStyleRef r150_60) (pt -0.4, -4.25) (rotation 0))
			(pad (padNum 13) (padStyleRef r150_60) (pt 0.4, -4.25) (rotation 0))
			(pad (padNum 14) (padStyleRef r150_60) (pt 1.2, -4.25) (rotation 0))
			(pad (padNum 15) (padStyleRef r150_60) (pt 2, -4.25) (rotation 0))
			(pad (padNum 16) (padStyleRef r150_60) (pt 2.8, -4.25) (rotation 0))
			(pad (padNum 17) (padStyleRef r150_60) (pt 4.25, -2.8) (rotation 0))
			(pad (padNum 18) (padStyleRef r150_60) (pt 4.25, -2) (rotation 0))
			(pad (padNum 19) (padStyleRef r150_60) (pt 4.25, -1.2) (rotation 0))
			(pad (padNum 20) (padStyleRef r150_60) (pt 4.25, -0.4) (rotation 0))
			(pad (padNum 21) (padStyleRef r150_60) (pt 4.25, 0.4) (rotation 0))
			(pad (padNum 22) (padStyleRef r150_60) (pt 4.25, 1.2) (rotation 0))
			(pad (padNum 23) (padStyleRef r150_60) (pt 4.25, 2) (rotation 0))
			(pad (padNum 24) (padStyleRef r150_60) (pt 4.25, 2.8) (rotation 0))
			(pad (padNum 25) (padStyleRef r150_60) (pt 2.8, 4.25) (rotation 0))
			(pad (padNum 26) (padStyleRef r150_60) (pt 2, 4.25) (rotation 0))
			(pad (padNum 27) (padStyleRef r150_60) (pt 1.2, 4.25) (rotation 0))
			(pad (padNum 28) (padStyleRef r150_60) (pt 0.4, 4.25) (rotation 0))
			(pad (padNum 29) (padStyleRef r150_60) (pt -0.4, 4.25) (rotation 0))
			(pad (padNum 30) (padStyleRef r150_60) (pt -1.2, 4.25) (rotation 0))
			(pad (padNum 31) (padStyleRef r150_60) (pt -2, 4.25) (rotation 0))
			(pad (padNum 32) (padStyleRef r150_60) (pt -2.8, 4.25) (rotation 90))
		)
		(layerContents (layerNumRef 18)
			(attr "RefDes" "RefDes" (pt 0, 0) (textStyleRef "Normal") (isVisible True))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt -5.25 5.25) (pt 5.25 5.25) (width 0.05))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt 5.25 5.25) (pt 5.25 -5.25) (width 0.05))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt 5.25 -5.25) (pt -5.25 -5.25) (width 0.05))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt -5.25 -5.25) (pt -5.25 5.25) (width 0.05))
		)
		(layerContents (layerNumRef 28)
			(line (pt -3.5 3.5) (pt 3.5 3.5) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt 3.5 3.5) (pt 3.5 -3.5) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt 3.5 -3.5) (pt -3.5 -3.5) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt -3.5 -3.5) (pt -3.5 3.5) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt -3.5 2.7) (pt -2.7 3.5) (width 0.025))
		)
		(layerContents (layerNumRef 18)
			(line (pt -3.15 3.15) (pt 3.15 3.15) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt 3.15 3.15) (pt 3.15 -3.15) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt 3.15 -3.15) (pt -3.15 -3.15) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt -3.15 -3.15) (pt -3.15 3.15) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(arc (pt -4.6, 4) (radius 0) (width 0.4))
		)
	)
	(symbolDef "ATMEGA328PB-AU" (originalName "ATMEGA328PB-AU")

		(pin (pinNum 1) (pt 0 mils 0 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -25 mils) (rotation 0]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 2) (pt 0 mils -100 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -125 mils) (rotation 0]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 3) (pt 0 mils -200 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -225 mils) (rotation 0]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 4) (pt 0 mils -300 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -325 mils) (rotation 0]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 5) (pt 0 mils -400 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -425 mils) (rotation 0]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 6) (pt 0 mils -500 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -525 mils) (rotation 0]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 7) (pt 0 mils -600 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -625 mils) (rotation 0]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 8) (pt 0 mils -700 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 230 mils -725 mils) (rotation 0]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 9) (pt 1200 mils -2500 mils) (rotation 90) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1225 mils -2270 mils) (rotation 90]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 10) (pt 1300 mils -2500 mils) (rotation 90) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1325 mils -2270 mils) (rotation 90]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 11) (pt 1400 mils -2500 mils) (rotation 90) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1425 mils -2270 mils) (rotation 90]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 12) (pt 1500 mils -2500 mils) (rotation 90) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1525 mils -2270 mils) (rotation 90]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 13) (pt 1600 mils -2500 mils) (rotation 90) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1625 mils -2270 mils) (rotation 90]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 14) (pt 1700 mils -2500 mils) (rotation 90) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1725 mils -2270 mils) (rotation 90]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 15) (pt 1800 mils -2500 mils) (rotation 90) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1825 mils -2270 mils) (rotation 90]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 16) (pt 1900 mils -2500 mils) (rotation 90) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1925 mils -2270 mils) (rotation 90]) (justify "Left") (textStyleRef "Normal"))
		))
		(pin (pinNum 17) (pt 3200 mils 0 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 2970 mils -25 mils) (rotation 0]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 18) (pt 3200 mils -100 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 2970 mils -125 mils) (rotation 0]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 19) (pt 3200 mils -200 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 2970 mils -225 mils) (rotation 0]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 20) (pt 3200 mils -300 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 2970 mils -325 mils) (rotation 0]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 21) (pt 3200 mils -400 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 2970 mils -425 mils) (rotation 0]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 22) (pt 3200 mils -500 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 2970 mils -525 mils) (rotation 0]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 23) (pt 3200 mils -600 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 2970 mils -625 mils) (rotation 0]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 24) (pt 3200 mils -700 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 2970 mils -725 mils) (rotation 0]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 25) (pt 1200 mils 1700 mils) (rotation 270) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1225 mils 1470 mils) (rotation 90]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 26) (pt 1300 mils 1700 mils) (rotation 270) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1325 mils 1470 mils) (rotation 90]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 27) (pt 1400 mils 1700 mils) (rotation 270) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1425 mils 1470 mils) (rotation 90]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 28) (pt 1500 mils 1700 mils) (rotation 270) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1525 mils 1470 mils) (rotation 90]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 29) (pt 1600 mils 1700 mils) (rotation 270) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1625 mils 1470 mils) (rotation 90]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 30) (pt 1700 mils 1700 mils) (rotation 270) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1725 mils 1470 mils) (rotation 90]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 31) (pt 1800 mils 1700 mils) (rotation 270) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1825 mils 1470 mils) (rotation 90]) (justify "Right") (textStyleRef "Normal"))
		))
		(pin (pinNum 32) (pt 1900 mils 1700 mils) (rotation 270) (pinLength 200 mils) (pinDisplay (dispPinName true)) (pinName (text (pt 1925 mils 1470 mils) (rotation 90]) (justify "Right") (textStyleRef "Normal"))
		))
		(line (pt 200 mils 1500 mils) (pt 3000 mils 1500 mils) (width 6 mils))
		(line (pt 3000 mils 1500 mils) (pt 3000 mils -2300 mils) (width 6 mils))
		(line (pt 3000 mils -2300 mils) (pt 200 mils -2300 mils) (width 6 mils))
		(line (pt 200 mils -2300 mils) (pt 200 mils 1500 mils) (width 6 mils))
		(attr "RefDes" "RefDes" (pt 3050 mils 1700 mils) (justify Left) (isVisible True) (textStyleRef "Normal"))
		(attr "Type" "Type" (pt 3050 mils 1600 mils) (justify Left) (isVisible True) (textStyleRef "Normal"))

	)
	(compDef "ATMEGA328PB-AU" (originalName "ATMEGA328PB-AU") (compHeader (numPins 32) (numParts 1) (refDesPrefix IC)
		)
		(compPin "1" (pinName "(OC2B/INT1/PTCXY) PD3") (partNum 1) (symPinNum 1) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "2" (pinName "(XCK0/T0/PTCXY) PD4") (partNum 1) (symPinNum 2) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "3" (pinName "(SDA1/ICP4/ACO/PTCXY) PE0") (partNum 1) (symPinNum 3) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "4" (pinName "VCC") (partNum 1) (symPinNum 4) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "5" (pinName "GND_1") (partNum 1) (symPinNum 5) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "6" (pinName "(SCL1/T4/PTCXY) PE1") (partNum 1) (symPinNum 6) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "7" (pinName "(XTAL1/TOSC1) PB6") (partNum 1) (symPinNum 7) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "8" (pinName "(XTAL2/TOSC2) PB7") (partNum 1) (symPinNum 8) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "9" (pinName "(OC0B/T1/PTCXY) PD5") (partNum 1) (symPinNum 9) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "10" (pinName "(OC0A/PTCXY/AIN0) PD6") (partNum 1) (symPinNum 10) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "11" (pinName "(PTCXY/AIN1) PD7") (partNum 1) (symPinNum 11) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "12" (pinName "(ICP1/CLKO/PTCXY) PB0") (partNum 1) (symPinNum 12) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "13" (pinName "(OC1A/PTCXY) PB1") (partNum 1) (symPinNum 13) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "14" (pinName "(SS0/OC1B/PTCXY) PB2") (partNum 1) (symPinNum 14) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "15" (pinName "(MOSI0/TXD1/OC2A/PTCXY) PB3") (partNum 1) (symPinNum 15) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "16" (pinName "(MISO0/RXD1/PTCXY) PB4") (partNum 1) (symPinNum 16) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "24" (pinName "PC1 (ADC1/PTCY/SCK1)") (partNum 1) (symPinNum 17) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "23" (pinName "PC0 (ADC0/PTCY/MISO1)") (partNum 1) (symPinNum 18) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "22" (pinName "PE3 (ADC7/PTCY/T3/MOSI1)") (partNum 1) (symPinNum 19) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "21" (pinName "GND_2") (partNum 1) (symPinNum 20) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "20" (pinName "AREF") (partNum 1) (symPinNum 21) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "19" (pinName "PE2 (ADC6/PTCY/ICP3/__SS1)") (partNum 1) (symPinNum 22) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "18" (pinName "AVCC") (partNum 1) (symPinNum 23) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "17" (pinName "PB5 (PTCXY/XCK0/SCK0)") (partNum 1) (symPinNum 24) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "32" (pinName "PD2 (PTCXY/INT0/OC3B/OC4B)") (partNum 1) (symPinNum 25) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "31" (pinName "PD1 (PTCXY/OC4A/TXD0)") (partNum 1) (symPinNum 26) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "30" (pinName "PD0 (PTCXY/OC3A/RXD0)") (partNum 1) (symPinNum 27) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "29" (pinName "PC6 (__RESET)") (partNum 1) (symPinNum 28) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "28" (pinName "PC5 (ADC5/PTCY/SCL0)") (partNum 1) (symPinNum 29) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "27" (pinName "PC4 (ADC4/PTCY/SDA0)") (partNum 1) (symPinNum 30) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "26" (pinName "PC3 (ADC3/PTCY)") (partNum 1) (symPinNum 31) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "25" (pinName "PC2 (ADC2/PTCY)") (partNum 1) (symPinNum 32) (gateEq 0) (pinEq 0) (pinType Unknown))
		(attachedSymbol (partNum 1) (altType Normal) (symbolName "ATMEGA328PB-AU"))
		(attachedPattern (patternNum 1) (patternName "QFP80P900X900X120-32N")
			(numPads 32)
			(padPinMap
				(padNum 1) (compPinRef "1")
				(padNum 2) (compPinRef "2")
				(padNum 3) (compPinRef "3")
				(padNum 4) (compPinRef "4")
				(padNum 5) (compPinRef "5")
				(padNum 6) (compPinRef "6")
				(padNum 7) (compPinRef "7")
				(padNum 8) (compPinRef "8")
				(padNum 9) (compPinRef "9")
				(padNum 10) (compPinRef "10")
				(padNum 11) (compPinRef "11")
				(padNum 12) (compPinRef "12")
				(padNum 13) (compPinRef "13")
				(padNum 14) (compPinRef "14")
				(padNum 15) (compPinRef "15")
				(padNum 16) (compPinRef "16")
				(padNum 17) (compPinRef "17")
				(padNum 18) (compPinRef "18")
				(padNum 19) (compPinRef "19")
				(padNum 20) (compPinRef "20")
				(padNum 21) (compPinRef "21")
				(padNum 22) (compPinRef "22")
				(padNum 23) (compPinRef "23")
				(padNum 24) (compPinRef "24")
				(padNum 25) (compPinRef "25")
				(padNum 26) (compPinRef "26")
				(padNum 27) (compPinRef "27")
				(padNum 28) (compPinRef "28")
				(padNum 29) (compPinRef "29")
				(padNum 30) (compPinRef "30")
				(padNum 31) (compPinRef "31")
				(padNum 32) (compPinRef "32")
			)
		)
		(attr "Manufacturer_Name" "Microchip")
		(attr "Manufacturer_Part_Number" "ATMEGA328PB-AU")
		(attr "Mouser Part Number" "556-ATMEGA328PB-AU")
		(attr "Mouser Price/Stock" "https://www.mouser.com/Search/Refine.aspx?Keyword=556-ATMEGA328PB-AU")
		(attr "RS Part Number" "1468928P")
		(attr "RS Price/Stock" "http://uk.rs-online.com/web/p/products/1468928P")
		(attr "Description" "ATMEL - ATMEGA328PB-AU - MCU, 8BIT, ATMEGA, 20MHZ, TQFP-32")
		(attr "<Hyperlink>" "http://www.farnell.com/datasheets/2014286.pdf")
		(attr "<Component Height>" "1.2")
		(attr "<STEP Filename>" "ATMEGA328PB-AU.stp")
		(attr "<STEP Offsets>" "X=0;Y=0;Z=0")
		(attr "<STEP Rotation>" "X=0;Y=0;Z=0")
	)

)
