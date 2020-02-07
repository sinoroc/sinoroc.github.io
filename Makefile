#


source_dir := src
build_dir := build


rst_files := $(wildcard $(source_dir)/*.rst)
html_files := $(patsubst $(source_dir)/%.rst,$(build_dir)/%.html,$(rst_files))


scss_files := $(wildcard $(source_dir)/*.scss)
css_files := $(patsubst $(source_dir)/%.scss,$(build_dir)/%.css,$(scss_files))


rst2sh5_options := --strict --strip-comments
rst2sh5_options += --initial-header-level=2
rst2sh5_options += --link-stylesheet --stylesheet-dirs='$(build_dir)'
rst2sh5_options += --stylesheet-path='style.css'


vpath %.rst $(source_dir)
vpath %.scss $(source_dir)


.DEFAULT_GOAL := all


.PHONY: all
all: $(css_files) $(html_files)


$(build_dir)/%.html: %.rst | $(build_dir)
	rst2sh5 $(rst2sh5_options) $< $@


$(build_dir)/%.css: %.scss | $(build_dir)
	sassc $(sassc_options) $< $@


$(build_dir):
	mkdir --parent $@


.PHONY: clean
clean:
	$(RM) $(html_files)


# Disable default rules and suffixes
# (improve speed and avoid unexpected behaviour)
MAKEFLAGS := --no-builtin-rules
.SUFFIXES:


# EOF
