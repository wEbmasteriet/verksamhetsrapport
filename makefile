AUXDIR    := aux
OUTDIR    := output
PLOTDIR   := plots

TEXFILES  := rapport.tex
DRAFTMODE := #-draftmode
TEXMKARGS := -emulate-aux-dir -auxdir=$(AUXDIR) -outdir=$(OUTDIR) -lualatex

watch: $(PLOTDIR) $(TEXFILES)
	@latexmk \
		$(TEXMKARGS) \
		-halt-on-error \
		-shell-escape \
		-pvc \
		$(DRAFTMODE) \
		-view=none \
		$(TEXFILES)

rapport.pdf: $(PLOTDIR) $(TEXFILES)
	@latexmk \
		$(TEXMKARGS) \
		-halt-on-error \
		-shell-escape \
		$(TEXFILES)

$(PLOTDIR):
	@mkdir $@

clean:
	find $(PLOTDIR) -type f -delete
	rm -rf $(AUXDIR) $(OUTDIR)
	rm -f rapport.pdf
	latexmk $(TEXMKARGS) -quiet -norc -rc-report- -c

distclean:
	rm -f $(shell sed -n '/^[*]\.[[:alnum:]][[:alnum:]]*$$/p' .gitignore)
	rm -rf $(PLOTDIR) $(AUXDIR) $(OUTDIR)
	rm -f rapport.pdf
	latexmk $(TEXMKARGS) -quiet -norc -rc-report- -C

_PHONY: clean distclean watch
