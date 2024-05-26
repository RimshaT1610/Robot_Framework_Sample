# Robot Framework Sample Suite for Test Automation

## Introduction

This project showcases the versatility of the Robot Framework for test automation. It includes a variety of tests ranging from CLI operations to web UI tests and repetitive tasks, highlighting the framework's rich reporting and logging features.

## Project Structure

robot-framework-sample-suite/
├── tests/
│ ├── cli_tests.robot
│ ├── web_ui_tests.robot
├── resources/
│ ├── keywords.robot
│ ├── variables.robot
├── results/
│ └── (will contain the generated reports and logs)
├── README.md
├── requirements.txt
├── webpage (sample webpage to be hosted to test webui tests)


## Setup

### Prerequisites

- Python 3.x
- pip
- SSH access to a remote host (if running the included SSH tests)

### Installation

1. **Clone the repository**:

    ```bash
    git clone https://github.com/RimshaT1610/Robot_Framework_Sample.git
    cd robot-framework-sample-suite
    ```

2. **Install dependencies**:

    ```bash
    pip install -r requirements.txt
    ```

### Configuration

Update the following variables in the test suite files with your specific details:

- `${SSH_HOST}`
- `${SSH_USERNAME}`
- `${SSH_PASSWORD}`
- `${SUDO_PASSWORD}`

## Running the Tests

Execute the tests and generate reports using the following command:

```bash
robot -d results tests/
