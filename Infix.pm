########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.182.
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
    my $pos;

    for (${$self->input}) {
      

      m{\G(\s+)}gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(\)|\+|\-|\;|\(|\/|\*|\=)}gc and return ($1, $1);

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


#line 64 ./Infix.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@Infix::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.182',
    yyGRAMMAR  =>
[#[productionNameAndLabel => lhs, [ rhs], bypass]]
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
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  'EXPS' => 1,
  'EXPS' => 2,
  'line_3' => 3,
  'PRINT' => 4,
  'sts_5' => 5,
  'NUM' => 6,
  'VAR' => 7,
  'ASSIGN' => 8,
  'PLUS' => 9,
  'MINUS' => 10,
  'TIMES' => 11,
  'DIV' => 12,
  'NEG' => 13,
  'exp_14' => 14,
  'VAR' => 15,
},
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
			"(" => 9,
			"-" => 7,
			'NUM' => 8,
			'VAR' => 3,
			'PRINT' => 4
		},
		GOTOS => {
			'leftvalue' => 10,
			'line' => 5,
			'sts' => 2,
			'exp' => 1,
			'PLUS-1' => 6
		}
	},
	{#State 1
		ACTIONS => {
			"/" => 12,
			"+" => 14,
			"*" => 11,
			"-" => 13
		},
		DEFAULT => -5
	},
	{#State 2
		DEFAULT => -2
	},
	{#State 3
		ACTIONS => {
			"=" => -15
		},
		DEFAULT => -7
	},
	{#State 4
		ACTIONS => {
			'VAR' => 15
		},
		GOTOS => {
			'leftvalue' => 16
		}
	},
	{#State 5
		ACTIONS => {
			'' => 17
		}
	},
	{#State 6
		ACTIONS => {
			";" => 18
		},
		DEFAULT => -3
	},
	{#State 7
		ACTIONS => {
			"-" => 7,
			'NUM' => 8,
			"(" => 9,
			'VAR' => 3
		},
		GOTOS => {
			'exp' => 19,
			'leftvalue' => 10
		}
	},
	{#State 8
		DEFAULT => -6
	},
	{#State 9
		ACTIONS => {
			"(" => 9,
			'NUM' => 8,
			"-" => 7,
			'VAR' => 3
		},
		GOTOS => {
			'exp' => 20,
			'leftvalue' => 10
		}
	},
	{#State 10
		ACTIONS => {
			"=" => 21
		}
	},
	{#State 11
		ACTIONS => {
			'VAR' => 3,
			"(" => 9,
			'NUM' => 8,
			"-" => 7
		},
		GOTOS => {
			'exp' => 22,
			'leftvalue' => 10
		}
	},
	{#State 12
		ACTIONS => {
			"-" => 7,
			'NUM' => 8,
			"(" => 9,
			'VAR' => 3
		},
		GOTOS => {
			'leftvalue' => 10,
			'exp' => 23
		}
	},
	{#State 13
		ACTIONS => {
			'NUM' => 8,
			"-" => 7,
			"(" => 9,
			'VAR' => 3
		},
		GOTOS => {
			'leftvalue' => 10,
			'exp' => 24
		}
	},
	{#State 14
		ACTIONS => {
			"(" => 9,
			'NUM' => 8,
			"-" => 7,
			'VAR' => 3
		},
		GOTOS => {
			'leftvalue' => 10,
			'exp' => 25
		}
	},
	{#State 15
		DEFAULT => -15
	},
	{#State 16
		DEFAULT => -4
	},
	{#State 17
		DEFAULT => 0
	},
	{#State 18
		ACTIONS => {
			'VAR' => 3,
			'PRINT' => 4,
			"-" => 7,
			'NUM' => 8,
			"(" => 9
		},
		GOTOS => {
			'exp' => 1,
			'sts' => 26,
			'leftvalue' => 10
		}
	},
	{#State 19
		DEFAULT => -13
	},
	{#State 20
		ACTIONS => {
			"/" => 12,
			")" => 27,
			"*" => 11,
			"+" => 14,
			"-" => 13
		}
	},
	{#State 21
		ACTIONS => {
			'VAR' => 3,
			"(" => 9,
			"-" => 7,
			'NUM' => 8
		},
		GOTOS => {
			'leftvalue' => 10,
			'exp' => 28
		}
	},
	{#State 22
		DEFAULT => -11
	},
	{#State 23
		DEFAULT => -12
	},
	{#State 24
		ACTIONS => {
			"/" => 12,
			"*" => 11
		},
		DEFAULT => -10
	},
	{#State 25
		ACTIONS => {
			"*" => 11,
			"/" => 12
		},
		DEFAULT => -9
	},
	{#State 26
		DEFAULT => -1
	},
	{#State 27
		DEFAULT => -14
	},
	{#State 28
		ACTIONS => {
			"*" => 11,
			"/" => 12,
			"-" => 13,
			"+" => 14
		},
		DEFAULT => -8
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 354 ./Infix.pm
	],
	[#Rule EXPS
		 'PLUS-1', 3,
sub {
#line 16 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 361 ./Infix.pm
	],
	[#Rule EXPS
		 'PLUS-1', 1,
sub {
#line 16 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 368 ./Infix.pm
	],
	[#Rule line_3
		 'line', 1,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 375 ./Infix.pm
	],
	[#Rule PRINT
		 'sts', 2,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 382 ./Infix.pm
	],
	[#Rule sts_5
		 'sts', 1,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 389 ./Infix.pm
	],
	[#Rule NUM
		 'exp', 1,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 396 ./Infix.pm
	],
	[#Rule VAR
		 'exp', 1,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 403 ./Infix.pm
	],
	[#Rule ASSIGN
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 410 ./Infix.pm
	],
	[#Rule PLUS
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 417 ./Infix.pm
	],
	[#Rule MINUS
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 424 ./Infix.pm
	],
	[#Rule TIMES
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 431 ./Infix.pm
	],
	[#Rule DIV
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 438 ./Infix.pm
	],
	[#Rule NEG
		 'exp', 2,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 445 ./Infix.pm
	],
	[#Rule exp_14
		 'exp', 3,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 452 ./Infix.pm
	],
	[#Rule VAR
		 'leftvalue', 1,
sub {
#line 12 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 459 ./Infix.pm
	]
],
#line 462 ./Infix.pm
    yybypass       => 1,
    yybuildingtree => 1,
    yyprefix       => '',
    yyaccessors    => {
   },
    yyconflicthandlers => {}
,
    yystateconflict => {  },
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


#line 504 ./Infix.pm



1;
