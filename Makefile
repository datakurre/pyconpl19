TEXFILE ?= slides

all: $(TEXFILE).pdf

$(TEXFILE).nav: $(TEXFILE).tex
	@latexmk -shell-escape -quiet $(TEXFILE)

$(TEXFILE).pdf: $(TEXFILE).tex images
	@latexmk -pdf -recorder -interaction=nonstopmode -shell-escape -use-make -quiet $(TEXFILE)

watch:
	@latexmk -pvc -pdf -recorder -interaction=nonstopmode -shell-escape -use-make $(TEXFILE)

clean:
	@latexmk -C -quiet
	@rm -f *.nav *.snm *.fls *.vrb _minted-$(TEXFILE)/*
	@if [ -d _minted-$(TEXFILE) ]; then rmdir _minted-$(TEXFILE); fi

.PHONY: all clean notebook watch

###

images: images/logo.eps

images/logo.eps:
	@mkdir -p images
	curl https://www.jyu.fi/yliopistopalvelut/viestinta/logot/eps-tiedostot/jyu-logo-cmyk_teksti-oikealla.eps -o images/logo.eps
