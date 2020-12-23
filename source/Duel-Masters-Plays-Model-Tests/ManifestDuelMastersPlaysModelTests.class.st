"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDuelMastersPlaysModelTests,
	#superclass : #PackageManifest,
	#category : #'Duel-Masters-Plays-Model-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestDuelMastersPlaysModelTests class >> ruleRBMethodSourceContainsLinefeedsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#WikitextArgumentContentParserTest #test05ParsingTrimmingWhiteSpacesDetectsBasicContent #false)) #'2020-12-22T21:25:34.490907-03:00') #(#(#RGMethodDefinition #(#WikitextArgumentParserTest #test04ParsingTrimsWhiteSpaces #false)) #'2020-12-22T21:25:45.049036-03:00') #(#(#RGMethodDefinition #(#WikitextTemplateParserTest #test03ParsingTrimsWhiteSpaces #false)) #'2020-12-22T21:26:31.807986-03:00') #(#(#RGMethodDefinition #(#WikitextArgumentParserTest #test04ParsingTrimmingWhiteSpacesDetectsNamedWikitextArgument #false)) #'2020-12-22T22:12:44.575798-03:00') )
]
