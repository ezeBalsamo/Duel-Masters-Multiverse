Class {
	#name : #WikitextArgumentTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextArgumentTest >> testNamedWikitextArgument [

	| name content wikitextArgument |

	name := 'Civilization'.
	content := 'Fire'.

	wikitextArgument := WikitextArgument named: name content: content.

	self
		assert: ( wikitextArgument isNamed: name );
		assert: ( wikitextArgument hasContent: content )
]

{ #category : #tests }
WikitextArgumentTest >> testUnnamedWikitextArgument [

	| content wikitextArgument |

	content := 'Fire'.
	wikitextArgument := WikitextArgument unnamedWithContent: content.
	self
		deny: ( wikitextArgument isNamed: 'i am not a name' );
		assert: ( wikitextArgument hasContent: content )
]
