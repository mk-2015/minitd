# =============================================================
# libs/Makefile — auto-discovers every library under src/ and
# builds it independently into lib/<name>.a and lib/<name>.so
#
# Expected layout:
#   libs/src/<libname>/*.c        e.g. libs/src/libunotif/*.c
#   libs/include/<libname>/*.h    public headers (your convention)
#   libs/obj/<libname>/*.o        generated
#   libs/lib/<libname>.a          generated (static)
#   libs/lib/<libname>.so         generated (shared)
#
# Adding a new library = adding a new directory under src/.
# Nothing here needs to be edited.
# =============================================================

CC      := gcc
AR      := ar
ARFLAGS := rcs

# -fPIC costs nothing for the .a build and is required for .so
CFLAGS  := -Wall -Wextra -O2 -fPIC -Iinclude

SRC_DIR := src
OBJ_DIR := obj
LIB_DIR := lib

# Each top-level directory under src/ is treated as one library.
LIB_NAMES := $(notdir $(wildcard $(SRC_DIR)/*))

STATIC_TARGETS := $(patsubst %,$(LIB_DIR)/%.a,$(LIB_NAMES))
SHARED_TARGETS := $(patsubst %,$(LIB_DIR)/%.so,$(LIB_NAMES))

.PHONY: all static shared clean list

all: static

static: $(STATIC_TARGETS)

shared: $(SHARED_TARGETS)

list:
	@echo "Discovered libraries: $(LIB_NAMES)"

define LIB_RULES
SRCS_$(1) := $$(wildcard $(SRC_DIR)/$(1)/*.c)
OBJS_$(1) := $$(patsubst $(SRC_DIR)/$(1)/%.c,$(OBJ_DIR)/$(1)/%.o,$$(SRCS_$(1)))

$(OBJ_DIR)/$(1)/%.o: $(SRC_DIR)/$(1)/%.c
	@mkdir -p $$(dir $$@)
	$$(CC) $$(CFLAGS) -c $$< -o $$@

$(LIB_DIR)/$(1).a: $$(OBJS_$(1))
	@mkdir -p $(LIB_DIR)
	$$(AR) $$(ARFLAGS) $$@ $$^

$(LIB_DIR)/$(1).so: $$(OBJS_$(1))
	@mkdir -p $(LIB_DIR)
	$$(CC) -shared -o $$@ $$^
endef

$(foreach lib,$(LIB_NAMES),$(eval $(call LIB_RULES,$(lib))))

clean:
	rm -rf $(OBJ_DIR) $(LIB_DIR)
