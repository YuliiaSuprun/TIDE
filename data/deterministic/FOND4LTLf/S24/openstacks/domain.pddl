(define (domain grounded-STRIPS-OPENSTACKS-SEQUENCEDSTRIPS)
(:requirements :strips :typing)
(:types stack)
(:predicates
(machineconfiguredp1)
(machineconfiguredp2)
(machineconfiguredp3)
(machineconfiguredp4)
(machineconfiguredp5)
(stacksavailn1)
(startedo1)
(startedo2)
(startedo3)
(startedo4)
(startedo5)
(stacksavailn2)
(madep1)
(madep2)
(madep3)
(madep4)
(madep5)
(shippedo1)
(stacksavailn3)
(stacksavailn4)
(stacksavailn5)
(shippedo2)
(shippedo3)
(shippedo4)
(shippedo5)
(notmadep5)
(notmadep4)
(notmadep3)
(notmadep2)
(notmadep1)
(waitingo5)
(waitingo4)
(waitingo3)
(waitingo2)
(waitingo1)
(machineavailable)
(stacksavailn0)
)
(:action MAKE-PRODUCT-P5-N5
:parameters ()
:precondition
(and
(machineconfiguredp5)
(startedo4)
(startedo3)
(stacksavailn5)
)
:effect
(and
(madep5)
(machineavailable)
(not (notmadep5))
(not (machineconfiguredp5))
)
)
(:action MAKE-PRODUCT-P5-N4
:parameters ()
:precondition
(and
(machineconfiguredp5)
(startedo4)
(startedo3)
(stacksavailn4)
)
:effect
(and
(madep5)
(machineavailable)
(not (notmadep5))
(not (machineconfiguredp5))
)
)
(:action MAKE-PRODUCT-P5-N3
:parameters ()
:precondition
(and
(machineconfiguredp5)
(startedo4)
(startedo3)
(stacksavailn3)
)
:effect
(and
(madep5)
(machineavailable)
(not (notmadep5))
(not (machineconfiguredp5))
)
)
(:action MAKE-PRODUCT-P4-N5
:parameters ()
:precondition
(and
(machineconfiguredp4)
(startedo5)
(startedo2)
(stacksavailn5)
)
:effect
(and
(madep4)
(machineavailable)
(not (notmadep4))
(not (machineconfiguredp4))
)
)
(:action MAKE-PRODUCT-P4-N4
:parameters ()
:precondition
(and
(machineconfiguredp4)
(startedo5)
(startedo2)
(stacksavailn4)
)
:effect
(and
(madep4)
(machineavailable)
(not (notmadep4))
(not (machineconfiguredp4))
)
)
(:action MAKE-PRODUCT-P4-N3
:parameters ()
:precondition
(and
(machineconfiguredp4)
(startedo5)
(startedo2)
(stacksavailn3)
)
:effect
(and
(madep4)
(machineavailable)
(not (notmadep4))
(not (machineconfiguredp4))
)
)
(:action MAKE-PRODUCT-P3-N5
:parameters ()
:precondition
(and
(machineconfiguredp3)
(startedo4)
(startedo2)
(stacksavailn5)
)
:effect
(and
(madep3)
(machineavailable)
(not (notmadep3))
(not (machineconfiguredp3))
)
)
(:action MAKE-PRODUCT-P3-N4
:parameters ()
:precondition
(and
(machineconfiguredp3)
(startedo4)
(startedo2)
(stacksavailn4)
)
:effect
(and
(madep3)
(machineavailable)
(not (notmadep3))
(not (machineconfiguredp3))
)
)
(:action MAKE-PRODUCT-P3-N3
:parameters ()
:precondition
(and
(machineconfiguredp3)
(startedo4)
(startedo2)
(stacksavailn3)
)
:effect
(and
(madep3)
(machineavailable)
(not (notmadep3))
(not (machineconfiguredp3))
)
)
(:action MAKE-PRODUCT-P2-N5
:parameters ()
:precondition
(and
(machineconfiguredp2)
(startedo5)
(startedo1)
(stacksavailn5)
)
:effect
(and
(madep2)
(machineavailable)
(not (notmadep2))
(not (machineconfiguredp2))
)
)
(:action MAKE-PRODUCT-P2-N4
:parameters ()
:precondition
(and
(machineconfiguredp2)
(startedo5)
(startedo1)
(stacksavailn4)
)
:effect
(and
(madep2)
(machineavailable)
(not (notmadep2))
(not (machineconfiguredp2))
)
)
(:action MAKE-PRODUCT-P2-N3
:parameters ()
:precondition
(and
(machineconfiguredp2)
(startedo5)
(startedo1)
(stacksavailn3)
)
:effect
(and
(madep2)
(machineavailable)
(not (notmadep2))
(not (machineconfiguredp2))
)
)
(:action MAKE-PRODUCT-P1-N5
:parameters ()
:precondition
(and
(machineconfiguredp1)
(startedo3)
(startedo1)
(stacksavailn5)
)
:effect
(and
(madep1)
(machineavailable)
(not (notmadep1))
(not (machineconfiguredp1))
)
)
(:action MAKE-PRODUCT-P1-N4
:parameters ()
:precondition
(and
(machineconfiguredp1)
(startedo3)
(startedo1)
(stacksavailn4)
)
:effect
(and
(madep1)
(machineavailable)
(not (notmadep1))
(not (machineconfiguredp1))
)
)
(:action MAKE-PRODUCT-P1-N3
:parameters ()
:precondition
(and
(machineconfiguredp1)
(startedo3)
(startedo1)
(stacksavailn3)
)
:effect
(and
(madep1)
(machineavailable)
(not (notmadep1))
(not (machineconfiguredp1))
)
)
(:action OPEN-NEW-STACK-N2-N3
:parameters ()
:precondition
(and
(stacksavailn2)
)
:effect
(and
(stacksavailn3)
(not (stacksavailn2))
)
)
(:action OPEN-NEW-STACK-N3-N4
:parameters ()
:precondition
(and
(stacksavailn3)
)
:effect
(and
(stacksavailn4)
(not (stacksavailn3))
)
)
(:action OPEN-NEW-STACK-N4-N5
:parameters ()
:precondition
(and
(stacksavailn4)
)
:effect
(and
(stacksavailn5)
(not (stacksavailn4))
)
)
(:action START-ORDER-O5-N2-N1
:parameters ()
:precondition
(and
(stacksavailn2)
(waitingo5)
)
:effect
(and
(startedo5)
(stacksavailn1)
(not (waitingo5))
(not (stacksavailn2))
)
)
(:action START-ORDER-O4-N2-N1
:parameters ()
:precondition
(and
(stacksavailn2)
(waitingo4)
)
:effect
(and
(startedo4)
(stacksavailn1)
(not (waitingo4))
(not (stacksavailn2))
)
)
(:action START-ORDER-O3-N2-N1
:parameters ()
:precondition
(and
(stacksavailn2)
(waitingo3)
)
:effect
(and
(startedo3)
(stacksavailn1)
(not (waitingo3))
(not (stacksavailn2))
)
)
(:action START-ORDER-O2-N2-N1
:parameters ()
:precondition
(and
(stacksavailn2)
(waitingo2)
)
:effect
(and
(startedo2)
(stacksavailn1)
(not (waitingo2))
(not (stacksavailn2))
)
)
(:action START-ORDER-O1-N2-N1
:parameters ()
:precondition
(and
(stacksavailn2)
(waitingo1)
)
:effect
(and
(startedo1)
(stacksavailn1)
(not (waitingo1))
(not (stacksavailn2))
)
)
(:action START-ORDER-O5-N3-N2
:parameters ()
:precondition
(and
(stacksavailn3)
(waitingo5)
)
:effect
(and
(startedo5)
(stacksavailn2)
(not (waitingo5))
(not (stacksavailn3))
)
)
(:action START-ORDER-O4-N3-N2
:parameters ()
:precondition
(and
(stacksavailn3)
(waitingo4)
)
:effect
(and
(startedo4)
(stacksavailn2)
(not (waitingo4))
(not (stacksavailn3))
)
)
(:action START-ORDER-O3-N3-N2
:parameters ()
:precondition
(and
(stacksavailn3)
(waitingo3)
)
:effect
(and
(startedo3)
(stacksavailn2)
(not (waitingo3))
(not (stacksavailn3))
)
)
(:action START-ORDER-O2-N3-N2
:parameters ()
:precondition
(and
(stacksavailn3)
(waitingo2)
)
:effect
(and
(startedo2)
(stacksavailn2)
(not (waitingo2))
(not (stacksavailn3))
)
)
(:action START-ORDER-O1-N3-N2
:parameters ()
:precondition
(and
(stacksavailn3)
(waitingo1)
)
:effect
(and
(startedo1)
(stacksavailn2)
(not (waitingo1))
(not (stacksavailn3))
)
)
(:action START-ORDER-O5-N4-N3
:parameters ()
:precondition
(and
(stacksavailn4)
(waitingo5)
)
:effect
(and
(startedo5)
(stacksavailn3)
(not (waitingo5))
(not (stacksavailn4))
)
)
(:action START-ORDER-O4-N4-N3
:parameters ()
:precondition
(and
(stacksavailn4)
(waitingo4)
)
:effect
(and
(startedo4)
(stacksavailn3)
(not (waitingo4))
(not (stacksavailn4))
)
)
(:action START-ORDER-O3-N4-N3
:parameters ()
:precondition
(and
(stacksavailn4)
(waitingo3)
)
:effect
(and
(startedo3)
(stacksavailn3)
(not (waitingo3))
(not (stacksavailn4))
)
)
(:action START-ORDER-O2-N4-N3
:parameters ()
:precondition
(and
(stacksavailn4)
(waitingo2)
)
:effect
(and
(startedo2)
(stacksavailn3)
(not (waitingo2))
(not (stacksavailn4))
)
)
(:action START-ORDER-O1-N4-N3
:parameters ()
:precondition
(and
(stacksavailn4)
(waitingo1)
)
:effect
(and
(startedo1)
(stacksavailn3)
(not (waitingo1))
(not (stacksavailn4))
)
)
(:action START-ORDER-O5-N5-N4
:parameters ()
:precondition
(and
(stacksavailn5)
(waitingo5)
)
:effect
(and
(startedo5)
(stacksavailn4)
(not (waitingo5))
(not (stacksavailn5))
)
)
(:action START-ORDER-O4-N5-N4
:parameters ()
:precondition
(and
(stacksavailn5)
(waitingo4)
)
:effect
(and
(startedo4)
(stacksavailn4)
(not (waitingo4))
(not (stacksavailn5))
)
)
(:action START-ORDER-O3-N5-N4
:parameters ()
:precondition
(and
(stacksavailn5)
(waitingo3)
)
:effect
(and
(startedo3)
(stacksavailn4)
(not (waitingo3))
(not (stacksavailn5))
)
)
(:action START-ORDER-O2-N5-N4
:parameters ()
:precondition
(and
(stacksavailn5)
(waitingo2)
)
:effect
(and
(startedo2)
(stacksavailn4)
(not (waitingo2))
(not (stacksavailn5))
)
)
(:action START-ORDER-O1-N5-N4
:parameters ()
:precondition
(and
(stacksavailn5)
(waitingo1)
)
:effect
(and
(startedo1)
(stacksavailn4)
(not (waitingo1))
(not (stacksavailn5))
)
)
(:action SETUP-MACHINE-P5-N5
:parameters ()
:precondition
(and
(stacksavailn5)
(notmadep5)
(machineavailable)
)
:effect
(and
(machineconfiguredp5)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P5-N4
:parameters ()
:precondition
(and
(stacksavailn4)
(notmadep5)
(machineavailable)
)
:effect
(and
(machineconfiguredp5)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P5-N3
:parameters ()
:precondition
(and
(stacksavailn3)
(notmadep5)
(machineavailable)
)
:effect
(and
(machineconfiguredp5)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P5-N2
:parameters ()
:precondition
(and
(stacksavailn2)
(notmadep5)
(machineavailable)
)
:effect
(and
(machineconfiguredp5)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P4-N5
:parameters ()
:precondition
(and
(stacksavailn5)
(notmadep4)
(machineavailable)
)
:effect
(and
(machineconfiguredp4)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P4-N4
:parameters ()
:precondition
(and
(stacksavailn4)
(notmadep4)
(machineavailable)
)
:effect
(and
(machineconfiguredp4)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P4-N3
:parameters ()
:precondition
(and
(stacksavailn3)
(notmadep4)
(machineavailable)
)
:effect
(and
(machineconfiguredp4)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P4-N2
:parameters ()
:precondition
(and
(stacksavailn2)
(notmadep4)
(machineavailable)
)
:effect
(and
(machineconfiguredp4)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P3-N5
:parameters ()
:precondition
(and
(stacksavailn5)
(notmadep3)
(machineavailable)
)
:effect
(and
(machineconfiguredp3)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P3-N4
:parameters ()
:precondition
(and
(stacksavailn4)
(notmadep3)
(machineavailable)
)
:effect
(and
(machineconfiguredp3)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P3-N3
:parameters ()
:precondition
(and
(stacksavailn3)
(notmadep3)
(machineavailable)
)
:effect
(and
(machineconfiguredp3)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P3-N2
:parameters ()
:precondition
(and
(stacksavailn2)
(notmadep3)
(machineavailable)
)
:effect
(and
(machineconfiguredp3)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P2-N5
:parameters ()
:precondition
(and
(stacksavailn5)
(notmadep2)
(machineavailable)
)
:effect
(and
(machineconfiguredp2)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P2-N4
:parameters ()
:precondition
(and
(stacksavailn4)
(notmadep2)
(machineavailable)
)
:effect
(and
(machineconfiguredp2)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P2-N3
:parameters ()
:precondition
(and
(stacksavailn3)
(notmadep2)
(machineavailable)
)
:effect
(and
(machineconfiguredp2)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P2-N2
:parameters ()
:precondition
(and
(stacksavailn2)
(notmadep2)
(machineavailable)
)
:effect
(and
(machineconfiguredp2)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P1-N5
:parameters ()
:precondition
(and
(stacksavailn5)
(notmadep1)
(machineavailable)
)
:effect
(and
(machineconfiguredp1)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P1-N4
:parameters ()
:precondition
(and
(stacksavailn4)
(notmadep1)
(machineavailable)
)
:effect
(and
(machineconfiguredp1)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P1-N3
:parameters ()
:precondition
(and
(stacksavailn3)
(notmadep1)
(machineavailable)
)
:effect
(and
(machineconfiguredp1)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P1-N2
:parameters ()
:precondition
(and
(stacksavailn2)
(notmadep1)
(machineavailable)
)
:effect
(and
(machineconfiguredp1)
(not (machineavailable))
)
)
(:action SHIP-ORDER-O5-N4-N5
:parameters ()
:precondition
(and
(startedo5)
(madep4)
(madep2)
(stacksavailn4)
)
:effect
(and
(stacksavailn5)
(shippedo5)
(not (stacksavailn4))
(not (startedo5))
)
)
(:action SHIP-ORDER-O5-N3-N4
:parameters ()
:precondition
(and
(startedo5)
(madep4)
(madep2)
(stacksavailn3)
)
:effect
(and
(stacksavailn4)
(shippedo5)
(not (stacksavailn3))
(not (startedo5))
)
)
(:action SHIP-ORDER-O5-N2-N3
:parameters ()
:precondition
(and
(startedo5)
(madep4)
(madep2)
(stacksavailn2)
)
:effect
(and
(stacksavailn3)
(shippedo5)
(not (stacksavailn2))
(not (startedo5))
)
)
(:action SHIP-ORDER-O5-N1-N2
:parameters ()
:precondition
(and
(startedo5)
(madep4)
(madep2)
(stacksavailn1)
)
:effect
(and
(stacksavailn2)
(shippedo5)
(not (stacksavailn1))
(not (startedo5))
)
)
(:action SHIP-ORDER-O5-N0-N1
:parameters ()
:precondition
(and
(startedo5)
(madep4)
(madep2)
(stacksavailn0)
)
:effect
(and
(stacksavailn1)
(shippedo5)
(not (stacksavailn0))
(not (startedo5))
)
)
(:action SHIP-ORDER-O4-N4-N5
:parameters ()
:precondition
(and
(startedo4)
(madep5)
(madep3)
(stacksavailn4)
)
:effect
(and
(stacksavailn5)
(shippedo4)
(not (stacksavailn4))
(not (startedo4))
)
)
(:action SHIP-ORDER-O4-N3-N4
:parameters ()
:precondition
(and
(startedo4)
(madep5)
(madep3)
(stacksavailn3)
)
:effect
(and
(stacksavailn4)
(shippedo4)
(not (stacksavailn3))
(not (startedo4))
)
)
(:action SHIP-ORDER-O4-N2-N3
:parameters ()
:precondition
(and
(startedo4)
(madep5)
(madep3)
(stacksavailn2)
)
:effect
(and
(stacksavailn3)
(shippedo4)
(not (stacksavailn2))
(not (startedo4))
)
)
(:action SHIP-ORDER-O4-N1-N2
:parameters ()
:precondition
(and
(startedo4)
(madep5)
(madep3)
(stacksavailn1)
)
:effect
(and
(stacksavailn2)
(shippedo4)
(not (stacksavailn1))
(not (startedo4))
)
)
(:action SHIP-ORDER-O4-N0-N1
:parameters ()
:precondition
(and
(startedo4)
(madep5)
(madep3)
(stacksavailn0)
)
:effect
(and
(stacksavailn1)
(shippedo4)
(not (stacksavailn0))
(not (startedo4))
)
)
(:action SHIP-ORDER-O3-N4-N5
:parameters ()
:precondition
(and
(startedo3)
(madep5)
(madep1)
(stacksavailn4)
)
:effect
(and
(stacksavailn5)
(shippedo3)
(not (stacksavailn4))
(not (startedo3))
)
)
(:action SHIP-ORDER-O3-N3-N4
:parameters ()
:precondition
(and
(startedo3)
(madep5)
(madep1)
(stacksavailn3)
)
:effect
(and
(stacksavailn4)
(shippedo3)
(not (stacksavailn3))
(not (startedo3))
)
)
(:action SHIP-ORDER-O3-N2-N3
:parameters ()
:precondition
(and
(startedo3)
(madep5)
(madep1)
(stacksavailn2)
)
:effect
(and
(stacksavailn3)
(shippedo3)
(not (stacksavailn2))
(not (startedo3))
)
)
(:action SHIP-ORDER-O3-N1-N2
:parameters ()
:precondition
(and
(startedo3)
(madep5)
(madep1)
(stacksavailn1)
)
:effect
(and
(stacksavailn2)
(shippedo3)
(not (stacksavailn1))
(not (startedo3))
)
)
(:action SHIP-ORDER-O3-N0-N1
:parameters ()
:precondition
(and
(startedo3)
(madep5)
(madep1)
(stacksavailn0)
)
:effect
(and
(stacksavailn1)
(shippedo3)
(not (stacksavailn0))
(not (startedo3))
)
)
(:action SHIP-ORDER-O2-N4-N5
:parameters ()
:precondition
(and
(startedo2)
(madep4)
(madep3)
(stacksavailn4)
)
:effect
(and
(stacksavailn5)
(shippedo2)
(not (stacksavailn4))
(not (startedo2))
)
)
(:action SHIP-ORDER-O2-N3-N4
:parameters ()
:precondition
(and
(startedo2)
(madep4)
(madep3)
(stacksavailn3)
)
:effect
(and
(stacksavailn4)
(shippedo2)
(not (stacksavailn3))
(not (startedo2))
)
)
(:action SHIP-ORDER-O2-N2-N3
:parameters ()
:precondition
(and
(startedo2)
(madep4)
(madep3)
(stacksavailn2)
)
:effect
(and
(stacksavailn3)
(shippedo2)
(not (stacksavailn2))
(not (startedo2))
)
)
(:action SHIP-ORDER-O2-N1-N2
:parameters ()
:precondition
(and
(startedo2)
(madep4)
(madep3)
(stacksavailn1)
)
:effect
(and
(stacksavailn2)
(shippedo2)
(not (stacksavailn1))
(not (startedo2))
)
)
(:action SHIP-ORDER-O2-N0-N1
:parameters ()
:precondition
(and
(startedo2)
(madep4)
(madep3)
(stacksavailn0)
)
:effect
(and
(stacksavailn1)
(shippedo2)
(not (stacksavailn0))
(not (startedo2))
)
)
(:action SHIP-ORDER-O1-N4-N5
:parameters ()
:precondition
(and
(startedo1)
(madep2)
(madep1)
(stacksavailn4)
)
:effect
(and
(stacksavailn5)
(shippedo1)
(not (stacksavailn4))
(not (startedo1))
)
)
(:action SHIP-ORDER-O1-N3-N4
:parameters ()
:precondition
(and
(startedo1)
(madep2)
(madep1)
(stacksavailn3)
)
:effect
(and
(stacksavailn4)
(shippedo1)
(not (stacksavailn3))
(not (startedo1))
)
)
(:action SHIP-ORDER-O1-N2-N3
:parameters ()
:precondition
(and
(startedo1)
(madep2)
(madep1)
(stacksavailn2)
)
:effect
(and
(stacksavailn3)
(shippedo1)
(not (stacksavailn2))
(not (startedo1))
)
)
(:action SHIP-ORDER-O1-N1-N2
:parameters ()
:precondition
(and
(startedo1)
(madep2)
(madep1)
(stacksavailn1)
)
:effect
(and
(stacksavailn2)
(shippedo1)
(not (stacksavailn1))
(not (startedo1))
)
)
(:action SHIP-ORDER-O1-N0-N1
:parameters ()
:precondition
(and
(startedo1)
(madep2)
(madep1)
(stacksavailn0)
)
:effect
(and
(stacksavailn1)
(shippedo1)
(not (stacksavailn0))
(not (startedo1))
)
)
(:action MAKE-PRODUCT-P5-N2
:parameters ()
:precondition
(and
(machineconfiguredp5)
(startedo4)
(startedo3)
(stacksavailn2)
)
:effect
(and
(madep5)
(machineavailable)
(not (notmadep5))
(not (machineconfiguredp5))
)
)
(:action MAKE-PRODUCT-P5-N1
:parameters ()
:precondition
(and
(machineconfiguredp5)
(startedo4)
(startedo3)
(stacksavailn1)
)
:effect
(and
(madep5)
(machineavailable)
(not (notmadep5))
(not (machineconfiguredp5))
)
)
(:action MAKE-PRODUCT-P5-N0
:parameters ()
:precondition
(and
(machineconfiguredp5)
(startedo4)
(startedo3)
(stacksavailn0)
)
:effect
(and
(madep5)
(machineavailable)
(not (notmadep5))
(not (machineconfiguredp5))
)
)
(:action MAKE-PRODUCT-P4-N2
:parameters ()
:precondition
(and
(machineconfiguredp4)
(startedo5)
(startedo2)
(stacksavailn2)
)
:effect
(and
(madep4)
(machineavailable)
(not (notmadep4))
(not (machineconfiguredp4))
)
)
(:action MAKE-PRODUCT-P4-N1
:parameters ()
:precondition
(and
(machineconfiguredp4)
(startedo5)
(startedo2)
(stacksavailn1)
)
:effect
(and
(madep4)
(machineavailable)
(not (notmadep4))
(not (machineconfiguredp4))
)
)
(:action MAKE-PRODUCT-P4-N0
:parameters ()
:precondition
(and
(machineconfiguredp4)
(startedo5)
(startedo2)
(stacksavailn0)
)
:effect
(and
(madep4)
(machineavailable)
(not (notmadep4))
(not (machineconfiguredp4))
)
)
(:action MAKE-PRODUCT-P3-N2
:parameters ()
:precondition
(and
(machineconfiguredp3)
(startedo4)
(startedo2)
(stacksavailn2)
)
:effect
(and
(madep3)
(machineavailable)
(not (notmadep3))
(not (machineconfiguredp3))
)
)
(:action MAKE-PRODUCT-P3-N1
:parameters ()
:precondition
(and
(machineconfiguredp3)
(startedo4)
(startedo2)
(stacksavailn1)
)
:effect
(and
(madep3)
(machineavailable)
(not (notmadep3))
(not (machineconfiguredp3))
)
)
(:action MAKE-PRODUCT-P3-N0
:parameters ()
:precondition
(and
(machineconfiguredp3)
(startedo4)
(startedo2)
(stacksavailn0)
)
:effect
(and
(madep3)
(machineavailable)
(not (notmadep3))
(not (machineconfiguredp3))
)
)
(:action MAKE-PRODUCT-P2-N2
:parameters ()
:precondition
(and
(machineconfiguredp2)
(startedo5)
(startedo1)
(stacksavailn2)
)
:effect
(and
(madep2)
(machineavailable)
(not (notmadep2))
(not (machineconfiguredp2))
)
)
(:action MAKE-PRODUCT-P2-N1
:parameters ()
:precondition
(and
(machineconfiguredp2)
(startedo5)
(startedo1)
(stacksavailn1)
)
:effect
(and
(madep2)
(machineavailable)
(not (notmadep2))
(not (machineconfiguredp2))
)
)
(:action MAKE-PRODUCT-P2-N0
:parameters ()
:precondition
(and
(machineconfiguredp2)
(startedo5)
(startedo1)
(stacksavailn0)
)
:effect
(and
(madep2)
(machineavailable)
(not (notmadep2))
(not (machineconfiguredp2))
)
)
(:action MAKE-PRODUCT-P1-N2
:parameters ()
:precondition
(and
(machineconfiguredp1)
(startedo3)
(startedo1)
(stacksavailn2)
)
:effect
(and
(madep1)
(machineavailable)
(not (notmadep1))
(not (machineconfiguredp1))
)
)
(:action MAKE-PRODUCT-P1-N1
:parameters ()
:precondition
(and
(machineconfiguredp1)
(startedo3)
(startedo1)
(stacksavailn1)
)
:effect
(and
(madep1)
(machineavailable)
(not (notmadep1))
(not (machineconfiguredp1))
)
)
(:action MAKE-PRODUCT-P1-N0
:parameters ()
:precondition
(and
(machineconfiguredp1)
(startedo3)
(startedo1)
(stacksavailn0)
)
:effect
(and
(madep1)
(machineavailable)
(not (notmadep1))
(not (machineconfiguredp1))
)
)
(:action OPEN-NEW-STACK-N1-N2
:parameters ()
:precondition
(and
(stacksavailn1)
)
:effect
(and
(stacksavailn2)
(not (stacksavailn1))
)
)
(:action START-ORDER-O5-N1-N0
:parameters ()
:precondition
(and
(stacksavailn1)
(waitingo5)
)
:effect
(and
(startedo5)
(stacksavailn0)
(not (waitingo5))
(not (stacksavailn1))
)
)
(:action START-ORDER-O4-N1-N0
:parameters ()
:precondition
(and
(stacksavailn1)
(waitingo4)
)
:effect
(and
(startedo4)
(stacksavailn0)
(not (waitingo4))
(not (stacksavailn1))
)
)
(:action START-ORDER-O3-N1-N0
:parameters ()
:precondition
(and
(stacksavailn1)
(waitingo3)
)
:effect
(and
(startedo3)
(stacksavailn0)
(not (waitingo3))
(not (stacksavailn1))
)
)
(:action START-ORDER-O2-N1-N0
:parameters ()
:precondition
(and
(stacksavailn1)
(waitingo2)
)
:effect
(and
(startedo2)
(stacksavailn0)
(not (waitingo2))
(not (stacksavailn1))
)
)
(:action START-ORDER-O1-N1-N0
:parameters ()
:precondition
(and
(stacksavailn1)
(waitingo1)
)
:effect
(and
(startedo1)
(stacksavailn0)
(not (waitingo1))
(not (stacksavailn1))
)
)
(:action SETUP-MACHINE-P5-N1
:parameters ()
:precondition
(and
(stacksavailn1)
(notmadep5)
(machineavailable)
)
:effect
(and
(machineconfiguredp5)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P4-N1
:parameters ()
:precondition
(and
(stacksavailn1)
(notmadep4)
(machineavailable)
)
:effect
(and
(machineconfiguredp4)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P3-N1
:parameters ()
:precondition
(and
(stacksavailn1)
(notmadep3)
(machineavailable)
)
:effect
(and
(machineconfiguredp3)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P2-N1
:parameters ()
:precondition
(and
(stacksavailn1)
(notmadep2)
(machineavailable)
)
:effect
(and
(machineconfiguredp2)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P1-N1
:parameters ()
:precondition
(and
(stacksavailn1)
(notmadep1)
(machineavailable)
)
:effect
(and
(machineconfiguredp1)
(not (machineavailable))
)
)
(:action OPEN-NEW-STACK-N0-N1
:parameters ()
:precondition
(and
(stacksavailn0)
)
:effect
(and
(stacksavailn1)
(not (stacksavailn0))
)
)
(:action SETUP-MACHINE-P5-N0
:parameters ()
:precondition
(and
(stacksavailn0)
(notmadep5)
(machineavailable)
)
:effect
(and
(machineconfiguredp5)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P4-N0
:parameters ()
:precondition
(and
(stacksavailn0)
(notmadep4)
(machineavailable)
)
:effect
(and
(machineconfiguredp4)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P3-N0
:parameters ()
:precondition
(and
(stacksavailn0)
(notmadep3)
(machineavailable)
)
:effect
(and
(machineconfiguredp3)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P2-N0
:parameters ()
:precondition
(and
(stacksavailn0)
(notmadep2)
(machineavailable)
)
:effect
(and
(machineconfiguredp2)
(not (machineavailable))
)
)
(:action SETUP-MACHINE-P1-N0
:parameters ()
:precondition
(and
(stacksavailn0)
(notmadep1)
(machineavailable)
)
:effect
(and
(machineconfiguredp1)
(not (machineavailable))
)
)
)
