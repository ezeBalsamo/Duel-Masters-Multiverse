"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDMMatchRequestModel,
	#superclass : #PackageManifest,
	#category : #'DM-Match-Request-Model-Manifest'
}

{ #category : #'meta-data - dependency analyser' }
ManifestDMMatchRequestModel class >> manuallyResolvedDependencies [
	^ #(#'DM-Match-Model')
]
