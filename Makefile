all: generate open

generate:
	@ echo "\033[1;37mGenerating project files\033[0m"
	@ xcodegen -c

open:
	@ open RickAndMorty.xcodeproj

clean:
	@ echo "\033[1;37mCleaning up project files\033[0m"
	@ rm -rf RickAndMorty.xc*

remake: clean generate open
