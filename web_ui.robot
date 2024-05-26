*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn

*** Variables ***
${BROWSER}          chrome
${URL}              http://localhost:8000
${EXPECTED_CPUS}    4

*** Test Cases ***
Verify Number of CPUs
    [Documentation]    This test case demonstrates reading data from a web page and verifying it against an expected value.
    [Tags]    webui    selenium

    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    # Read the number of CPUs from the web page
    ${cpu_info}=    Get Text    id=cpu-info
    Log    CPU Information: ${cpu_info}

    # Extract the number of CPUs from the text
    ${cpu_count}=    Evaluate    re.search(r'Number of CPUs: (\\d+)', '''${cpu_info}''').group(1)    re
    Log    CPU Count: ${cpu_count}

    # Verify the number of CPUs against the expected value
    Should Be Equal As Numbers    ${cpu_count}    ${EXPECTED_CPUS}

    # Cleanup
    Close Browser
