TARGET=AnyMeasure
GITHUB_PAGES=https://wildthink.github.io/anymeasure/

all:
	swift package  --allow-writing-to-directory ./docs \
		generate-documentation --target $(TARGET) \
		--output-path ./docs \
		 --emit-digest  \
		--disable-indexing \
		--transform-for-static-hosting \
		--hosting-base-path '$(GITHUB_PAGES)'

alt:
	swift package --allow-writing-to-directory ./docs \
		generate-documentation --target $(TARGET) \
		 --emit-digest  \
		--disable-indexing \
		--transform-for-static-hosting \
		--hosting-base-path $(TARGET) \
		--output-path ./docs


