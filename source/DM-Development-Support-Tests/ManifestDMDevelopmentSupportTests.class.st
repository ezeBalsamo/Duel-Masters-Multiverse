"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDMDevelopmentSupportTests,
	#superclass : #PackageManifest,
	#category : #'DM-Development-Support-Tests-Manifest'
}

{ #category : #'meta-data - dependency analyser' }
ManifestDMDevelopmentSupportTests class >> manuallyResolvedDependencies [
	^ #(#'DM-Transcript-Core-Base-Extensions' #'DM-Transcript-NonInteractive-Base-Extensions')
]
