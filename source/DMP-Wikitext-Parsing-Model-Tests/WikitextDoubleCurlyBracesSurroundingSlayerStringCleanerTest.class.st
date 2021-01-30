"
A WikitextDoubleCurlyBracesSurroundingSlayerStringCleanerTest is a test class for testing the behavior of WikitextDoubleCurlyBracesSurroundingSlayerStringCleaner
"
Class {
	#name : #WikitextDoubleCurlyBracesSurroundingSlayerStringCleanerTest,
	#superclass : #TestCase,
	#category : #'DMP-Wikitext-Parsing-Model-Tests'
}

{ #category : #tests }
WikitextDoubleCurlyBracesSurroundingSlayerStringCleanerTest >> test01WhenWikitextToCleanDoesNotHaveDoubleCurlyBracesSurroundingSlayerStringItDoesNothing [

	| wikitextToClean wikitextCleaned |

	wikitextToClean := 'clean wikitext'.
	wikitextCleaned := WikitextDoubleCurlyBracesSurroundingSlayerStringCleaner new clean: wikitextToClean.
	self assert: wikitextCleaned equals: wikitextToClean
]

{ #category : #tests }
WikitextDoubleCurlyBracesSurroundingSlayerStringCleanerTest >> test02WhenWikitextToCleanIncludesDoubleCurlyBracesSurroundingSlayerStringAndSomethingElseItOnlyPreservesSlayerString [

	| wikitextToClean cleanedWikitext expectedCleanedWikitext |

	wikitextToClean := 'One of your creatures gets "{{Slayer|no}}" until the end of the turn.'.
	cleanedWikitext := WikitextDoubleCurlyBracesSurroundingSlayerStringCleaner new
		clean: wikitextToClean.
	expectedCleanedWikitext := 'One of your creatures gets Slayer until the end of the turn.'.
	self assert: cleanedWikitext equals: expectedCleanedWikitext
]
