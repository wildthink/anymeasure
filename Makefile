TARGET=AnyMeasure

all:
	swift package  --allow-writing-to-directory ./docs \
		generate-documentation --target $(TARGET) \
		--output-path ./docs  --emit-digest  \
		--disable-indexing --transform-for-static-hosting \
		--hosting-base-path '$(TARGET)'


