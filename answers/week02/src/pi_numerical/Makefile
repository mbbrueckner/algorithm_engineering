CXX = g++-16
CXXFLAGS = -fopenmp

BUILD_DIR = build
SOURCES = pi_numerical_integration.cpp pi_numerical_integration_omp_for.cpp 
TARGETS = $(patsubst %.cpp,$(BUILD_DIR)/%,$(SOURCES))

.PHONY: all clean

all: $(TARGETS) $(OPT_TARGETS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/pi_numerical_integration: pi_numerical_integration.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/pi_numerical_integration_omp_for: pi_numerical_integration_omp_for.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

clean:
	rm -rf $(BUILD_DIR)
