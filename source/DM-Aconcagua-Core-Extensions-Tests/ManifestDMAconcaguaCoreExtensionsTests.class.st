"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDMAconcaguaCoreExtensionsTests,
	#superclass : #PackageManifest,
	#category : #'DM-Aconcagua-Core-Extensions-Tests-Manifest'
}

{ #category : #'meta-data - dependency analyser' }
ManifestDMAconcaguaCoreExtensionsTests class >> manuallyResolvedDependencies [
	^ #(#'DM-Aconcagua-Core-Extensions')
]
