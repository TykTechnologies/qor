# listPackages lists local go packages. In case a subpackage contains
# it's own go.mod file, it will not be listed as part of the output.
function listPackages {
	# Skip MDCB tests until under a tag
	# Skip mocks
	go list ./... | egrep -v "/(mock)$"
}