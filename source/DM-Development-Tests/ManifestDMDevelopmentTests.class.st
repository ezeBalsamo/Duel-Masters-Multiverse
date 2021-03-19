"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDMDevelopmentTests,
	#superclass : #PackageManifest,
	#category : #'DM-Development-Tests-Manifest'
}

{ #category : #'meta-data - dependency analyser' }
ManifestDMDevelopmentTests class >> manuallyResolvedDependencies [

	^ #(#'DM-Transcript-Core-Base-Extensions' #'DM-Transcript-NonInteractive-Base-Extensions')
]
