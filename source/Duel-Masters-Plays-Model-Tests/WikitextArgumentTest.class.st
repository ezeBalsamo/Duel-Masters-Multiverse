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
		assert: wikitextArgument name equals: name;
		assert: wikitextArgument content equals: content
]

{ #category : #tests }
WikitextArgumentTest >> testUnnamedWikitextArgument [

	| content wikitextArgument |

	content := 'Fire'.
	wikitextArgument := WikitextArgument unnamedWithContent: content.
	self
		should: [ wikitextArgument name ] raise: Error withMessageText: 'No se definió un nombre.';
		assert: wikitextArgument content equals: content
]
