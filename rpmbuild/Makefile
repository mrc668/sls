# Target file
TARGET = init.sls

# Find all .sls files except init.sls
# $(shell ...) is used to get a clean list from the filesystem
SOURCES := $(shell ls *.sls 2>/dev/null | grep -v $(TARGET))
Salt_Dir := $(shell pwd | cut -d/ -f4- )

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(SOURCES)
	@echo "### Auto-generating $(TARGET) ###"
	@echo "include:" > $(TARGET)
	@for file in $(SOURCES); do \
		echo "  - $(Salt_Dir)/`basename $$file .sls`" >> $(TARGET); \
	done
	@echo "### Done. Created include for: $(SOURCES) ###"

clean:
	rm -f $(TARGET)
