Class {
	#name : #WikitextArgumentTest,
	#superclass : #TestCase,
	#category : #'Duel-Masters-Plays-Wikitext-Parsing-Model-Tests'
}

{ #category : #tests }
WikitextArgumentTest >> test01NamedWikitextArgument [

	| name content wikitextArgument |

	name := 'Civilization'.
	content := WikitextBasicContent being: 'Fire'.

	wikitextArgument := WikitextArgument named: name withContent: content.

	self
		assert: ( wikitextArgument isNamed: name );
		assert: ( wikitextArgument hasContent: content )
]

{ #category : #tests }
WikitextArgumentTest >> test02UnnamedWikitextArgument [

	| content wikitextArgument |

	content := WikitextBasicContent being: 'Fire'.
	wikitextArgument := WikitextArgument unnamedWithContent: content.
	self
		assert: wikitextArgument isUnnamed;
		assert: ( wikitextArgument hasContent: content )
]

{ #category : #tests }
WikitextArgumentTest >> test03PrintingANamedWikitextArgument [

	| wikitextArgument expectedPrintString |

	wikitextArgument := WikitextArgument
		named: 'Civilization'
		withContent: ( WikitextBasicContent being: 'Fire' ).
	expectedPrintString := 'Wikitext Argument named Civilization with Basic Content: Fire'.

	self assert: wikitextArgument printString equals: expectedPrintString
]

{ #category : #tests }
WikitextArgumentTest >> test04PrintingAnUnnamedWikitextArgument [

	| content wikitextArgument expectedPrintString |

	content := WikitextBasicContent being: 'Fire'.

	wikitextArgument := WikitextArgument unnamedWithContent: content.
	expectedPrintString := 'Wikitext Argument unnamed with Basic Content: Fire'.

	self assert: wikitextArgument printString equals: expectedPrintString
]

{ #category : #tests }
WikitextArgumentTest >> test05NamedWikitextArgumentEquivalentToAnotherNamedWikitextArgument [

	| name content wikitextArgument anotherWikitextArgument |

	name := 'Civilization'.
	content := WikitextBasicContent being: 'Fire'.
	wikitextArgument := WikitextArgument named: name withContent: content.
	anotherWikitextArgument := WikitextArgument named: name withContent: content.

	self
		assert: ( wikitextArgument hasSameNameThan: anotherWikitextArgument );
		assert: ( wikitextArgument hasSameContentThan: anotherWikitextArgument );
		assert: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test06UnnamedWikitextArgumentEquivalentToAnotherUnamedWikitextArgument [

	| content wikitextArgument anotherWikitextArgument |

	content := WikitextBasicContent being: 'Fire'.
	wikitextArgument := WikitextArgument unnamedWithContent: content.
	anotherWikitextArgument := WikitextArgument unnamedWithContent: content.

	self
		assert: ( wikitextArgument hasSameContentThan: anotherWikitextArgument );
		assert: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test07NamedWikitextArgumentIsNotEquivalentToAnUnnamedWikitextArgument [

	| content wikitextArgument anotherWikitextArgument |

	content := WikitextBasicContent being: 'Fire'.
	wikitextArgument := WikitextArgument named: 'civilization' withContent: content.
	anotherWikitextArgument := WikitextArgument unnamedWithContent: content.

	self deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test08NamedWikitextArgumentIsNotEquivalentToAnotherWikitextArgumentWithDifferentName [

	| content wikitextArgument anotherWikitextArgument |

	content := WikitextBasicContent being: 'Fire'.
	wikitextArgument := WikitextArgument named: 'civilization' withContent: content.
	anotherWikitextArgument := WikitextArgument named: 'type' withContent: content.

	self
		deny: ( wikitextArgument hasSameNameThan: anotherWikitextArgument );
		deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test09NamedWikitextArgumentIsNotEquivalentToAnotherWikitextArgumentWithDifferentContent [

	| commonName wikitextArgument anotherWikitextArgument |

	commonName := 'civilization'.
	wikitextArgument := WikitextArgument
		named: commonName
		withContent: ( WikitextBasicContent being: 'Water' ).
	anotherWikitextArgument := WikitextArgument
		named: commonName
		withContent: ( WikitextBasicContent being: 'Creature' ).

	self
		deny: ( wikitextArgument hasSameContentThan: anotherWikitextArgument );
		deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test10UnnamedWikitextArgumentIsNotEquivalentToANamedWikitextArgument [

	| content wikitextArgument anotherWikitextArgument |

	content := WikitextBasicContent being: 'Fire'.
	wikitextArgument := WikitextArgument unnamedWithContent: content.
	anotherWikitextArgument := WikitextArgument named: 'civilization' withContent: content.

	self deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test11UnnamedWikitextArgumentIsNotEquivalentToAnUnamedWikitextArgumentWithDifferentContent [

	| wikitextArgument anotherWikitextArgument |

	wikitextArgument := WikitextArgument unnamedWithContent: ( WikitextBasicContent being: 'Water' ).
	anotherWikitextArgument := WikitextArgument
		unnamedWithContent: ( WikitextBasicContent being: 'Creature' ).

	self
		deny: ( wikitextArgument hasSameContentThan: anotherWikitextArgument );
		deny: ( wikitextArgument isEquivalentTo: anotherWikitextArgument )
]

{ #category : #tests }
WikitextArgumentTest >> test12NamedWikitextArgumentWithContentBeingAWikitextTemplateWithoutArguments [

	| argumentName wikitextTemplate wikitextArgument |

	argumentName := 'engtext'.
	wikitextTemplate := WikitextTemplate withoutArgumentsNamed: 'Tap Skill'.
	wikitextArgument := WikitextArgument named: argumentName withContent: wikitextTemplate.

	self
		assert: ( wikitextArgument isNamed: argumentName );
		assert: ( wikitextArgument hasContent: wikitextTemplate )
]

{ #category : #tests }
WikitextArgumentTest >> test13NamedWikitextArgumentWithContentBeingAWikitextTemplateWithOneNamedArgument [

	| argumentName innerWikitextArgument wikitextTemplate wikitextArgument |

	argumentName := 'engtext'.
	innerWikitextArgument := WikitextArgument
		named: 'civilization'
		withContent: ( WikitextBasicContent being: 'Water' ).
	wikitextTemplate := WikitextTemplate named: 'Tap Skill' withArgument: innerWikitextArgument.
	wikitextArgument := WikitextArgument named: argumentName withContent: wikitextTemplate.

	self
		assert: ( wikitextArgument isNamed: argumentName );
		assert: ( wikitextArgument hasContent: wikitextTemplate )
]
