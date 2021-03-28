"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDMDevelopmentSupportTests,
	#superclass : #PackageManifest,
	#category : #'DM-Development-Support-Tests-Manifest'
}

{ #category : #'meta-data - dependency analyser' }
ManifestDMDevelopmentSupportTests class >> manuallyResolvedDependencies [
	^ #(#'DM-Transcript-Core-Base-Extensions' #'DM-Transcript-NonInteractive-Base-Extensions' #'DM-Kernel-Classes-Extensions')
]
