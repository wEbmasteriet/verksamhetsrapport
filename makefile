AUXDIR    := aux
OUTDIR    := output

TEXFILES  := rapport.tex
DRAFTMODE := #-draftmode
TEXMKARGS := -emulate-aux-dir -auxdir=$(AUXDIR) -outdir=$(OUTDIR) -lualatex

watch: $(TEXFILES)
	@latexmk \
		$(TEXMKARGS) \
		-halt-on-error \
		-shell-escape \
		-pvc \
		$(DRAFTMODE) \
		-view=none \
		$(TEXFILES)

rapport.pdf: $(TEXFILES)
	@latexmk \
		$(TEXMKARGS) \
		-halt-on-error \
		-shell-escape \
		$(TEXFILES)

clean:
	latexmk $(TEXMKARGS) -quiet -norc -rc-report- -c
	rm -f rapport.pdf
	rm -rf $(AUXDIR) $(OUTDIR)

distclean:
	latexmk $(TEXMKARGS) -quiet -norc -rc-report- -C
	rm -f $(shell sed -n '/^[*]\.[[:alnum:]][[:alnum:]]*$$/p' .gitignore)
	rm -f rapport.pdf
	rm -rf $(AUXDIR) $(OUTDIR)

_PHONY: clean distclean watch
