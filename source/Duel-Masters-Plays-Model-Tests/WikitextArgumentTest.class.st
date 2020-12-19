Class {
	#name : #WikitextArgumentTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Model-Tests'
}

{ #category : #tests }
WikitextArgumentTest >> test01NamedWikitextArgument [

	| name content wikitextArgument |

	name := 'Civilization'.
	content := 'Fire'.

	wikitextArgument := WikitextArgument named: name content: content.

	self
		assert: ( wikitextArgument isNamed: name );
		assert: ( wikitextArgument hasContent: content )
]

{ #category : #tests }
WikitextArgumentTest >> test02UnnamedWikitextArgument [

	| content wikitextArgument |

	content := 'Fire'.
	wikitextArgument := WikitextArgument unnamedWithContent: content.
	self
		assert: wikitextArgument isUnnamed;
		assert: ( wikitextArgument hasContent: content )
]

{ #category : #tests }
WikitextArgumentTest >> test03PrintingANamedWikitextArgument [

	| name content wikitextArgument expectedPrintString |

	name := 'Civilization'.
	content := 'Fire'.

	wikitextArgument := WikitextArgument named: name content: content.
	expectedPrintString := 'Wikitext Argument named <1s> with <2s>'
		expandMacrosWith: name
		with: content.

	self assert: wikitextArgument printString equals: expectedPrintString
]

{ #category : #tests }
WikitextArgumentTest >> test04PrintingAnUnnamedWikitextArgument [

	| content wikitextArgument expectedPrintString |

	content := 'Fire'.

	wikitextArgument := WikitextArgument unnamedWithContent: content.
	expectedPrintString := 'Wikitext Argument unnamed with <1s>' expandMacrosWith: content.

	self assert: wikitextArgument printString equals: expectedPrintString
]

{ #category : #tests }
WikitextArgumentTest >> test05NamedWikitextArgumentEquivalentToAnotherNamedWikitextArgument [

	| name content wikitextArgument anotherWikitextArgument |

	name := 'Civilization'.
	content := 'Fire'.
	wikitextArgument := WikitextArgument named: name content: content.
	anotherWikitextArgument := WikitextArgument named: name content: content.

	self
		assert: ( wikitextArgument hasSameNameThan: anotherWikitextArgument );
		assert: ( wikitextArgument hasSameContentThan: anotherWikitextArgument );
		assert: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test06UnnamedWikitextArgumentEquivalentToAnotherUnamedWikitextArgument [

	| content wikitextArgument anotherWikitextArgument |

	content := 'Fire'.
	wikitextArgument := WikitextArgument unnamedWithContent: content.
	anotherWikitextArgument := WikitextArgument unnamedWithContent: content.

	self
		assert: ( wikitextArgument hasSameContentThan: anotherWikitextArgument );
		assert: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test07NamedWikitextArgumentIsNotEquivalentToAnUnnamedWikitextArgument [

	| content wikitextArgument anotherWikitextArgument |

	content := 'Fire'.
	wikitextArgument := WikitextArgument named: 'civilization' content: content.
	anotherWikitextArgument := WikitextArgument unnamedWithContent: content.

	self deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test08NamedWikitextArgumentIsNotEquivalentToAnotherWikitextArgumentWithDifferentName [

	| content wikitextArgument anotherWikitextArgument |

	content := 'Fire'.
	wikitextArgument := WikitextArgument named: 'civilization' content: content.
	anotherWikitextArgument := WikitextArgument named: 'type' content: content.

	self
		deny: ( wikitextArgument hasSameNameThan: anotherWikitextArgument );
		deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test09NamedWikitextArgumentIsNotEquivalentToAnotherWikitextArgumentWithDifferentContent [

	| commonName wikitextArgument anotherWikitextArgument |

	commonName := 'civilization'.
	wikitextArgument := WikitextArgument named: commonName content: 'Water'.
	anotherWikitextArgument := WikitextArgument named: commonName content: 'Creature'.

	self
		deny: ( wikitextArgument hasSameContentThan: anotherWikitextArgument );
		deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test10UnnamedWikitextArgumentIsNotEquivalentToANamedWikitextArgument [

	| content wikitextArgument anotherWikitextArgument |

	content := 'Fire'.
	wikitextArgument := WikitextArgument unnamedWithContent: content.
	anotherWikitextArgument := WikitextArgument named: 'civilization' content: content.

	self deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test11UnnamedWikitextArgumentIsNotEquivalentToAnUnamedWikitextArgumentWithDifferentContent [

	| wikitextArgument anotherWikitextArgument |

	wikitextArgument := WikitextArgument unnamedWithContent: 'Water'.
	anotherWikitextArgument := WikitextArgument unnamedWithContent: 'Creature'.

	self
		deny: ( wikitextArgument hasSameContentThan: anotherWikitextArgument );
		deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]
