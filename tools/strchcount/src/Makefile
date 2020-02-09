# Alternative GNU Make project makefile generated manualy by me

ifndef config
  config=release_x86
endif

ifndef verbose
  SILENT = @
endif

.PHONY: clean strchcount

SHELLTYPE := posix
ifeq (.exe,$(findstring .exe,$(ComSpec)))
	SHELLTYPE := msdos
endif

# Configurations
# #############################################

ifeq ($(origin CC), default)
  CC = clang
endif
ifeq ($(origin CXX), default)
  CXX = clang++
endif
ifeq ($(origin AR), default)
  AR = ar
endif
INCLUDES +=
FORCE_INCLUDE +=
ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
LINKCMD = $(CC) $(ALL_LDFLAGS) -o "$@" $(OBJECTS) $(RESOURCES) $(LIBS)
define PREBUILDCMDS
endef
define PRELINKCMDS
endef
define POSTBUILDCMDS
endef

ifeq ($(config),release_x86)
TARGETDIR = ../bin/release
TARGET = $(TARGETDIR)/strchcount.exe
OBJDIR = obj/x86/Release
DEFINES +=
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -flto -O3 -Wall -Wextra
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -flto -O3 -Wall -Wextra -fno-stack-protector
LIBS +=
LDDEPS +=
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib32 -m32 -flto

else ifeq ($(config),debug_x86)
TARGETDIR = ../bin/debug
TARGET = $(TARGETDIR)/strchcount.exe
OBJDIR = obj/x86/Debug
DEFINES +=
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -g -Wall -Wextra
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -g -Wall -Wextra
LIBS +=
LDDEPS +=
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib32 -m32

else ifeq ($(config),release_x64)
TARGETDIR = ../bin/release
TARGET = $(TARGETDIR)/strchcount.exe
OBJDIR = obj/x64/Release
DEFINES +=
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -flto -O3 -Wall -Wextra
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -flto -O3 -Wall -Wextra -fno-stack-protector
LIBS +=
LDDEPS +=
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64 -flto

else ifeq ($(config),debug_x64)
TARGETDIR = ../bin/debug
TARGET = $(TARGETDIR)/strchcount.exe
OBJDIR = obj/x64/Debug
DEFINES +=
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -g -Wall -Wextra
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -g -Wall -Wextra
LIBS +=
LDDEPS +=
ALL_LDFLAGS += $(LDFLAGS) -L/usr/lib64 -m64

endif

# Per File Configurations
# #############################################


# File sets
# #############################################

OBJECTS :=

OBJECTS += $(OBJDIR)/main.o

# Rules
# #############################################

all: $(TARGET)
	@:

# HOST_PLATFORM= none

# default: $(HOST_PLATFORM)

# none:
# 	@echo "Please do"
# 	@echo "   make HOST_PLATFORM"
# 	@echo "where HOST_PLATFORM is one of these:"
# 	@echo "   osx linux mingw"

$(TARGET): $(OBJECTS) $(LDDEPS) | $(TARGETDIR)
	$(PRELINKCMDS)
	@echo Linking strchcount
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

$(TARGETDIR):
	@echo Creating $(TARGETDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(TARGETDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(TARGETDIR))
endif

$(OBJDIR):
	@echo Creating $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif

clean:
	@echo Cleaning strchcount
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
	$(SILENT) rm -rf $(OBJDIR)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild: | $(OBJDIR)
	$(PREBUILDCMDS)

ifneq (,$(PCH))
$(OBJECTS): $(GCH) | $(PCH_PLACEHOLDER)
$(GCH): $(PCH) | prebuild
	@echo $(notdir $<)
	$(SILENT) $(CC) -x c-header $(ALL_CFLAGS) -o "$@" -MF "$(@:%.gch=%.d)" -c "$<"
$(PCH_PLACEHOLDER): $(GCH) | $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) touch "$@"
else
	$(SILENT) echo $null >> "$@"
endif
else
$(OBJECTS): | prebuild
endif


# File Rules
# #############################################

$(OBJDIR)/main.o: main.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(PCH_PLACEHOLDER).d
endif