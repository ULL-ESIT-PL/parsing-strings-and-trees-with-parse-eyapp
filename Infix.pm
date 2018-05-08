########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.169.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'Infix.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package Infix;
use strict;

push @Infix::ISA, 'Parse::Eyapp::Driver';




BEGIN {
  # This strange way to load the modules is to guarantee compatibility when
  # using several standalone and non-standalone Eyapp parsers

  require Parse::Eyapp::Driver unless Parse::Eyapp::Driver->can('YYParse');
  require Parse::Eyapp::Node unless Parse::Eyapp::Node->can('hnew'); 
}
  

sub unexpendedInput { defined($_) ? substr($_, (defined(pos $_) ? pos $_ : 0)) : '' }



# Default lexical analyzer
our $LEX = sub {
    my $self = shift;

    for (${$self->input}) {
      

      m{\G(\s+)}gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(\-|\+|\;|\/|\=|\(|\*|\))}gc and return ($1, $1);

      /\G([0-9]+(?:\.[0-9]+)?)/gc and return ('NUM', $1);
      /\Gprint\b/gc and return ('PRINT', $1);
      /\G([A-Za-z_][A-Za-z0-9_]*)/gc and return ('VAR', $1);


      return ('', undef) if ($_ eq '') || (defined(pos($_)) && (pos($_) >= length($_)));
      /\G\s*(\S+)/;
      my $near = substr($1,0,10); 

      return($near, $near);

     # die( "Error inside the lexical analyzer near '". $near
     #     ."'. Line: ".$self->line()
     #     .". File: '".$self->YYFilename()."'. No match found.\n");
    }
  }
;


#line 63 ./Infix.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@Infix::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.169',
    yyGRAMMAR  =>
[
  [ '_SUPERSTART' => '$start', [ 'line', '$end' ], 1 ],
  [ 'EXPS' => 'PLUS-1', [ 'PLUS-1', ';', 'sts' ], 1 ],
  [ 'EXPS' => 'PLUS-1', [ 'sts' ], 1 ],
  [ 'line_3' => 'line', [ 'PLUS-1' ], 1 ],
  [ 'PRINT' => 'sts', [ 'PRINT', 'leftvalue' ], 1 ],
  [ 'sts_5' => 'sts', [ 'exp' ], 1 ],
  [ 'NUM' => 'exp', [ 'NUM' ], 1 ],
  [ 'VAR' => 'exp', [ 'VAR' ], 1 ],
  [ 'ASSIGN' => 'exp', [ 'leftvalue', '=', 'exp' ], 1 ],
  [ 'PLUS' => 'exp', [ 'exp', '+', 'exp' ], 1 ],
  [ 'MINUS' => 'exp', [ 'exp', '-', 'exp' ], 1 ],
  [ 'TIMES' => 'exp', [ 'exp', '*', 'exp' ], 1 ],
  [ 'DIV' => 'exp', [ 'exp', '/', 'exp' ], 1 ],
  [ 'NEG' => 'exp', [ '-', 'exp' ], 0 ],
  [ 'exp_14' => 'exp', [ '(', 'exp', ')' ], 1 ],
  [ 'VAR' => 'leftvalue', [ 'VAR' ], 1 ],
],
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	'*' => { ISSEMANTIC => 0 },
	'+' => { ISSEMANTIC => 0 },
	'-' => { ISSEMANTIC => 0 },
	'/' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'=' => { ISSEMANTIC => 0 },
	NEG => { ISSEMANTIC => 1 },
	NUM => { ISSEMANTIC => 1 },
	PRINT => { ISSEMANTIC => 1 },
	VAR => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'Infix.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7,
			'PRINT' => 9
		},
		GOTOS => {
			'exp' => 2,
			'sts' => 8,
			'leftvalue' => 3,
			'line' => 10,
			'PLUS-1' => 4
		}
	},
	{#State 1
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 11,
			'leftvalue' => 3
		}
	},
	{#State 2
		ACTIONS => {
			"-" => 12,
			"*" => 15,
			"+" => 13,
			"/" => 14
		},
		DEFAULT => -5
	},
	{#State 3
		ACTIONS => {
			"=" => 16
		}
	},
	{#State 4
		ACTIONS => {
			";" => 17
		},
		DEFAULT => -3
	},
	{#State 5
		DEFAULT => -6
	},
	{#State 6
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 18,
			'leftvalue' => 3
		}
	},
	{#State 7
		ACTIONS => {
			"=" => -15
		},
		DEFAULT => -7
	},
	{#State 8
		DEFAULT => -2
	},
	{#State 9
		ACTIONS => {
			'VAR' => 20
		},
		GOTOS => {
			'leftvalue' => 19
		}
	},
	{#State 10
		ACTIONS => {
			'' => 21
		}
	},
	{#State 11
		DEFAULT => -13
	},
	{#State 12
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 22,
			'leftvalue' => 3
		}
	},
	{#State 13
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 23,
			'leftvalue' => 3
		}
	},
	{#State 14
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 24,
			'leftvalue' => 3
		}
	},
	{#State 15
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 25,
			'leftvalue' => 3
		}
	},
	{#State 16
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 26,
			'leftvalue' => 3
		}
	},
	{#State 17
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7,
			'PRINT' => 9
		},
		GOTOS => {
			'exp' => 2,
			'sts' => 27,
			'leftvalue' => 3
		}
	},
	{#State 18
		ACTIONS => {
			"-" => 12,
			"*" => 15,
			"+" => 13,
			"/" => 14,
			")" => 28
		}
	},
	{#State 19
		DEFAULT => -4
	},
	{#State 20
		DEFAULT => -15
	},
	{#State 21
		DEFAULT => 0
	},
	{#State 22
		ACTIONS => {
			"*" => 15,
			"/" => 14
		},
		DEFAULT => -10
	},
	{#State 23
		ACTIONS => {
			"*" => 15,
			"/" => 14
		},
		DEFAULT => -9
	},
	{#State 24
		DEFAULT => -12
	},
	{#State 25
		DEFAULT => -11
	},
	{#State 26
		ACTIONS => {
			"-" => 12,
			"*" => 15,
			"+" => 13,
			"/" => 14
		},
		DEFAULT => -8
	},
	{#State 27
		DEFAULT => -1
	},
	{#State 28
		DEFAULT => -14
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 334 ./Infix.pm
	],
	[#Rule EXPS
		 'PLUS-1', 3,
sub {
#line 16 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 341 ./Infix.pm
	],
	[#Rule EXPS
		 'PLUS-1', 1,
sub {
#line 16 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 348 ./Infix.pm
	],
	[#Rule line_3
		 'line', 1,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 355 ./Infix.pm
	],
	[#Rule PRINT
		 'sts', 2,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 362 ./Infix.pm
	],
	[#Rule sts_5
		 'sts', 1,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 369 ./Infix.pm
	],
	[#Rule NUM
		 'exp', 1,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 376 ./Infix.pm
	],
	[#Rule VAR
		 'exp', 1,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 383 ./Infix.pm
	],
	[#Rule ASSIGN
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 390 ./Infix.pm
	],
	[#Rule PLUS
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 397 ./Infix.pm
	],
	[#Rule MINUS
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 404 ./Infix.pm
	],
	[#Rule TIMES
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 411 ./Infix.pm
	],
	[#Rule DIV
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 418 ./Infix.pm
	],
	[#Rule NEG
		 'exp', 2,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 425 ./Infix.pm
	],
	[#Rule exp_14
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 432 ./Infix.pm
	],
	[#Rule VAR
		 'leftvalue', 1,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 439 ./Infix.pm
	]
],
#line 442 ./Infix.pm
    yybypass       => 1,
    yybuildingtree => 1,
    yyprefix       => '',
    yyaccessors    => {
   },
    yyconflicthandlers => {}
,
    @_,
  );
  bless($self,$class);

  $self->make_node_classes('TERMINAL', '_OPTIONAL', '_STAR_LIST', '_PLUS_LIST', 
         '_SUPERSTART', 
         'EXPS', 
         'EXPS', 
         'line_3', 
         'PRINT', 
         'sts_5', 
         'NUM', 
         'VAR', 
         'ASSIGN', 
         'PLUS', 
         'MINUS', 
         'TIMES', 
         'DIV', 
         'NEG', 
         'exp_14', 
         'VAR', );
  $self;
}

#line 48 "Infix.eyp"



=for None

=cut


#line 483 ./Infix.pm



1;
