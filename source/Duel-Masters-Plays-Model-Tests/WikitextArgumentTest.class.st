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
WikitextArgumentTest >> testNamedWikitextArgumentEquivalentToAnotherNamedWikitextArgument [

	| name content wikitextArgument anotherWikitextArgument |

	name := 'Civilization'.
	content := 'Fire'.
	wikitextArgument := WikitextArgument named: name content: content.
	anotherWikitextArgument := WikitextArgument named: name content: content.

	self assert: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> testNamedWikitextArgumentIsNotEquivalentToAnUnnamedWikitextArgument [

	| content wikitextArgument anotherWikitextArgument |

	content := 'Fire'.
	wikitextArgument := WikitextArgument named: 'civilization' content: content.
	anotherWikitextArgument := WikitextArgument unnamedWithContent: content.

	self deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
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

{ #category : #tests }
WikitextArgumentTest >> testUnnamedWikitextArgumentEquivalentToAnotherUnamedWikitextArgument [

	| content wikitextArgument anotherWikitextArgument |

	content := 'Fire'.
	wikitextArgument := WikitextArgument unnamedWithContent: content.
	anotherWikitextArgument := WikitextArgument unnamedWithContent: content.

	self assert: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> testUnnamedWikitextArgumentIsNotEquivalentToANamedWikitextArgument [

	| content wikitextArgument anotherWikitextArgument |

	content := 'Fire'.
	wikitextArgument := WikitextArgument unnamedWithContent: content.
	anotherWikitextArgument := WikitextArgument named: 'civilization' content: content.

	self deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]
