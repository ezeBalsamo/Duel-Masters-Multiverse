Class {
	#name : #WikitextDoubleCurlyBracesSurroundingSearchStringCleanerTest,
	#superclass : #TestCase,
	#category : #'DMP-Wikitext-Parsing-Model-Tests'
}

{ #category : #tests }
WikitextDoubleCurlyBracesSurroundingSearchStringCleanerTest >> test01WhenWikitextToCleanDoesNotHaveDoubleCurlyBracesSurroundingSearchStringItDoesNothing [

	| wikitextToClean wikitextCleaned |

	wikitextToClean := 'clean wikitext'.
	wikitextCleaned := WikitextDoubleCurlyBracesSurroundingSearchStringCleaner new clean: wikitextToClean.
	self assert: wikitextCleaned equals: wikitextToClean
]

{ #category : #tests }
WikitextDoubleCurlyBracesSurroundingSearchStringCleanerTest >> test02WhenWikitextToCleanIncludesDoubleCurlyBracesSurroundingSearchStringItRemovesThem [

	| wikitextToClean cleanedWikitext expectedCleanedWikitext |

	wikitextToClean := 'When this enters the battle zone, you may {{search}} your deck'.
	cleanedWikitext := WikitextDoubleCurlyBracesSurroundingSearchStringCleaner new
		clean: wikitextToClean.
	expectedCleanedWikitext := 'When this enters the battle zone, you may search your deck'.
	self assert: cleanedWikitext equals: expectedCleanedWikitext
]

{ #category : #tests }
WikitextDoubleCurlyBracesSurroundingSearchStringCleanerTest >> test03WhenWikitextToCleanIncludesDoubleCurlyBracesSurroundingSearchStringAndSomethingElseItOnlyPreservesSearchString [

	| wikitextToClean cleanedWikitext expectedCleanedWikitext |

	wikitextToClean := '{{Search|cap}} your deck for a spell. You may reveal one and add it to your hand. Then shuffle your deck.'.
	cleanedWikitext := WikitextDoubleCurlyBracesSurroundingSearchStringCleaner new
		clean: wikitextToClean.
	expectedCleanedWikitext := 'Search your deck for a spell. You may reveal one and add it to your hand. Then shuffle your deck.'.
	self assert: cleanedWikitext equals: expectedCleanedWikitext
]
