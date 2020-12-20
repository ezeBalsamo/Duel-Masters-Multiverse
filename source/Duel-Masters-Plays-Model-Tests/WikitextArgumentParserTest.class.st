"
A WikitextArgumentParserTest is a test class for testing the behavior of WikitextArgumentParser
"
Class {
	#name : #WikitextArgumentParserTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextArgumentParserTest >> test01ParsingANamedWikitextArgument [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := 'civilization=Water'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument named: 'civilization' content: 'Water'.

	self
		assert: ( wikitextArgumentParser isA: NamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]

{ #category : #tests }
WikitextArgumentParserTest >> test02ParsingAnUnamedWikitextArgument [

	| wikitextArgumentToParse wikitextArgumentParser parsedWikitextArgument expectedWikitextArgument |

	wikitextArgumentToParse := 'Return one of your opponent''s creatures to their hand.'.

	wikitextArgumentParser := WikitextArgumentParser toParse: wikitextArgumentToParse.
	parsedWikitextArgument := wikitextArgumentParser parse.
	expectedWikitextArgument := WikitextArgument unnamedWithContent: wikitextArgumentToParse.

	self
		assert: ( wikitextArgumentParser isAn: UnnamedWikitextArgumentParser );
		assert: ( expectedWikitextArgument isEquivalentTo: parsedWikitextArgument )
]
