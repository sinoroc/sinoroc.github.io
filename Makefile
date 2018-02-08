#


toxenvname ?= unknown


source_dir := src
build_dir := build


rst_files := $(wildcard $(source_dir)/*.rst)
html_files := $(patsubst $(source_dir)/%.rst,$(build_dir)/%.html,$(rst_files))


options := --no-doc-title --no-section-subtitles --strict --strip-comments
options += --stylesheet=


vpath %.rst $(source_dir)


.DEFAULT_GOAL := all


.PHONY: all
all: $(html_files)


.PHONY: nothing
nothing:
	true


$(build_dir)/%.html: %.rst | $(build_dir)
	rst2sh5 $(options) $< $@


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
