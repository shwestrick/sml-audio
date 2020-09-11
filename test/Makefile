.PHONY: all
all:
	mlton -output reverb main.mlb
	./reverb waltz.wav
	@(diff out.wav out.wav.ok 2>&1; \
		if [ $$? -eq 0 ]; then \
			echo "mlton ok"; \
			rm -f out.wav; \
		else \
			echo "mlton PROBLEM"; \
			rm -f out.wav; \
			exit 1; \
		fi)
	rm -f reverb
	mpl -output reverb main.mpl.mlb
	./reverb @mpl procs 2 -- waltz.wav
	@(diff out.wav out.wav.ok 2>&1; \
		if [ $$? -eq 0 ]; then \
			echo "mpl ok"; \
			rm -f out.wav; \
		else \
			echo "mpl PROBLEM"; \
			rm -f out.wav; \
			exit 1; \
		fi)
	rm -f reverb

.PHONY: clean
clean:
	rm -f reverb out.wav
