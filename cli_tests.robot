*** Settings ***
Resource     ./resources/keywords.robot
Resource     ./resources/variables.robot

Suite Setup    Setup Suite
Suite Teardown    Teardown Suite
Test Setup    Setup Test
Test Teardown    Teardown Test


*** Test Cases ***
Create and List Directory
    [Documentation]    Create a directory and verify its existence by listing contents.
    [Tags]    directory    create   unit
    Create Directory    ${TEST_DIR}
    List Directory Contents    ${TEST_DIR}

Create and Verify File
    [Documentation]    Create a file and verify its content.
    [Tags]    file    create    functional
    Create File    ${TEST_DIR}/${FILE_NAME}    ${CONTENT}
    Verify File Content    ${TEST_DIR}/${FILE_NAME}    ${CONTENT}

Execute Sudo Command
    [Documentation]    Execute a command with sudo privileges.
    [Tags]    sudo    command   unit
    Execute Sudo Command    apt-get update

Parameterized Test Case
    [Documentation]    Run the same test with different parameters.
    [Tags]    parameterized     functional
    FOR    ${count}    IN RANGE    1    4
       Create And Verify Multiple Files    ${TEST_DIR}/file_${count}.txt    Content ${count}
    END


Error Handling Example
    [Documentation]    Demonstrate error handling in Robot Framework.
    [Tags]    error    handling     negative
    Run Keyword And Expect Error    *No such file or directory*    List Directory Contents    /invalid/path

*** Keywords ***
Connect To Remote Host
    [Documentation]    Connect to the remote host via SSH.
    Open Connection    ${SSH_HOST}
    Login    ${SSH_USERNAME}    ${SSH_PASSWORD}

Create Directory
    [Arguments]    ${dir_path}
    [Documentation]    Create a directory on the remote host.
    ${output}=    Execute Command    mkdir -p ${dir_path}
    Log    Directory created: ${dir_path}    DEBUG

List Directory Contents
    [Arguments]    ${dir_path}
    [Documentation]    List the contents of a directory on the remote host.
    ${output}=    Execute Command    ls -la ${dir_path}
    Log    Directory contents: ${output}    INFO

Create File
    [Arguments]    ${file_path}    ${content}
    [Documentation]    Create a file with specified content on the remote host.
    ${output}=    Execute Command    echo ${content} > ${file_path}
    Log    File created: ${file_path} with content: ${content}    DEBUG

Verify File Content
    [Arguments]    ${file_path}    ${expected_content}
    [Documentation]    Verify the content of a file on the remote host.
    ${output}=    Execute Command    cat ${file_path}
    Should Be Equal    ${output.strip()}    ${expected_content}
    Log    File content verified: ${expected_content}    INFO

Execute Sudo Command
    [Arguments]    ${command}
    [Documentation]    Execute a command with sudo privileges on the remote host.
    ${output}=    Execute Command    echo ${SUDO_PASSWORD} | sudo -S ${command}
    Log    Sudo command output: ${output}    INFO

Create And Verify Multiple Files
    [Arguments]    ${file_path}    ${content}
    [Documentation]    Create and verify files with different parameters.
    Create File    ${file_path}    ${content}
    Verify File Content    ${file_path}    ${content}

Setup Suite
    [Documentation]    Suite-level setup.
    Log    Suite setup started.    INFO
    # Add any suite-level setup here

Teardown Suite
    [Documentation]    Suite-level teardown.
    Log    Suite teardown completed.    INFO
    # Add any suite-level teardown here

Setup Test
    [Documentation]    Test-level setup.
    Log    Test setup started.    INFO
    Connect To Remote Host

Teardown Test
    [Documentation]    Test-level teardown.
    Log    Test teardown completed.    INFO
    Close Connection

Close Connection
    [Documentation]    Close the SSH connection.
    Close All Connections
