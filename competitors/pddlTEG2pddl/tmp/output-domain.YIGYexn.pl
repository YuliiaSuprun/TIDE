:- dynamic domain_name/1.

domain_name('grounded-strips-openstacks-sequencedstrips').

:- dynamic is_subtype/2.


:- dynamic fluent/1.

fluent('machine-configured-p1').
fluent('machine-configured-p2').
fluent('machine-configured-p3').
fluent('machine-configured-p4').
fluent('machine-configured-p5').
fluent('stacks-avail-n1').
fluent('started-o1').
fluent('started-o2').
fluent('started-o3').
fluent('started-o4').
fluent('started-o5').
fluent('stacks-avail-n2').
fluent('made-p1').
fluent('made-p2').
fluent('made-p3').
fluent('made-p4').
fluent('made-p5').
fluent('shipped-o1').
fluent('stacks-avail-n3').
fluent('stacks-avail-n4').
fluent('stacks-avail-n5').
fluent('shipped-o2').
fluent('shipped-o3').
fluent('shipped-o4').
fluent('shipped-o5').
fluent('not-made-p5').
fluent('not-made-p4').
fluent('not-made-p3').
fluent('not-made-p2').
fluent('not-made-p1').
fluent('waiting-o5').
fluent('waiting-o4').
fluent('waiting-o3').
fluent('waiting-o2').
fluent('waiting-o1').
fluent('machine-available').
fluent('stacks-avail-n0').

:- dynamic fluent_args/2.

fluent_args('machine-configured-p1', []).
fluent_args('machine-configured-p2', []).
fluent_args('machine-configured-p3', []).
fluent_args('machine-configured-p4', []).
fluent_args('machine-configured-p5', []).
fluent_args('stacks-avail-n1', []).
fluent_args('started-o1', []).
fluent_args('started-o2', []).
fluent_args('started-o3', []).
fluent_args('started-o4', []).
fluent_args('started-o5', []).
fluent_args('stacks-avail-n2', []).
fluent_args('made-p1', []).
fluent_args('made-p2', []).
fluent_args('made-p3', []).
fluent_args('made-p4', []).
fluent_args('made-p5', []).
fluent_args('shipped-o1', []).
fluent_args('stacks-avail-n3', []).
fluent_args('stacks-avail-n4', []).
fluent_args('stacks-avail-n5', []).
fluent_args('shipped-o2', []).
fluent_args('shipped-o3', []).
fluent_args('shipped-o4', []).
fluent_args('shipped-o5', []).
fluent_args('not-made-p5', []).
fluent_args('not-made-p4', []).
fluent_args('not-made-p3', []).
fluent_args('not-made-p2', []).
fluent_args('not-made-p1', []).
fluent_args('waiting-o5', []).
fluent_args('waiting-o4', []).
fluent_args('waiting-o3', []).
fluent_args('waiting-o2', []).
fluent_args('waiting-o1', []).
fluent_args('machine-available', []).
fluent_args('stacks-avail-n0', []).

:- dynamic action/1.

action('make-product-p5-n5').
action('make-product-p5-n4').
action('make-product-p5-n3').
action('make-product-p4-n5').
action('make-product-p4-n4').
action('make-product-p4-n3').
action('make-product-p3-n5').
action('make-product-p3-n4').
action('make-product-p3-n3').
action('make-product-p2-n5').
action('make-product-p2-n4').
action('make-product-p2-n3').
action('make-product-p1-n5').
action('make-product-p1-n4').
action('make-product-p1-n3').
action('open-new-stack-n2-n3').
action('open-new-stack-n3-n4').
action('open-new-stack-n4-n5').
action('start-order-o5-n2-n1').
action('start-order-o4-n2-n1').
action('start-order-o3-n2-n1').
action('start-order-o2-n2-n1').
action('start-order-o1-n2-n1').
action('start-order-o5-n3-n2').
action('start-order-o4-n3-n2').
action('start-order-o3-n3-n2').
action('start-order-o2-n3-n2').
action('start-order-o1-n3-n2').
action('start-order-o5-n4-n3').
action('start-order-o4-n4-n3').
action('start-order-o3-n4-n3').
action('start-order-o2-n4-n3').
action('start-order-o1-n4-n3').
action('start-order-o5-n5-n4').
action('start-order-o4-n5-n4').
action('start-order-o3-n5-n4').
action('start-order-o2-n5-n4').
action('start-order-o1-n5-n4').
action('setup-machine-p5-n5').
action('setup-machine-p5-n4').
action('setup-machine-p5-n3').
action('setup-machine-p5-n2').
action('setup-machine-p4-n5').
action('setup-machine-p4-n4').
action('setup-machine-p4-n3').
action('setup-machine-p4-n2').
action('setup-machine-p3-n5').
action('setup-machine-p3-n4').
action('setup-machine-p3-n3').
action('setup-machine-p3-n2').
action('setup-machine-p2-n5').
action('setup-machine-p2-n4').
action('setup-machine-p2-n3').
action('setup-machine-p2-n2').
action('setup-machine-p1-n5').
action('setup-machine-p1-n4').
action('setup-machine-p1-n3').
action('setup-machine-p1-n2').
action('ship-order-o5-n4-n5').
action('ship-order-o5-n3-n4').
action('ship-order-o5-n2-n3').
action('ship-order-o5-n1-n2').
action('ship-order-o5-n0-n1').
action('ship-order-o4-n4-n5').
action('ship-order-o4-n3-n4').
action('ship-order-o4-n2-n3').
action('ship-order-o4-n1-n2').
action('ship-order-o4-n0-n1').
action('ship-order-o3-n4-n5').
action('ship-order-o3-n3-n4').
action('ship-order-o3-n2-n3').
action('ship-order-o3-n1-n2').
action('ship-order-o3-n0-n1').
action('ship-order-o2-n4-n5').
action('ship-order-o2-n3-n4').
action('ship-order-o2-n2-n3').
action('ship-order-o2-n1-n2').
action('ship-order-o2-n0-n1').
action('ship-order-o1-n4-n5').
action('ship-order-o1-n3-n4').
action('ship-order-o1-n2-n3').
action('ship-order-o1-n1-n2').
action('ship-order-o1-n0-n1').
action('make-product-p5-n2').
action('make-product-p5-n1').
action('make-product-p5-n0').
action('make-product-p4-n2').
action('make-product-p4-n1').
action('make-product-p4-n0').
action('make-product-p3-n2').
action('make-product-p3-n1').
action('make-product-p3-n0').
action('make-product-p2-n2').
action('make-product-p2-n1').
action('make-product-p2-n0').
action('make-product-p1-n2').
action('make-product-p1-n1').
action('make-product-p1-n0').
action('open-new-stack-n1-n2').
action('start-order-o5-n1-n0').
action('start-order-o4-n1-n0').
action('start-order-o3-n1-n0').
action('start-order-o2-n1-n0').
action('start-order-o1-n1-n0').
action('setup-machine-p5-n1').
action('setup-machine-p4-n1').
action('setup-machine-p3-n1').
action('setup-machine-p2-n1').
action('setup-machine-p1-n1').
action('open-new-stack-n0-n1').
action('setup-machine-p5-n0').
action('setup-machine-p4-n0').
action('setup-machine-p3-n0').
action('setup-machine-p2-n0').
action('setup-machine-p1-n0').

:- dynamic action_args/2.

action_args('make-product-p5-n5', []).
action_args('make-product-p5-n4', []).
action_args('make-product-p5-n3', []).
action_args('make-product-p4-n5', []).
action_args('make-product-p4-n4', []).
action_args('make-product-p4-n3', []).
action_args('make-product-p3-n5', []).
action_args('make-product-p3-n4', []).
action_args('make-product-p3-n3', []).
action_args('make-product-p2-n5', []).
action_args('make-product-p2-n4', []).
action_args('make-product-p2-n3', []).
action_args('make-product-p1-n5', []).
action_args('make-product-p1-n4', []).
action_args('make-product-p1-n3', []).
action_args('open-new-stack-n2-n3', []).
action_args('open-new-stack-n3-n4', []).
action_args('open-new-stack-n4-n5', []).
action_args('start-order-o5-n2-n1', []).
action_args('start-order-o4-n2-n1', []).
action_args('start-order-o3-n2-n1', []).
action_args('start-order-o2-n2-n1', []).
action_args('start-order-o1-n2-n1', []).
action_args('start-order-o5-n3-n2', []).
action_args('start-order-o4-n3-n2', []).
action_args('start-order-o3-n3-n2', []).
action_args('start-order-o2-n3-n2', []).
action_args('start-order-o1-n3-n2', []).
action_args('start-order-o5-n4-n3', []).
action_args('start-order-o4-n4-n3', []).
action_args('start-order-o3-n4-n3', []).
action_args('start-order-o2-n4-n3', []).
action_args('start-order-o1-n4-n3', []).
action_args('start-order-o5-n5-n4', []).
action_args('start-order-o4-n5-n4', []).
action_args('start-order-o3-n5-n4', []).
action_args('start-order-o2-n5-n4', []).
action_args('start-order-o1-n5-n4', []).
action_args('setup-machine-p5-n5', []).
action_args('setup-machine-p5-n4', []).
action_args('setup-machine-p5-n3', []).
action_args('setup-machine-p5-n2', []).
action_args('setup-machine-p4-n5', []).
action_args('setup-machine-p4-n4', []).
action_args('setup-machine-p4-n3', []).
action_args('setup-machine-p4-n2', []).
action_args('setup-machine-p3-n5', []).
action_args('setup-machine-p3-n4', []).
action_args('setup-machine-p3-n3', []).
action_args('setup-machine-p3-n2', []).
action_args('setup-machine-p2-n5', []).
action_args('setup-machine-p2-n4', []).
action_args('setup-machine-p2-n3', []).
action_args('setup-machine-p2-n2', []).
action_args('setup-machine-p1-n5', []).
action_args('setup-machine-p1-n4', []).
action_args('setup-machine-p1-n3', []).
action_args('setup-machine-p1-n2', []).
action_args('ship-order-o5-n4-n5', []).
action_args('ship-order-o5-n3-n4', []).
action_args('ship-order-o5-n2-n3', []).
action_args('ship-order-o5-n1-n2', []).
action_args('ship-order-o5-n0-n1', []).
action_args('ship-order-o4-n4-n5', []).
action_args('ship-order-o4-n3-n4', []).
action_args('ship-order-o4-n2-n3', []).
action_args('ship-order-o4-n1-n2', []).
action_args('ship-order-o4-n0-n1', []).
action_args('ship-order-o3-n4-n5', []).
action_args('ship-order-o3-n3-n4', []).
action_args('ship-order-o3-n2-n3', []).
action_args('ship-order-o3-n1-n2', []).
action_args('ship-order-o3-n0-n1', []).
action_args('ship-order-o2-n4-n5', []).
action_args('ship-order-o2-n3-n4', []).
action_args('ship-order-o2-n2-n3', []).
action_args('ship-order-o2-n1-n2', []).
action_args('ship-order-o2-n0-n1', []).
action_args('ship-order-o1-n4-n5', []).
action_args('ship-order-o1-n3-n4', []).
action_args('ship-order-o1-n2-n3', []).
action_args('ship-order-o1-n1-n2', []).
action_args('ship-order-o1-n0-n1', []).
action_args('make-product-p5-n2', []).
action_args('make-product-p5-n1', []).
action_args('make-product-p5-n0', []).
action_args('make-product-p4-n2', []).
action_args('make-product-p4-n1', []).
action_args('make-product-p4-n0', []).
action_args('make-product-p3-n2', []).
action_args('make-product-p3-n1', []).
action_args('make-product-p3-n0', []).
action_args('make-product-p2-n2', []).
action_args('make-product-p2-n1', []).
action_args('make-product-p2-n0', []).
action_args('make-product-p1-n2', []).
action_args('make-product-p1-n1', []).
action_args('make-product-p1-n0', []).
action_args('open-new-stack-n1-n2', []).
action_args('start-order-o5-n1-n0', []).
action_args('start-order-o4-n1-n0', []).
action_args('start-order-o3-n1-n0', []).
action_args('start-order-o2-n1-n0', []).
action_args('start-order-o1-n1-n0', []).
action_args('setup-machine-p5-n1', []).
action_args('setup-machine-p4-n1', []).
action_args('setup-machine-p3-n1', []).
action_args('setup-machine-p2-n1', []).
action_args('setup-machine-p1-n1', []).
action_args('open-new-stack-n0-n1', []).
action_args('setup-machine-p5-n0', []).
action_args('setup-machine-p4-n0', []).
action_args('setup-machine-p3-n0', []).
action_args('setup-machine-p2-n0', []).
action_args('setup-machine-p1-n0', []).

:- dynamic poss/2.

poss('make-product-p5-n5', and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n5')))).
poss('make-product-p5-n4', and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n4')))).
poss('make-product-p5-n3', and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n3')))).
poss('make-product-p4-n5', and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n5')))).
poss('make-product-p4-n4', and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n4')))).
poss('make-product-p4-n3', and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n3')))).
poss('make-product-p3-n5', and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n5')))).
poss('make-product-p3-n4', and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n4')))).
poss('make-product-p3-n3', and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n3')))).
poss('make-product-p2-n5', and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n5')))).
poss('make-product-p2-n4', and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n4')))).
poss('make-product-p2-n3', and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n3')))).
poss('make-product-p1-n5', and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n5')))).
poss('make-product-p1-n4', and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n4')))).
poss('make-product-p1-n3', and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n3')))).
poss('open-new-stack-n2-n3', 'stacks-avail-n2').
poss('open-new-stack-n3-n4', 'stacks-avail-n3').
poss('open-new-stack-n4-n5', 'stacks-avail-n4').
poss('start-order-o5-n2-n1', and('stacks-avail-n2', 'waiting-o5')).
poss('start-order-o4-n2-n1', and('stacks-avail-n2', 'waiting-o4')).
poss('start-order-o3-n2-n1', and('stacks-avail-n2', 'waiting-o3')).
poss('start-order-o2-n2-n1', and('stacks-avail-n2', 'waiting-o2')).
poss('start-order-o1-n2-n1', and('stacks-avail-n2', 'waiting-o1')).
poss('start-order-o5-n3-n2', and('stacks-avail-n3', 'waiting-o5')).
poss('start-order-o4-n3-n2', and('stacks-avail-n3', 'waiting-o4')).
poss('start-order-o3-n3-n2', and('stacks-avail-n3', 'waiting-o3')).
poss('start-order-o2-n3-n2', and('stacks-avail-n3', 'waiting-o2')).
poss('start-order-o1-n3-n2', and('stacks-avail-n3', 'waiting-o1')).
poss('start-order-o5-n4-n3', and('stacks-avail-n4', 'waiting-o5')).
poss('start-order-o4-n4-n3', and('stacks-avail-n4', 'waiting-o4')).
poss('start-order-o3-n4-n3', and('stacks-avail-n4', 'waiting-o3')).
poss('start-order-o2-n4-n3', and('stacks-avail-n4', 'waiting-o2')).
poss('start-order-o1-n4-n3', and('stacks-avail-n4', 'waiting-o1')).
poss('start-order-o5-n5-n4', and('stacks-avail-n5', 'waiting-o5')).
poss('start-order-o4-n5-n4', and('stacks-avail-n5', 'waiting-o4')).
poss('start-order-o3-n5-n4', and('stacks-avail-n5', 'waiting-o3')).
poss('start-order-o2-n5-n4', and('stacks-avail-n5', 'waiting-o2')).
poss('start-order-o1-n5-n4', and('stacks-avail-n5', 'waiting-o1')).
poss('setup-machine-p5-n5', and('stacks-avail-n5', and('not-made-p5', 'machine-available'))).
poss('setup-machine-p5-n4', and('stacks-avail-n4', and('not-made-p5', 'machine-available'))).
poss('setup-machine-p5-n3', and('stacks-avail-n3', and('not-made-p5', 'machine-available'))).
poss('setup-machine-p5-n2', and('stacks-avail-n2', and('not-made-p5', 'machine-available'))).
poss('setup-machine-p4-n5', and('stacks-avail-n5', and('not-made-p4', 'machine-available'))).
poss('setup-machine-p4-n4', and('stacks-avail-n4', and('not-made-p4', 'machine-available'))).
poss('setup-machine-p4-n3', and('stacks-avail-n3', and('not-made-p4', 'machine-available'))).
poss('setup-machine-p4-n2', and('stacks-avail-n2', and('not-made-p4', 'machine-available'))).
poss('setup-machine-p3-n5', and('stacks-avail-n5', and('not-made-p3', 'machine-available'))).
poss('setup-machine-p3-n4', and('stacks-avail-n4', and('not-made-p3', 'machine-available'))).
poss('setup-machine-p3-n3', and('stacks-avail-n3', and('not-made-p3', 'machine-available'))).
poss('setup-machine-p3-n2', and('stacks-avail-n2', and('not-made-p3', 'machine-available'))).
poss('setup-machine-p2-n5', and('stacks-avail-n5', and('not-made-p2', 'machine-available'))).
poss('setup-machine-p2-n4', and('stacks-avail-n4', and('not-made-p2', 'machine-available'))).
poss('setup-machine-p2-n3', and('stacks-avail-n3', and('not-made-p2', 'machine-available'))).
poss('setup-machine-p2-n2', and('stacks-avail-n2', and('not-made-p2', 'machine-available'))).
poss('setup-machine-p1-n5', and('stacks-avail-n5', and('not-made-p1', 'machine-available'))).
poss('setup-machine-p1-n4', and('stacks-avail-n4', and('not-made-p1', 'machine-available'))).
poss('setup-machine-p1-n3', and('stacks-avail-n3', and('not-made-p1', 'machine-available'))).
poss('setup-machine-p1-n2', and('stacks-avail-n2', and('not-made-p1', 'machine-available'))).
poss('ship-order-o5-n4-n5', and('started-o5', and('made-p4', and('made-p2', 'stacks-avail-n4')))).
poss('ship-order-o5-n3-n4', and('started-o5', and('made-p4', and('made-p2', 'stacks-avail-n3')))).
poss('ship-order-o5-n2-n3', and('started-o5', and('made-p4', and('made-p2', 'stacks-avail-n2')))).
poss('ship-order-o5-n1-n2', and('started-o5', and('made-p4', and('made-p2', 'stacks-avail-n1')))).
poss('ship-order-o5-n0-n1', and('started-o5', and('made-p4', and('made-p2', 'stacks-avail-n0')))).
poss('ship-order-o4-n4-n5', and('started-o4', and('made-p5', and('made-p3', 'stacks-avail-n4')))).
poss('ship-order-o4-n3-n4', and('started-o4', and('made-p5', and('made-p3', 'stacks-avail-n3')))).
poss('ship-order-o4-n2-n3', and('started-o4', and('made-p5', and('made-p3', 'stacks-avail-n2')))).
poss('ship-order-o4-n1-n2', and('started-o4', and('made-p5', and('made-p3', 'stacks-avail-n1')))).
poss('ship-order-o4-n0-n1', and('started-o4', and('made-p5', and('made-p3', 'stacks-avail-n0')))).
poss('ship-order-o3-n4-n5', and('started-o3', and('made-p5', and('made-p1', 'stacks-avail-n4')))).
poss('ship-order-o3-n3-n4', and('started-o3', and('made-p5', and('made-p1', 'stacks-avail-n3')))).
poss('ship-order-o3-n2-n3', and('started-o3', and('made-p5', and('made-p1', 'stacks-avail-n2')))).
poss('ship-order-o3-n1-n2', and('started-o3', and('made-p5', and('made-p1', 'stacks-avail-n1')))).
poss('ship-order-o3-n0-n1', and('started-o3', and('made-p5', and('made-p1', 'stacks-avail-n0')))).
poss('ship-order-o2-n4-n5', and('started-o2', and('made-p4', and('made-p3', 'stacks-avail-n4')))).
poss('ship-order-o2-n3-n4', and('started-o2', and('made-p4', and('made-p3', 'stacks-avail-n3')))).
poss('ship-order-o2-n2-n3', and('started-o2', and('made-p4', and('made-p3', 'stacks-avail-n2')))).
poss('ship-order-o2-n1-n2', and('started-o2', and('made-p4', and('made-p3', 'stacks-avail-n1')))).
poss('ship-order-o2-n0-n1', and('started-o2', and('made-p4', and('made-p3', 'stacks-avail-n0')))).
poss('ship-order-o1-n4-n5', and('started-o1', and('made-p2', and('made-p1', 'stacks-avail-n4')))).
poss('ship-order-o1-n3-n4', and('started-o1', and('made-p2', and('made-p1', 'stacks-avail-n3')))).
poss('ship-order-o1-n2-n3', and('started-o1', and('made-p2', and('made-p1', 'stacks-avail-n2')))).
poss('ship-order-o1-n1-n2', and('started-o1', and('made-p2', and('made-p1', 'stacks-avail-n1')))).
poss('ship-order-o1-n0-n1', and('started-o1', and('made-p2', and('made-p1', 'stacks-avail-n0')))).
poss('make-product-p5-n2', and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n2')))).
poss('make-product-p5-n1', and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n1')))).
poss('make-product-p5-n0', and('machine-configured-p5', and('started-o4', and('started-o3', 'stacks-avail-n0')))).
poss('make-product-p4-n2', and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n2')))).
poss('make-product-p4-n1', and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n1')))).
poss('make-product-p4-n0', and('machine-configured-p4', and('started-o5', and('started-o2', 'stacks-avail-n0')))).
poss('make-product-p3-n2', and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n2')))).
poss('make-product-p3-n1', and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n1')))).
poss('make-product-p3-n0', and('machine-configured-p3', and('started-o4', and('started-o2', 'stacks-avail-n0')))).
poss('make-product-p2-n2', and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n2')))).
poss('make-product-p2-n1', and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n1')))).
poss('make-product-p2-n0', and('machine-configured-p2', and('started-o5', and('started-o1', 'stacks-avail-n0')))).
poss('make-product-p1-n2', and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n2')))).
poss('make-product-p1-n1', and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n1')))).
poss('make-product-p1-n0', and('machine-configured-p1', and('started-o3', and('started-o1', 'stacks-avail-n0')))).
poss('open-new-stack-n1-n2', 'stacks-avail-n1').
poss('start-order-o5-n1-n0', and('stacks-avail-n1', 'waiting-o5')).
poss('start-order-o4-n1-n0', and('stacks-avail-n1', 'waiting-o4')).
poss('start-order-o3-n1-n0', and('stacks-avail-n1', 'waiting-o3')).
poss('start-order-o2-n1-n0', and('stacks-avail-n1', 'waiting-o2')).
poss('start-order-o1-n1-n0', and('stacks-avail-n1', 'waiting-o1')).
poss('setup-machine-p5-n1', and('stacks-avail-n1', and('not-made-p5', 'machine-available'))).
poss('setup-machine-p4-n1', and('stacks-avail-n1', and('not-made-p4', 'machine-available'))).
poss('setup-machine-p3-n1', and('stacks-avail-n1', and('not-made-p3', 'machine-available'))).
poss('setup-machine-p2-n1', and('stacks-avail-n1', and('not-made-p2', 'machine-available'))).
poss('setup-machine-p1-n1', and('stacks-avail-n1', and('not-made-p1', 'machine-available'))).
poss('open-new-stack-n0-n1', 'stacks-avail-n0').
poss('setup-machine-p5-n0', and('stacks-avail-n0', and('not-made-p5', 'machine-available'))).
poss('setup-machine-p4-n0', and('stacks-avail-n0', and('not-made-p4', 'machine-available'))).
poss('setup-machine-p3-n0', and('stacks-avail-n0', and('not-made-p3', 'machine-available'))).
poss('setup-machine-p2-n0', and('stacks-avail-n0', and('not-made-p2', 'machine-available'))).
poss('setup-machine-p1-n0', and('stacks-avail-n0', and('not-made-p1', 'machine-available'))).

:- dynamic causes_true/3.

causes_true('made-p5', 'make-product-p5-n5', true).
causes_true('machine-available', 'make-product-p5-n5', true).
causes_true('made-p5', 'make-product-p5-n4', true).
causes_true('machine-available', 'make-product-p5-n4', true).
causes_true('made-p5', 'make-product-p5-n3', true).
causes_true('machine-available', 'make-product-p5-n3', true).
causes_true('made-p4', 'make-product-p4-n5', true).
causes_true('machine-available', 'make-product-p4-n5', true).
causes_true('made-p4', 'make-product-p4-n4', true).
causes_true('machine-available', 'make-product-p4-n4', true).
causes_true('made-p4', 'make-product-p4-n3', true).
causes_true('machine-available', 'make-product-p4-n3', true).
causes_true('made-p3', 'make-product-p3-n5', true).
causes_true('machine-available', 'make-product-p3-n5', true).
causes_true('made-p3', 'make-product-p3-n4', true).
causes_true('machine-available', 'make-product-p3-n4', true).
causes_true('made-p3', 'make-product-p3-n3', true).
causes_true('machine-available', 'make-product-p3-n3', true).
causes_true('made-p2', 'make-product-p2-n5', true).
causes_true('machine-available', 'make-product-p2-n5', true).
causes_true('made-p2', 'make-product-p2-n4', true).
causes_true('machine-available', 'make-product-p2-n4', true).
causes_true('made-p2', 'make-product-p2-n3', true).
causes_true('machine-available', 'make-product-p2-n3', true).
causes_true('made-p1', 'make-product-p1-n5', true).
causes_true('machine-available', 'make-product-p1-n5', true).
causes_true('made-p1', 'make-product-p1-n4', true).
causes_true('machine-available', 'make-product-p1-n4', true).
causes_true('made-p1', 'make-product-p1-n3', true).
causes_true('machine-available', 'make-product-p1-n3', true).
causes_true('stacks-avail-n3', 'open-new-stack-n2-n3', true).
causes_true('stacks-avail-n4', 'open-new-stack-n3-n4', true).
causes_true('stacks-avail-n5', 'open-new-stack-n4-n5', true).
causes_true('started-o5', 'start-order-o5-n2-n1', true).
causes_true('stacks-avail-n1', 'start-order-o5-n2-n1', true).
causes_true('started-o4', 'start-order-o4-n2-n1', true).
causes_true('stacks-avail-n1', 'start-order-o4-n2-n1', true).
causes_true('started-o3', 'start-order-o3-n2-n1', true).
causes_true('stacks-avail-n1', 'start-order-o3-n2-n1', true).
causes_true('started-o2', 'start-order-o2-n2-n1', true).
causes_true('stacks-avail-n1', 'start-order-o2-n2-n1', true).
causes_true('started-o1', 'start-order-o1-n2-n1', true).
causes_true('stacks-avail-n1', 'start-order-o1-n2-n1', true).
causes_true('started-o5', 'start-order-o5-n3-n2', true).
causes_true('stacks-avail-n2', 'start-order-o5-n3-n2', true).
causes_true('started-o4', 'start-order-o4-n3-n2', true).
causes_true('stacks-avail-n2', 'start-order-o4-n3-n2', true).
causes_true('started-o3', 'start-order-o3-n3-n2', true).
causes_true('stacks-avail-n2', 'start-order-o3-n3-n2', true).
causes_true('started-o2', 'start-order-o2-n3-n2', true).
causes_true('stacks-avail-n2', 'start-order-o2-n3-n2', true).
causes_true('started-o1', 'start-order-o1-n3-n2', true).
causes_true('stacks-avail-n2', 'start-order-o1-n3-n2', true).
causes_true('started-o5', 'start-order-o5-n4-n3', true).
causes_true('stacks-avail-n3', 'start-order-o5-n4-n3', true).
causes_true('started-o4', 'start-order-o4-n4-n3', true).
causes_true('stacks-avail-n3', 'start-order-o4-n4-n3', true).
causes_true('started-o3', 'start-order-o3-n4-n3', true).
causes_true('stacks-avail-n3', 'start-order-o3-n4-n3', true).
causes_true('started-o2', 'start-order-o2-n4-n3', true).
causes_true('stacks-avail-n3', 'start-order-o2-n4-n3', true).
causes_true('started-o1', 'start-order-o1-n4-n3', true).
causes_true('stacks-avail-n3', 'start-order-o1-n4-n3', true).
causes_true('started-o5', 'start-order-o5-n5-n4', true).
causes_true('stacks-avail-n4', 'start-order-o5-n5-n4', true).
causes_true('started-o4', 'start-order-o4-n5-n4', true).
causes_true('stacks-avail-n4', 'start-order-o4-n5-n4', true).
causes_true('started-o3', 'start-order-o3-n5-n4', true).
causes_true('stacks-avail-n4', 'start-order-o3-n5-n4', true).
causes_true('started-o2', 'start-order-o2-n5-n4', true).
causes_true('stacks-avail-n4', 'start-order-o2-n5-n4', true).
causes_true('started-o1', 'start-order-o1-n5-n4', true).
causes_true('stacks-avail-n4', 'start-order-o1-n5-n4', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n5', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n4', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n3', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n2', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n5', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n4', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n3', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n2', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n5', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n4', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n3', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n2', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n5', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n4', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n3', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n2', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n5', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n4', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n3', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n2', true).
causes_true('stacks-avail-n5', 'ship-order-o5-n4-n5', true).
causes_true('shipped-o5', 'ship-order-o5-n4-n5', true).
causes_true('stacks-avail-n4', 'ship-order-o5-n3-n4', true).
causes_true('shipped-o5', 'ship-order-o5-n3-n4', true).
causes_true('stacks-avail-n3', 'ship-order-o5-n2-n3', true).
causes_true('shipped-o5', 'ship-order-o5-n2-n3', true).
causes_true('stacks-avail-n2', 'ship-order-o5-n1-n2', true).
causes_true('shipped-o5', 'ship-order-o5-n1-n2', true).
causes_true('stacks-avail-n1', 'ship-order-o5-n0-n1', true).
causes_true('shipped-o5', 'ship-order-o5-n0-n1', true).
causes_true('stacks-avail-n5', 'ship-order-o4-n4-n5', true).
causes_true('shipped-o4', 'ship-order-o4-n4-n5', true).
causes_true('stacks-avail-n4', 'ship-order-o4-n3-n4', true).
causes_true('shipped-o4', 'ship-order-o4-n3-n4', true).
causes_true('stacks-avail-n3', 'ship-order-o4-n2-n3', true).
causes_true('shipped-o4', 'ship-order-o4-n2-n3', true).
causes_true('stacks-avail-n2', 'ship-order-o4-n1-n2', true).
causes_true('shipped-o4', 'ship-order-o4-n1-n2', true).
causes_true('stacks-avail-n1', 'ship-order-o4-n0-n1', true).
causes_true('shipped-o4', 'ship-order-o4-n0-n1', true).
causes_true('stacks-avail-n5', 'ship-order-o3-n4-n5', true).
causes_true('shipped-o3', 'ship-order-o3-n4-n5', true).
causes_true('stacks-avail-n4', 'ship-order-o3-n3-n4', true).
causes_true('shipped-o3', 'ship-order-o3-n3-n4', true).
causes_true('stacks-avail-n3', 'ship-order-o3-n2-n3', true).
causes_true('shipped-o3', 'ship-order-o3-n2-n3', true).
causes_true('stacks-avail-n2', 'ship-order-o3-n1-n2', true).
causes_true('shipped-o3', 'ship-order-o3-n1-n2', true).
causes_true('stacks-avail-n1', 'ship-order-o3-n0-n1', true).
causes_true('shipped-o3', 'ship-order-o3-n0-n1', true).
causes_true('stacks-avail-n5', 'ship-order-o2-n4-n5', true).
causes_true('shipped-o2', 'ship-order-o2-n4-n5', true).
causes_true('stacks-avail-n4', 'ship-order-o2-n3-n4', true).
causes_true('shipped-o2', 'ship-order-o2-n3-n4', true).
causes_true('stacks-avail-n3', 'ship-order-o2-n2-n3', true).
causes_true('shipped-o2', 'ship-order-o2-n2-n3', true).
causes_true('stacks-avail-n2', 'ship-order-o2-n1-n2', true).
causes_true('shipped-o2', 'ship-order-o2-n1-n2', true).
causes_true('stacks-avail-n1', 'ship-order-o2-n0-n1', true).
causes_true('shipped-o2', 'ship-order-o2-n0-n1', true).
causes_true('stacks-avail-n5', 'ship-order-o1-n4-n5', true).
causes_true('shipped-o1', 'ship-order-o1-n4-n5', true).
causes_true('stacks-avail-n4', 'ship-order-o1-n3-n4', true).
causes_true('shipped-o1', 'ship-order-o1-n3-n4', true).
causes_true('stacks-avail-n3', 'ship-order-o1-n2-n3', true).
causes_true('shipped-o1', 'ship-order-o1-n2-n3', true).
causes_true('stacks-avail-n2', 'ship-order-o1-n1-n2', true).
causes_true('shipped-o1', 'ship-order-o1-n1-n2', true).
causes_true('stacks-avail-n1', 'ship-order-o1-n0-n1', true).
causes_true('shipped-o1', 'ship-order-o1-n0-n1', true).
causes_true('made-p5', 'make-product-p5-n2', true).
causes_true('machine-available', 'make-product-p5-n2', true).
causes_true('made-p5', 'make-product-p5-n1', true).
causes_true('machine-available', 'make-product-p5-n1', true).
causes_true('made-p5', 'make-product-p5-n0', true).
causes_true('machine-available', 'make-product-p5-n0', true).
causes_true('made-p4', 'make-product-p4-n2', true).
causes_true('machine-available', 'make-product-p4-n2', true).
causes_true('made-p4', 'make-product-p4-n1', true).
causes_true('machine-available', 'make-product-p4-n1', true).
causes_true('made-p4', 'make-product-p4-n0', true).
causes_true('machine-available', 'make-product-p4-n0', true).
causes_true('made-p3', 'make-product-p3-n2', true).
causes_true('machine-available', 'make-product-p3-n2', true).
causes_true('made-p3', 'make-product-p3-n1', true).
causes_true('machine-available', 'make-product-p3-n1', true).
causes_true('made-p3', 'make-product-p3-n0', true).
causes_true('machine-available', 'make-product-p3-n0', true).
causes_true('made-p2', 'make-product-p2-n2', true).
causes_true('machine-available', 'make-product-p2-n2', true).
causes_true('made-p2', 'make-product-p2-n1', true).
causes_true('machine-available', 'make-product-p2-n1', true).
causes_true('made-p2', 'make-product-p2-n0', true).
causes_true('machine-available', 'make-product-p2-n0', true).
causes_true('made-p1', 'make-product-p1-n2', true).
causes_true('machine-available', 'make-product-p1-n2', true).
causes_true('made-p1', 'make-product-p1-n1', true).
causes_true('machine-available', 'make-product-p1-n1', true).
causes_true('made-p1', 'make-product-p1-n0', true).
causes_true('machine-available', 'make-product-p1-n0', true).
causes_true('stacks-avail-n2', 'open-new-stack-n1-n2', true).
causes_true('started-o5', 'start-order-o5-n1-n0', true).
causes_true('stacks-avail-n0', 'start-order-o5-n1-n0', true).
causes_true('started-o4', 'start-order-o4-n1-n0', true).
causes_true('stacks-avail-n0', 'start-order-o4-n1-n0', true).
causes_true('started-o3', 'start-order-o3-n1-n0', true).
causes_true('stacks-avail-n0', 'start-order-o3-n1-n0', true).
causes_true('started-o2', 'start-order-o2-n1-n0', true).
causes_true('stacks-avail-n0', 'start-order-o2-n1-n0', true).
causes_true('started-o1', 'start-order-o1-n1-n0', true).
causes_true('stacks-avail-n0', 'start-order-o1-n1-n0', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n1', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n1', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n1', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n1', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n1', true).
causes_true('stacks-avail-n1', 'open-new-stack-n0-n1', true).
causes_true('machine-configured-p5', 'setup-machine-p5-n0', true).
causes_true('machine-configured-p4', 'setup-machine-p4-n0', true).
causes_true('machine-configured-p3', 'setup-machine-p3-n0', true).
causes_true('machine-configured-p2', 'setup-machine-p2-n0', true).
causes_true('machine-configured-p1', 'setup-machine-p1-n0', true).

:- dynamic causes_false/3.

causes_false('not-made-p5', 'make-product-p5-n5', true).
causes_false('machine-configured-p5', 'make-product-p5-n5', true).
causes_false('not-made-p5', 'make-product-p5-n4', true).
causes_false('machine-configured-p5', 'make-product-p5-n4', true).
causes_false('not-made-p5', 'make-product-p5-n3', true).
causes_false('machine-configured-p5', 'make-product-p5-n3', true).
causes_false('not-made-p4', 'make-product-p4-n5', true).
causes_false('machine-configured-p4', 'make-product-p4-n5', true).
causes_false('not-made-p4', 'make-product-p4-n4', true).
causes_false('machine-configured-p4', 'make-product-p4-n4', true).
causes_false('not-made-p4', 'make-product-p4-n3', true).
causes_false('machine-configured-p4', 'make-product-p4-n3', true).
causes_false('not-made-p3', 'make-product-p3-n5', true).
causes_false('machine-configured-p3', 'make-product-p3-n5', true).
causes_false('not-made-p3', 'make-product-p3-n4', true).
causes_false('machine-configured-p3', 'make-product-p3-n4', true).
causes_false('not-made-p3', 'make-product-p3-n3', true).
causes_false('machine-configured-p3', 'make-product-p3-n3', true).
causes_false('not-made-p2', 'make-product-p2-n5', true).
causes_false('machine-configured-p2', 'make-product-p2-n5', true).
causes_false('not-made-p2', 'make-product-p2-n4', true).
causes_false('machine-configured-p2', 'make-product-p2-n4', true).
causes_false('not-made-p2', 'make-product-p2-n3', true).
causes_false('machine-configured-p2', 'make-product-p2-n3', true).
causes_false('not-made-p1', 'make-product-p1-n5', true).
causes_false('machine-configured-p1', 'make-product-p1-n5', true).
causes_false('not-made-p1', 'make-product-p1-n4', true).
causes_false('machine-configured-p1', 'make-product-p1-n4', true).
causes_false('not-made-p1', 'make-product-p1-n3', true).
causes_false('machine-configured-p1', 'make-product-p1-n3', true).
causes_false('stacks-avail-n2', 'open-new-stack-n2-n3', true).
causes_false('stacks-avail-n3', 'open-new-stack-n3-n4', true).
causes_false('stacks-avail-n4', 'open-new-stack-n4-n5', true).
causes_false('waiting-o5', 'start-order-o5-n2-n1', true).
causes_false('stacks-avail-n2', 'start-order-o5-n2-n1', true).
causes_false('waiting-o4', 'start-order-o4-n2-n1', true).
causes_false('stacks-avail-n2', 'start-order-o4-n2-n1', true).
causes_false('waiting-o3', 'start-order-o3-n2-n1', true).
causes_false('stacks-avail-n2', 'start-order-o3-n2-n1', true).
causes_false('waiting-o2', 'start-order-o2-n2-n1', true).
causes_false('stacks-avail-n2', 'start-order-o2-n2-n1', true).
causes_false('waiting-o1', 'start-order-o1-n2-n1', true).
causes_false('stacks-avail-n2', 'start-order-o1-n2-n1', true).
causes_false('waiting-o5', 'start-order-o5-n3-n2', true).
causes_false('stacks-avail-n3', 'start-order-o5-n3-n2', true).
causes_false('waiting-o4', 'start-order-o4-n3-n2', true).
causes_false('stacks-avail-n3', 'start-order-o4-n3-n2', true).
causes_false('waiting-o3', 'start-order-o3-n3-n2', true).
causes_false('stacks-avail-n3', 'start-order-o3-n3-n2', true).
causes_false('waiting-o2', 'start-order-o2-n3-n2', true).
causes_false('stacks-avail-n3', 'start-order-o2-n3-n2', true).
causes_false('waiting-o1', 'start-order-o1-n3-n2', true).
causes_false('stacks-avail-n3', 'start-order-o1-n3-n2', true).
causes_false('waiting-o5', 'start-order-o5-n4-n3', true).
causes_false('stacks-avail-n4', 'start-order-o5-n4-n3', true).
causes_false('waiting-o4', 'start-order-o4-n4-n3', true).
causes_false('stacks-avail-n4', 'start-order-o4-n4-n3', true).
causes_false('waiting-o3', 'start-order-o3-n4-n3', true).
causes_false('stacks-avail-n4', 'start-order-o3-n4-n3', true).
causes_false('waiting-o2', 'start-order-o2-n4-n3', true).
causes_false('stacks-avail-n4', 'start-order-o2-n4-n3', true).
causes_false('waiting-o1', 'start-order-o1-n4-n3', true).
causes_false('stacks-avail-n4', 'start-order-o1-n4-n3', true).
causes_false('waiting-o5', 'start-order-o5-n5-n4', true).
causes_false('stacks-avail-n5', 'start-order-o5-n5-n4', true).
causes_false('waiting-o4', 'start-order-o4-n5-n4', true).
causes_false('stacks-avail-n5', 'start-order-o4-n5-n4', true).
causes_false('waiting-o3', 'start-order-o3-n5-n4', true).
causes_false('stacks-avail-n5', 'start-order-o3-n5-n4', true).
causes_false('waiting-o2', 'start-order-o2-n5-n4', true).
causes_false('stacks-avail-n5', 'start-order-o2-n5-n4', true).
causes_false('waiting-o1', 'start-order-o1-n5-n4', true).
causes_false('stacks-avail-n5', 'start-order-o1-n5-n4', true).
causes_false('machine-available', 'setup-machine-p5-n5', true).
causes_false('machine-available', 'setup-machine-p5-n4', true).
causes_false('machine-available', 'setup-machine-p5-n3', true).
causes_false('machine-available', 'setup-machine-p5-n2', true).
causes_false('machine-available', 'setup-machine-p4-n5', true).
causes_false('machine-available', 'setup-machine-p4-n4', true).
causes_false('machine-available', 'setup-machine-p4-n3', true).
causes_false('machine-available', 'setup-machine-p4-n2', true).
causes_false('machine-available', 'setup-machine-p3-n5', true).
causes_false('machine-available', 'setup-machine-p3-n4', true).
causes_false('machine-available', 'setup-machine-p3-n3', true).
causes_false('machine-available', 'setup-machine-p3-n2', true).
causes_false('machine-available', 'setup-machine-p2-n5', true).
causes_false('machine-available', 'setup-machine-p2-n4', true).
causes_false('machine-available', 'setup-machine-p2-n3', true).
causes_false('machine-available', 'setup-machine-p2-n2', true).
causes_false('machine-available', 'setup-machine-p1-n5', true).
causes_false('machine-available', 'setup-machine-p1-n4', true).
causes_false('machine-available', 'setup-machine-p1-n3', true).
causes_false('machine-available', 'setup-machine-p1-n2', true).
causes_false('stacks-avail-n4', 'ship-order-o5-n4-n5', true).
causes_false('started-o5', 'ship-order-o5-n4-n5', true).
causes_false('stacks-avail-n3', 'ship-order-o5-n3-n4', true).
causes_false('started-o5', 'ship-order-o5-n3-n4', true).
causes_false('stacks-avail-n2', 'ship-order-o5-n2-n3', true).
causes_false('started-o5', 'ship-order-o5-n2-n3', true).
causes_false('stacks-avail-n1', 'ship-order-o5-n1-n2', true).
causes_false('started-o5', 'ship-order-o5-n1-n2', true).
causes_false('stacks-avail-n0', 'ship-order-o5-n0-n1', true).
causes_false('started-o5', 'ship-order-o5-n0-n1', true).
causes_false('stacks-avail-n4', 'ship-order-o4-n4-n5', true).
causes_false('started-o4', 'ship-order-o4-n4-n5', true).
causes_false('stacks-avail-n3', 'ship-order-o4-n3-n4', true).
causes_false('started-o4', 'ship-order-o4-n3-n4', true).
causes_false('stacks-avail-n2', 'ship-order-o4-n2-n3', true).
causes_false('started-o4', 'ship-order-o4-n2-n3', true).
causes_false('stacks-avail-n1', 'ship-order-o4-n1-n2', true).
causes_false('started-o4', 'ship-order-o4-n1-n2', true).
causes_false('stacks-avail-n0', 'ship-order-o4-n0-n1', true).
causes_false('started-o4', 'ship-order-o4-n0-n1', true).
causes_false('stacks-avail-n4', 'ship-order-o3-n4-n5', true).
causes_false('started-o3', 'ship-order-o3-n4-n5', true).
causes_false('stacks-avail-n3', 'ship-order-o3-n3-n4', true).
causes_false('started-o3', 'ship-order-o3-n3-n4', true).
causes_false('stacks-avail-n2', 'ship-order-o3-n2-n3', true).
causes_false('started-o3', 'ship-order-o3-n2-n3', true).
causes_false('stacks-avail-n1', 'ship-order-o3-n1-n2', true).
causes_false('started-o3', 'ship-order-o3-n1-n2', true).
causes_false('stacks-avail-n0', 'ship-order-o3-n0-n1', true).
causes_false('started-o3', 'ship-order-o3-n0-n1', true).
causes_false('stacks-avail-n4', 'ship-order-o2-n4-n5', true).
causes_false('started-o2', 'ship-order-o2-n4-n5', true).
causes_false('stacks-avail-n3', 'ship-order-o2-n3-n4', true).
causes_false('started-o2', 'ship-order-o2-n3-n4', true).
causes_false('stacks-avail-n2', 'ship-order-o2-n2-n3', true).
causes_false('started-o2', 'ship-order-o2-n2-n3', true).
causes_false('stacks-avail-n1', 'ship-order-o2-n1-n2', true).
causes_false('started-o2', 'ship-order-o2-n1-n2', true).
causes_false('stacks-avail-n0', 'ship-order-o2-n0-n1', true).
causes_false('started-o2', 'ship-order-o2-n0-n1', true).
causes_false('stacks-avail-n4', 'ship-order-o1-n4-n5', true).
causes_false('started-o1', 'ship-order-o1-n4-n5', true).
causes_false('stacks-avail-n3', 'ship-order-o1-n3-n4', true).
causes_false('started-o1', 'ship-order-o1-n3-n4', true).
causes_false('stacks-avail-n2', 'ship-order-o1-n2-n3', true).
causes_false('started-o1', 'ship-order-o1-n2-n3', true).
causes_false('stacks-avail-n1', 'ship-order-o1-n1-n2', true).
causes_false('started-o1', 'ship-order-o1-n1-n2', true).
causes_false('stacks-avail-n0', 'ship-order-o1-n0-n1', true).
causes_false('started-o1', 'ship-order-o1-n0-n1', true).
causes_false('not-made-p5', 'make-product-p5-n2', true).
causes_false('machine-configured-p5', 'make-product-p5-n2', true).
causes_false('not-made-p5', 'make-product-p5-n1', true).
causes_false('machine-configured-p5', 'make-product-p5-n1', true).
causes_false('not-made-p5', 'make-product-p5-n0', true).
causes_false('machine-configured-p5', 'make-product-p5-n0', true).
causes_false('not-made-p4', 'make-product-p4-n2', true).
causes_false('machine-configured-p4', 'make-product-p4-n2', true).
causes_false('not-made-p4', 'make-product-p4-n1', true).
causes_false('machine-configured-p4', 'make-product-p4-n1', true).
causes_false('not-made-p4', 'make-product-p4-n0', true).
causes_false('machine-configured-p4', 'make-product-p4-n0', true).
causes_false('not-made-p3', 'make-product-p3-n2', true).
causes_false('machine-configured-p3', 'make-product-p3-n2', true).
causes_false('not-made-p3', 'make-product-p3-n1', true).
causes_false('machine-configured-p3', 'make-product-p3-n1', true).
causes_false('not-made-p3', 'make-product-p3-n0', true).
causes_false('machine-configured-p3', 'make-product-p3-n0', true).
causes_false('not-made-p2', 'make-product-p2-n2', true).
causes_false('machine-configured-p2', 'make-product-p2-n2', true).
causes_false('not-made-p2', 'make-product-p2-n1', true).
causes_false('machine-configured-p2', 'make-product-p2-n1', true).
causes_false('not-made-p2', 'make-product-p2-n0', true).
causes_false('machine-configured-p2', 'make-product-p2-n0', true).
causes_false('not-made-p1', 'make-product-p1-n2', true).
causes_false('machine-configured-p1', 'make-product-p1-n2', true).
causes_false('not-made-p1', 'make-product-p1-n1', true).
causes_false('machine-configured-p1', 'make-product-p1-n1', true).
causes_false('not-made-p1', 'make-product-p1-n0', true).
causes_false('machine-configured-p1', 'make-product-p1-n0', true).
causes_false('stacks-avail-n1', 'open-new-stack-n1-n2', true).
causes_false('waiting-o5', 'start-order-o5-n1-n0', true).
causes_false('stacks-avail-n1', 'start-order-o5-n1-n0', true).
causes_false('waiting-o4', 'start-order-o4-n1-n0', true).
causes_false('stacks-avail-n1', 'start-order-o4-n1-n0', true).
causes_false('waiting-o3', 'start-order-o3-n1-n0', true).
causes_false('stacks-avail-n1', 'start-order-o3-n1-n0', true).
causes_false('waiting-o2', 'start-order-o2-n1-n0', true).
causes_false('stacks-avail-n1', 'start-order-o2-n1-n0', true).
causes_false('waiting-o1', 'start-order-o1-n1-n0', true).
causes_false('stacks-avail-n1', 'start-order-o1-n1-n0', true).
causes_false('machine-available', 'setup-machine-p5-n1', true).
causes_false('machine-available', 'setup-machine-p4-n1', true).
causes_false('machine-available', 'setup-machine-p3-n1', true).
causes_false('machine-available', 'setup-machine-p2-n1', true).
causes_false('machine-available', 'setup-machine-p1-n1', true).
causes_false('stacks-avail-n0', 'open-new-stack-n0-n1', true).
causes_false('machine-available', 'setup-machine-p5-n0', true).
causes_false('machine-available', 'setup-machine-p4-n0', true).
causes_false('machine-available', 'setup-machine-p3-n0', true).
causes_false('machine-available', 'setup-machine-p2-n0', true).
causes_false('machine-available', 'setup-machine-p1-n0', true).

